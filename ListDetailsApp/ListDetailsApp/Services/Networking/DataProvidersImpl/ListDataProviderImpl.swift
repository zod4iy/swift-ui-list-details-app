import Foundation
import Combine

class ListDataProviderImpl: ListDataProviderProtocol {
  func fetchListItems() async -> Future<[Item], ListDataError> {
    do {
      // TODO: - Call Network service method to fetch items
      
      try await Task.sleep(nanoseconds: NSEC_PER_SEC * 1)
      
      return Future<[Item], ListDataError> { promise in
        promise(.success([
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
          ),
        ]))
      }
      
    } catch let error {
      return Future<[Item], ListDataError> { promise in
        promise(.failure(ListDataError(
          errorMessage: ListDataError.defaultMessage))
        )
      }
    }
  }
}
