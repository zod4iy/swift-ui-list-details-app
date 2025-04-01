import Foundation
import Combine

class DetailsDataProviderImpl: DetailsDataProviderProtocol {
  func fetchItemDetails(id: UUID) async -> Future<ItemDetails, DetailsDataError> {
    do {
      // TODO: - Call Network service method to fetch items
      
      try await Task.sleep(nanoseconds: NSEC_PER_SEC * 1)
      
      return Future<ItemDetails, DetailsDataError> { promise in
        promise(.success(ItemDetails(
          id: id,
          title: "Title",
          subtitle: "Subtitle",
          isFavourite: false,
          description: "This is a long long long long description"
        )))
      }
      
    } catch let error {
      return Future<ItemDetails, DetailsDataError> { promise in
        promise(.failure(DetailsDataError(
          errorMessage: DetailsDataError.defaultMessage))
        )
      }
    }
  }
}
