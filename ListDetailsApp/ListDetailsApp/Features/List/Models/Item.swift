import Foundation

class Item: Identifiable {
  let id: UUID
  let title: String
  let subtitle: String
  var isFavourite: Bool
  
  init(id: UUID, title: String, subtitle: String, isFavourite: Bool) {
    self.id = id
    self.title = title
    self.subtitle = subtitle
    self.isFavourite = isFavourite
  }
}
