import Foundation

extension Models.App {
    public enum Genre: String {
        case action
        case indie
        case adventure
        case rpg = "role-playing-games-rpg"
        case strategy
        case shooter
        case casual
        case simulation
        case puzzle
        case arcade
        case platformer
        case racing
        case MMO = "massively-multiplayer"
        case sports
        case fighting
        case family
        case boardGames = "board-games"
        case educational
        case card
        
        public func prettyString() -> String {
            switch self {
            case .action, .indie, .adventure, .strategy, .shooter, .casual, .simulation,
                    .puzzle, .arcade, .platformer, .racing, .sports, .fighting, .family,
                    .educational, .card:
                return self.rawValue.capitalized
            case .rpg:
                return "Role Playing Games"
            case .MMO:
                return "MMO"
            case .boardGames:
                return "Board Games"
            }
        }
    }
}
