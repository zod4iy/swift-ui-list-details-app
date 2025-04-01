import Foundation
import Combine

protocol DetailsDataProviderProtocol {
  func fetchItemDetails(id: UUID) async -> Future<ItemDetails, DetailsDataError>
}

protocol DetailsRepositoryProtocol {
  var dataProvider: DetailsDataProviderProtocol { get }
}

class DetailsRepository: DetailsRepositoryProtocol {
  let dataProvider: DetailsDataProviderProtocol
  
  init(dataProvider: DetailsDataProviderProtocol) {
    self.dataProvider = dataProvider
  }
  
  func fetchItemDetails(id: UUID) async -> Future<ItemDetails, DetailsDataError> {
    await dataProvider.fetchItemDetails(id: id)
  }
}

struct DetailsDataError: Error {
  static let defaultMessage = "Fetch item details error occurs!"
  
  let errorMessage: String
}
