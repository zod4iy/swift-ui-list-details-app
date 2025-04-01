import SwiftUI

struct DetailsView: View {
  @ObservedObject var viewModel: DetailsViewModel
  
  var body: some View {
    NavigationStack {
      switch viewModel.state {
      case.loaded(let details):
        VStack {
          VStack(alignment: .leading) {
            Text(details.title)
              .font(.largeTitle)
            Text(details.subtitle)
              .font(.title2)
            Divider()
            Text(details.description)
          }
          Spacer()
          details.isFavourite
            ? Button("Remove from favourites") {
              viewModel.removeFromFavourites(itemID: details.id)
            }
            : Button("Add to favourite") {
              viewModel.addToFavourites(itemID: details.id)
            }
        }
        .padding()
        .navigationTitle("Item Details")
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
    }.task {
      await viewModel.fetchItemDetails()
    }
  }
}

#Preview {
  let id = UUID()
  DetailsView(viewModel: .init(
    id: id,
    state: .loaded(ItemDetails(
      id: id,
      title: "Title",
      subtitle: "Subtitle",
      isFavourite: false,
      description: "This is a long long long long description"
    ))
  ))
}
