import Foundation

enum Routes: Equatable {
  case details(ListViewModel, Item)
  case error_screen(Error)
  case none
  
  static func == (lhs: Routes, rhs: Routes) -> Bool {
    switch (lhs, rhs) {
    case (.details, .details),
         (.none, .none):
      return true
      
    case let (.error_screen(error1), .error_screen(error2)):
      return error1.localizedDescription == error2.localizedDescription
      
    default:
      return false
    }
  }
}
