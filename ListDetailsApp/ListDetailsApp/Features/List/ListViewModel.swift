import Foundation
import Combine

final class ListViewModel: ObservableObject {
  enum State {
    case initial
    case loading
    case failed(String)
    case loaded([Item])
  }

  @Published var state = State.initial
  
  private var repository: ListRepositoryProtocol?
  private var cancelBag: Set<AnyCancellable> = []
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
    
    Task {
      await repository?.dataProvider.fetchListItems()
        .mapError({ [weak self] listDataError in
          self?.state = .failed(listDataError.errorMessage)
          return listDataError
        })
        .sink(
          receiveCompletion: { error in  },
          receiveValue: { [weak self] itemList in
            self?.items = itemList
            self?.state = .loaded(itemList)
          }
        )
        .store(in: &cancelBag)
    }
  }
  
  
  func removeFromFavourites(itemID: UUID) {
    guard let items = self.items else { return }
    items.first(where: { $0.id == itemID})?.isFavourite = false
    
    state = .loaded(items)
  }
  
  func addToFavourites(itemID: UUID) {
    guard let items = self.items else { return }
    items.first(where: { $0.id == itemID})?.isFavourite = true
    
    state = .loaded(items)
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
