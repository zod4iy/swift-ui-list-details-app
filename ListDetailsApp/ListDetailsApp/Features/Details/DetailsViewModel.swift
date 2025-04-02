import Foundation

final class DetailsViewModel: ObservableObject {
  enum State {
    case initial
    case loading
    case failed(String)
    case loaded(ItemDetails)
  }

  @Published var state: State
  var onAddToFavourites: (UUID) -> Void
  var onRemoveFromFavourites: (UUID) -> Void
  
  
  private let repository: DetailsRepositoryProtocol?
  private var itemDetails: ItemDetails?
  private let item: Item
  
  init(
    item: Item,
    repository: DetailsRepositoryProtocol? = nil,
    state: State = .initial,
    onAddToFavourites: @escaping (UUID) -> Void = { _ in },
    onRemoveFromFavourites: @escaping (UUID) -> Void = { _ in }
  ) {
    self.item = item
    self.repository = repository
    self.state = state
    self.onAddToFavourites = onAddToFavourites
    self.onRemoveFromFavourites = onRemoveFromFavourites
  }
  
  @MainActor
  func fetchItemDetails() async {
    state = .loading
    
    do {
      if let itemDetails = try await repository?.dataProvider.fetchItemDetails(item: item) {
        self.state = .loaded(itemDetails)
        self.itemDetails = itemDetails
      }
    } catch {
      state = .failed("detailsDataError.errorMessage")
    }
  }
  
  func removeFromFavourites(itemID: UUID) {
    guard let itemDetails = self.itemDetails else { return }
    
    itemDetails.isFavourite = false
    state = .loaded(itemDetails)
    
    onRemoveFromFavourites(itemID)
  }
  
  func addToFavourites(itemID: UUID) {
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
