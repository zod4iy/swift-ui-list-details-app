import Foundation

protocol DetailsDataProviderProtocol {
  func fetchItemDetails(item: Item) async throws -> ItemDetails
}

protocol DetailsRepositoryProtocol {
  var dataProvider: DetailsDataProviderProtocol { get }
}

class DetailsRepository: DetailsRepositoryProtocol {
  let dataProvider: DetailsDataProviderProtocol
  
  init(dataProvider: DetailsDataProviderProtocol) {
    self.dataProvider = dataProvider
  }
  
  func fetchItemDetails(item: Item) async throws -> ItemDetails {
    do {
      return try await dataProvider.fetchItemDetails(item: item)
    } catch {
      throw DetailsDataError.uknown
    }
  }
}

enum DetailsDataError: Error {
  case uknown
}
