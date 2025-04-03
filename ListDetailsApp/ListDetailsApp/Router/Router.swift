import SwiftUI

class Router: ObservableObject {
  static var shared: Router = Router()
  
  @Published var path = NavigationPath()
  
  private init() {}
  
  func push(route: RoutePath) {
    path.append(route)
  }
  
  func pop() {
    path.removeLast()
  }
}
