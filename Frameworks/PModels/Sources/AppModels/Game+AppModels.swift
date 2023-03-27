//
//  Game.swift
//  GameList
//
//  Created by Matteo Cultrera on 21/03/23.
//

import Foundation

extension Models.App {
    public struct Game: Equatable, Identifiable {
        public let id: Int
        public let name: String
        public let imageBackground: URL?
        public let smallImage: URL?
        public let rating: Double
        public let ratingTop: Double
        public let genres: [Models.App.Genre]
        
        public init(
            id: Int = 0,
            name: String = "",
            imageBackground: URL? = nil,
            smallImage: URL? = nil,
            rating: Double = 0.0,
            ratingTop: Double = 0.0,
            genres: [Models.App.Genre] = []
        ) {
            self.id = id
            self.name = name
            self.imageBackground = imageBackground
            self.smallImage = smallImage
            self.rating = rating
            self.ratingTop = ratingTop
            self.genres = genres
        }
    }
}

