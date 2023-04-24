import Foundation

extension Models.Request {
  public struct List {
    public let page: Int
    public let pageSize: Int
    public let search: String
    public let dates: (startDate: Date, endDate: Date)?
    public let sortedBy: SortedBy
    
    public init(
      page: Int,
      pageSize: Int,
      search: String = "",
      dates: (startDate: Date, endDate: Date)? = nil,
      sortedBy: SortedBy = .metacriticDescending
    ) {
      self.page = page
      self.pageSize = pageSize
      self.search = search
      self.dates = dates
      self.sortedBy = sortedBy
    }
  }
}

extension Models.Request.List {
  public enum SortedBy: String, CaseIterable {
    case nameAscending
    case nameDescending = "-name"
    case releasedAscending = "released"
    case releasedDescending = "-released"
    case addedAscending = "added"
    case addedDescending = "-added"
    case createdAscending = "created"
    case createdDescending = "-created"
    case updatedAscending = "updated"
    case updatedDescending = "-updated"
    case ratingAscending = "rating"
    case ratingDescending = "-rating"
    case metacriticAscending = "metacritic"
    case metacriticDescending = "-metacritic"
  }
}
