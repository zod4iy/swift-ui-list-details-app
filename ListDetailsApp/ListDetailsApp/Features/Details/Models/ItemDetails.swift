import Foundation

class ItemDetails: Identifiable {
  let id: UUID
  let title: String
  let subtitle: String
  var isFavourite: Bool
  let description: String
  
  init(id: UUID, title: String, subtitle: String, isFavourite: Bool, description: String) {
    self.id = id
    self.title = title
    self.subtitle = subtitle
    self.isFavourite = isFavourite
    self.description = description
  }
}
