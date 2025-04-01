import SwiftUI

@main
struct ListDetailsApp: App {
    var body: some Scene {
        WindowGroup {
          ListView(viewModel: .init(
            repository: ListRepository(
              dataProvider: ListDataProviderImpl()
            ))
          )
        }
    }
}
