import SwiftUI

struct DetailsView: View {
  @ObservedObject var viewModel: DetailsViewModel
  
  var body: some View {
    switch viewModel.state {
    case.loaded(let details):
      NavigationStack {
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
      }
    case .initial(let id):
      ProgressView()
        .progressViewStyle(
          CircularProgressViewStyle(tint: .blue)
        )
        .scaleEffect(2.0, anchor: .center)
        .task {
          await viewModel.fetchItemDetails(id: id)
        }
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
}

#Preview {
  DetailsView(viewModel: .init(
    state: .loaded(ItemDetails(
      id: UUID(),
      title: "Title",
      subtitle: "Subtitle",
      isFavourite: false,
      description: "This is a long long long long description"
    ))
  ))
}
