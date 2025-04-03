import SwiftUI

struct PrimaryButtonStyle: ButtonStyle {
  var backgroundColor: Color? = nil
  var foregroundColor: Color? = nil
   
  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .padding()
      .background(backgroundColor ?? .blue)
      .foregroundStyle(foregroundColor ?? .white)
      .clipShape(Capsule())
      //.scaleEffect(configuration.isPressed ? 1.2 : 1)
      //.animation(.easeOut(duration: 0.2), value: configuration.isPressed)
  }
}
