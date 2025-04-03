import SwiftUI

struct NavigationRouteView: View {
  @ObservedObject var router = Router.shared
  
  @StateObject var listViewModel = ListViewModel.init(
    repository: ListRepository(
      dataProvider: ListDataProvider()
    )
  )
  
  var body: some View {
    NavigationStack(path: $router.path) {
      ListView(viewModel: listViewModel)
        .onFirstAppear {
          Task {
            await listViewModel.fetchListItems()
          }
        }
        .navigationDestination(
          for: RoutePath.self,
          destination: { route in
            switch route.route {
            case .details(let item, let action):
              DetailsView(viewModel: .init(
                item: item,
                repository: DetailsRepository(
                  dataProvider: DetailsDataProvider()
                ),
                state: .initial,
                action: action
              ))
            case .error(let error):
              Text("Error: \(error.localizedDescription)")
            case .unknown:
              Text("Unknown")
            }
          }
        )
    }
  }
}

#Preview {
  NavigationRouteView()
}
