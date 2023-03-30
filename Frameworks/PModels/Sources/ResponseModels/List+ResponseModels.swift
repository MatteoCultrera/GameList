import Foundation

extension Models.Response {
	public struct List: Codable, Equatable {
		public let count: Int
		public let next: URL?
		public let previous: URL?
		public let results: [Models.Response.Game]
	}
}
