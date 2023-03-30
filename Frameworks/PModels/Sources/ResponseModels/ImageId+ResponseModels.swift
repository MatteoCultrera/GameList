import Foundation

extension Models.Response.Game {
	public struct ImageID: Codable, Equatable, Identifiable {
		public let id: Int
		public let image: URL
	}
}
