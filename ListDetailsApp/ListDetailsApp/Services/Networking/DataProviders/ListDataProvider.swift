import Foundation

class ListDataProvider: ListDataProviderProtocol {
  func fetchListItems() async throws -> [Item] {
    do {
      try await Task.sleep(for: .seconds(1))
      return [
        Item(
          id: UUID(),
          title: "Item 1 title",
          subtitle: "Item 1 subtitle",
          isFavourite: false
        ),
        Item(
          id: UUID(),
          title: "Item 2 title",
          subtitle: "Item 2 subtitle",
          isFavourite: true
        )
      ]
    } catch let error {
      throw error
    }
  }
}
