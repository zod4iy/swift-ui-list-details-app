import Foundation
import Combine

protocol ListDataProviderProtocol {
  func fetchListItems() async -> Future<[Item], ListDataError>
}

protocol ListRepositoryProtocol {
  var dataProvider: ListDataProviderProtocol { get }
}

class ListRepository: ListRepositoryProtocol {
  let dataProvider: ListDataProviderProtocol
  
  init(dataProvider: ListDataProviderProtocol) {
    self.dataProvider = dataProvider
  }
  
  func fetchListItems() async -> Future<[Item], ListDataError> {
    await dataProvider.fetchListItems()
  }
}

struct ListDataError: Error {
  static let defaultMessage = "Fetch list items error occurs!"
  
  let errorMessage: String
}
