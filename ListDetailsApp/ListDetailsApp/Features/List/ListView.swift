import SwiftUI

struct ListView: View {
  @ObservedObject var viewModel: ListViewModel
  
  var body: some View {
    NavigationStack {
      switch viewModel.state {
      case.loaded(let items):
        List {
          ForEach(items) { item in
            NavigationLink(
              destination: DetailsView(viewModel: .init(
                id: item.id,
                repository: DetailsRepository(
                  dataProvider: DetailsDataProvider()
                ),
                state: .initial,
                onAddToFavourites: { id in
                  viewModel.addToFavourites(itemID: id)
                },
                onRemoveFromFavourites: { id in
                  viewModel.removeFromFavourites(itemID: id)
                }
              )),
              label: {
                Label(
                  item.title,
                  systemImage:
                    item.isFavourite ? "heart.fill" : "heart"
                )
              }
            )
          }
        }
        .navigationTitle("Items")
      case .initial:
        ProgressView()
          .progressViewStyle(
            CircularProgressViewStyle(tint: .blue)
          )
          .scaleEffect(2.0, anchor: .center)
      case .loading:
        ProgressView()
          .progressViewStyle(
            CircularProgressViewStyle(tint: .blue)
          )
          .scaleEffect(2.0, anchor: .center)
      case .failed(let error):
        Text(error)
      }
    }
    .task {
      await viewModel.fetchListItems()
    }
  }
}

#Preview {
  ListView(
    viewModel: .init(
      //      state: .initial,
      //      state: .loading,
      //      state: .failed("Fetch list items error occurs!")
            state: .loaded([
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
            ])
    )
  )
}
