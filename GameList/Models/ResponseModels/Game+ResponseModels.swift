//
//  Game+ResponseModels.swift
//  GameList
//
//  Created by Matteo Cultrera on 21/03/23.
//

import Foundation

extension Models.Response {
    public struct Game: Codable, Equatable, Identifiable {
        enum CodingKeys: String, CodingKey {
            case id
            case name
            case slug
            case imageBackground = "background_image"
            case rating
            case ratingTop = "rating_top"
        }
        
        public let id: Int
        let name: String
        let slug: String
        let imageBackground: URL?
        let rating: Double
        let ratingTop: Double
    }
}

extension Models.Response.Game: Normalizable {
    public func normalize() -> Models.App.Game {
        Models.App.Game(
            id: self.id,
            name: self.name,
            imageBackground: self.imageBackground,
            rating: self.rating,
            ratingTop: self.ratingTop
        )
    }
}
