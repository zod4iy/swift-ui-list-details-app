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
        description: """
          Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
        """
      )
      
    } catch let error {
      throw error
    }
  }
}
