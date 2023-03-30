import Foundation

extension Models.Request {
	public struct List {
		public let page: Int
		public let pageSize: Int
		public let search: String
		public let dates: (startDate: Date, endDate: Date)?
		
		public init(
			page: Int,
			pageSize: Int,
			search: String = "",
			dates: (startDate: Date, endDate: Date)? = nil
		) {
			self.page = page
			self.pageSize = pageSize
			self.search = search
			self.dates = dates
		}
	}
}
