import Foundation

class DetailsDataProvider: DetailsDataProviderProtocol {
  func fetchItemDetails(id: UUID) async throws -> ItemDetails {
    do {
      try await Task.sleep(for: .seconds(1))
      return ItemDetails(
        id: id,
        title: "Title",
        subtitle: "Subtitle",
        isFavourite: false,
        description: "This is a long long long long description"
      )
      
    } catch let error {
      throw error
    }
  }
}
