import Foundation

protocol ListDataProviderProtocol {
  func fetchListItems() async throws -> [Item]
}

protocol ListRepositoryProtocol {
  var dataProvider: ListDataProviderProtocol { get }
}

class ListRepository: ListRepositoryProtocol {
  let dataProvider: ListDataProviderProtocol
  
  init(dataProvider: ListDataProviderProtocol) {
    self.dataProvider = dataProvider
  }
  
  func fetchListItems() async throws -> [Item] {
    do {
      return try await dataProvider.fetchListItems()
    } catch {
      throw ListDataError.unknown
    }
  }
}

enum ListDataError: Error {
  case unknown
}
