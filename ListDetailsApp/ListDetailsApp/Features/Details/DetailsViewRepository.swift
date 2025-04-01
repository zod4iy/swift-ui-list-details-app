import Foundation

protocol DetailsDataProviderProtocol {
  func fetchItemDetails(id: UUID) async throws -> ItemDetails
}

protocol DetailsRepositoryProtocol {
  var dataProvider: DetailsDataProviderProtocol { get }
}

class DetailsRepository: DetailsRepositoryProtocol {
  let dataProvider: DetailsDataProviderProtocol
  
  init(dataProvider: DetailsDataProviderProtocol) {
    self.dataProvider = dataProvider
  }
  
  func fetchItemDetails(id: UUID) async throws -> ItemDetails {
    do {
      return try await dataProvider.fetchItemDetails(id: id)
    } catch {
      throw DetailsDataError.uknown
    }
  }
}

enum DetailsDataError: Error {
  case uknown
}
