import Foundation

extension Models.Response {
    public struct Platform: Codable, Equatable {
        public let id: Int
        public let slug: String
        public let name: String
    }
}

// MARK: - Optional Normalizable
//
//extension Models.Response.Genre: OptionalNormalizable {
//    func normalize() -> Models.App.Genre? {
//        Models.App.Genre(rawValue: slug)
//    }
//}
