import Foundation

final class ListViewModel: ObservableObject {
  enum State {
    case initial
    case loading
    case failed(String)
    case loaded([Item])
  }

  @Published var state: State
  
  private let repository: ListRepositoryProtocol?
  private var items: [Item]?
  

  init(
    repository: ListRepositoryProtocol? = nil,
    state: State = .initial
  ) {
    self.repository = repository
    self.state = state
  }
  
  @MainActor
  func fetchListItems() async {
    state = .loading
    
    do {
      let items = try await repository?.dataProvider.fetchListItems() ?? []
      state = .loaded(items)
      self.items = items
    } catch {
      state = .failed("Something went wrong")
    }
  }

  private func removeFromFavourites(itemID: UUID) {
    guard let items = self.items else { return }
    items.first(where: { $0.id == itemID})?.isFavourite = false
    
    state = .loaded(items)
  }
  
  private func addToFavourites(itemID: UUID) {
    guard let items = self.items else { return }
    items.first(where: { $0.id == itemID})?.isFavourite = true
    
    state = .loaded(items)
  }
  
  func onItemTapped(item: Item) {
    Router.shared
      .push(route: RoutePath(
          .details(item) { [weak self] action in
            switch action {
            case .addToFavorites:
              self?.addToFavourites(itemID: item.id)
            case .removeFromFavorites:
              self?.removeFromFavourites(itemID: item.id)
            }
          }
        )
      )
  }
}

extension ListViewModel {
  static let mockItems = [
    Item(
      id: UUID(),
      title: "Mock 1 title",
      subtitle: "Mock 1 subtitle",
      isFavourite: false
    ),
    Item(
      id: UUID(),
      title: "Mock 2 title",
      subtitle: "Mock 2 subtitle",
      isFavourite: true
    ),
  ]
}
