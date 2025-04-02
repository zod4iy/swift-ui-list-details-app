import SwiftUI

extension View {
  func onFirstAppear(_ action: @escaping () -> ()) -> some View {
    modifier(FirstAppear(action: action))
  }
}

private struct FirstAppear: ViewModifier {
  @State private var hasAppeared = false
  
  let action: () -> ()
  
  func body(content: Content) -> some View {
    content.onAppear {
      guard !hasAppeared else { return }
      hasAppeared = true
      action()
    }
  }
}
