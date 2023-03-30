import Foundation

extension Models.Response {
    public struct GamePlatform: Codable, Equatable {
        public let platform: Platform
    }
}

extension Models.Response {
    public struct Platform: Codable, Equatable {
        public let id: Int
        public let slug: String
        public let name: String
    }
}

// MARK: - Optional Normalizable

extension Models.Response.GamePlatform: OptionalNormalizable {
    func normalize() -> Models.App.Platform? {
        Models.App.Platform(rawValue: platform.slug)
    }
}
