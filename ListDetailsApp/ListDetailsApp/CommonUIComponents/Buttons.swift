import SwiftUI

struct PrimaryButton: View {
  let title: String
  var backgroundColor: Color?
  let action: () -> Void
  
  
  init(
    title: String,
    backgroundColor: Color? = nil,
    action: @escaping @MainActor () -> Void
  ) {
    self.title = title
    self.backgroundColor = backgroundColor
    self.action = action
  }
  
    var body: some View {
      Button(
        action: action,
        label: {
          Text(title)
        }
      )
      .buttonStyle(PrimaryButtonStyle(
        backgroundColor: backgroundColor
      ))
    }
}

#Preview {
  PrimaryButton(
    title: "Primary Button",
    action: {}
  )
}
