import SwiftUI

struct NavigationRouteView: View {
  @ObservedObject var router = Router.shared
  
  var body: some View {
    NavigationStack(path: $router.path) {
      ListView(viewModel: router.rootViewModel)
        .onFirstAppear {
          Task {
            await router.rootViewModel.fetchListItems()
          }
        }
        .navigationDestination(
          for: RoutePath.self,
          destination: { route in
            switch route.route {
            case .details(let listViewModel, let item):
              DetailsView(viewModel: .init(
                item: item,
                repository: DetailsRepository(
                  dataProvider: DetailsDataProvider()
                ),
                state: .initial,
                onAddToFavourites: { id in
                  listViewModel.addToFavourites(itemID: id)
                },
                onRemoveFromFavourites: { id in
                  listViewModel.removeFromFavourites(itemID: id)
                }
              ))
            case .error_screen(let error):
              Text("Some error screen \(error.localizedDescription)")
            case .none:
              Text("no route")
            }
          }
        )
    }
  }
}

#Preview {
  NavigationRouteView()
}
