import PModels
import Foundation

extension Models.Request.List.SortedBy: MultiSelectable {
  public var id: Models.Request.List.SortedBy { self }
  
  public func stringValue() -> String {
    switch self {
    case .nameAscending:
      return "Name ↑"
    case .nameDescending:
      return "Name ↓"
    case .releasedAscending:
      return "Released ↑"
    case .releasedDescending:
      return "Released ↓"
    case .addedAscending:
      return "Added ↑"
    case .addedDescending:
      return "Added ↓"
    case .createdAscending:
      return "Created ↑"
    case .createdDescending:
      return "Created ↓"
    case .updatedAscending:
      return "Updated ↑"
    case .updatedDescending:
      return "Updated ↓"
    case .ratingAscending:
      return "Rating ↑"
    case .ratingDescending:
      return "Rating ↓"
    case .metacriticAscending:
      return "Metacritic ↑"
    case .metacriticDescending:
      return "Metacritic ↓"
    }
  }
}
