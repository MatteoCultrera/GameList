import Foundation

extension Models.Response {
    public struct Game: Codable, Equatable, Identifiable {
        enum CodingKeys: String, CodingKey {
            case id
            case name
            case slug
            case imageBackground = "background_image"
            case shortScreenshots = "short_screenshots"
            case rating
            case ratingTop = "rating_top"
            case genres
            case platforms
        }
        
        public let id: Int
        let name: String
        let slug: String
        let imageBackground: URL?
        let rating: Double
        let ratingTop: Double
        let shortScreenshots: [Models.Response.Game.ImageID]
        let genres: [Models.Response.Genre]
        let platforms: [Models.Response.GamePlatform]
    }
}

extension Models.Response.Game: Normalizable {
    public func normalize() -> Models.App.Game {
        Models.App.Game(
            id: self.id,
            name: self.name,
            imageBackground: self.imageBackground,
            smallImage: self.shortScreenshots.first(where: { $0.id == -1 })?.image ?? self.shortScreenshots.first?.image,
            rating: self.rating,
            ratingTop: self.ratingTop,
            genres: self.genres.compactMap({$0.normalize()}),
            platforms: self.platforms.compactMap({$0.normalize()})
        )
    }
}
