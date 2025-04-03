import Foundation
import SwiftUI

struct RoutePath: Hashable {
  var route: Routes = .unknown
  var hashValue = { UUID().uuid }
  
  init(_ route: Routes) {
    self.route = route
  }
  
  func hash(into hasher: inout Hasher) {
    hasher.combine(hashValue)
  }
  
  static func == (lhs: RoutePath, rhs: RoutePath) -> Bool {
    lhs.route == rhs.route
  }
}

class Router: ObservableObject {
  static var shared: Router = Router()
  
  var rootViewModel: ListViewModel = .init(
    repository: ListRepository(
      dataProvider: ListDataProvider()
    )
  )
  
  @Published var path = NavigationPath()
  
  func push(route: RoutePath) {
    path.append(route)
  }
  
  func pop() {
    path.removeLast()
  }
  
  private init() {}
}
