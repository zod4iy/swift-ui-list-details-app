import Foundation
import Combine

final class ListViewModel: ObservableObject {
  enum State {
    case initial
    case loading
    case failed(String)
    //case loaded([Item])
    case loaded
  }

  @Published var state = State.initial
  @Published var items: [Item]
  
  private var repository: ListRepositoryProtocol?
  private var cancelBag: Set<AnyCancellable> = []
//  private var items: [Item]?
  
  init(
    repository: ListRepositoryProtocol? = nil,
    state: State = .initial,
    items: [Item] = []
  ) {
    self.repository = repository
    self.state = state
    self.items = items
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
            self?.state = .loaded
          }
        )
        .store(in: &cancelBag)
    }
  }
  
  
  func removeFromFavourites(itemID: UUID) {
    items.first(where: { $0.id == itemID})?.isFavourite = false
  }
  
  func addToFavourites(itemID: UUID) {
    items.first(where: { $0.id == itemID})?.isFavourite = true
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
