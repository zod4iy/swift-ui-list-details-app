import Foundation

class DetailsDataProvider: DetailsDataProviderProtocol {
  func fetchItemDetails(item: Item) async throws -> ItemDetails {
    do {
      try await Task.sleep(for: .seconds(1))
      return ItemDetails(
        id: item.id,
        title: item.title,
        subtitle: item.subtitle,
        isFavourite: item.isFavourite,
        description: "This is a long long long long description"
      )
      
    } catch let error {
      throw error
    }
  }
}
