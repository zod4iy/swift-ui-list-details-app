import Foundation
import Combine

class DetailsViewModel: ObservableObject {
  enum State {
    case initial(UUID)
    case loading
    case failed(String)
    case loaded(ItemDetails)
  }

  @Published var state: State
  var onAddToFavourites: (UUID) -> Void
  var onRemoveFromFavourites: (UUID) -> Void
  
  
  private var repository: DetailsRepositoryProtocol?
  private var cancelBag: Set<AnyCancellable> = []
  private var itemDetails: ItemDetails?
  
  init(
    repository: DetailsRepositoryProtocol? = nil,
    state: State,
    onAddToFavourites: @escaping (UUID) -> Void = { _ in },
    onRemoveFromFavourites: @escaping (UUID) -> Void = { _ in }
  ) {
    self.repository = repository
    self.state = state
    self.onAddToFavourites = onAddToFavourites
    self.onRemoveFromFavourites = onRemoveFromFavourites
  }
  
  @MainActor
  func fetchItemDetails(id: UUID) async {
    state = .loading
    
    Task {
      await repository?.dataProvider.fetchItemDetails(id: id)
        .mapError({ [weak self] detailsDataError in
          self?.state = .failed(detailsDataError.errorMessage)
          return detailsDataError
        })
        .sink(
          receiveCompletion: { error in  },
          receiveValue: { [weak self] itemDetails in
            self?.itemDetails = itemDetails
            self?.state = .loaded(itemDetails)
          }
        )
        .store(in: &cancelBag)
    }
  }
  
  func removeFromFavourites(itemID: UUID) {
    // TODO: - add endpoint for the POST request
    // and use repository?.dataProvider.removeFromFavourites(id: id)
    
    guard let itemDetails = self.itemDetails else { return }
    
    itemDetails.isFavourite = false
    state = .loaded(itemDetails)
    
    onRemoveFromFavourites(itemID)
  }
  
  func addToFavourites(itemID: UUID) {
    // TODO: - add endpoint for the POST request
    // and use repository?.dataProvider.removeFromFavourites(id: id)
    
    guard let itemDetails = self.itemDetails else { return }
    
    itemDetails.isFavourite = true
    state = .loaded(itemDetails)
    
    onAddToFavourites(itemID)
  }
}

extension ListViewModel {
  static let mockItemDetails = ItemDetails(
    id: UUID(),
    title: "Mock 1 title",
    subtitle: "Mock 1 subtitle",
    isFavourite: false,
    description: "This is a long long long long description"
  )
}
