import SwiftUI

struct DetailsView: View {
  @ObservedObject var viewModel: DetailsViewModel
  
  var body: some View {
    VStack {
      switch viewModel.state {
      case.loaded(let details):
        VStack {
          VStack(alignment: .leading) {
            HStack {
              Image(systemName: "doc")
                .foregroundColor(.white)
                .padding()
                .background(Circle().fill(Color.secondary))
              Text(details.title)
                .font(.largeTitle)
            }
            .padding(.bottom, 16.0)
            
            Text(details.subtitle)
              .font(.title2)
            Divider()
            Text(details.description)
          }
          Spacer()
          if details.isFavourite {
            PrimaryButton(
              title: "Remove from favourites",
              action: { viewModel.removeFromFavourites() }
            )
          } else {
            PrimaryButton(
              title: "Add to favourites",
              backgroundColor: .green,
              action: { viewModel.addToFavourites() }
            )
          }
        }
        .padding()
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
    item: Item(
      id:  id,
      title: "Title",
      subtitle: "Subtitle",
      isFavourite: false
    ),
    state: .loaded(ItemDetails(
      id: id,
      title: "Title",
      subtitle: "Subtitle",
      isFavourite: false,
      description: "This is a long long long long description"
    ))
  ))
}
