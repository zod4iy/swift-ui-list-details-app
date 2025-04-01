import Foundation

class ListDataProviderImpl: ListDataProviderProtocol {
  func fetchListItems() async throws -> [Item] {
    do {
      try await Task.sleep(for: .seconds(1))
      return [
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
        )
      ]
    } catch let error {
      throw error
    }
  }
}
