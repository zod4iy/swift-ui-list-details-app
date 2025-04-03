import Foundation

enum Routes: Equatable {
  case details(Item, aciton: (DetailsViewModel.Action) -> Void)
  case error(Error)
  case unknown
  
  static func == (lhs: Routes, rhs: Routes) -> Bool {
    switch (lhs, rhs) {
    case (.details, .details),
         (.unknown, .unknown):
      return true
      
    case let (.error(error1), .error(error2)):
      return error1.localizedDescription == error2.localizedDescription
      
    default:
      return false
    }
  }
}
