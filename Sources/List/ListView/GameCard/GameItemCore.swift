import ComposableArchitecture
import PModels
import PNetwork
import PCache
import SwiftUI
import Foundation

public struct GameItem: ReducerProtocol {
    public struct State: Equatable, Identifiable {
        public let id: Int
        let game: Models.App.Game
        var gameImage: Image?
    }
    
    public enum Action: Equatable {
        case cardAppeared
        case imageLoaded(TaskResult<Image>)
        case cardTapped
    }
    
    @Dependency(\.imageCache) var imageCache
    @Dependency(\.pNetwork) var network
    
    public func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
        case .cardAppeared:
            let url = state.game.smallImage
            return .task {
                .imageLoaded(
                    await TaskResult {
                        if let url, let image = imageCache.get(key: url) {
                            return image
                        } else {
                            return try await self.network.getImage(url)
                        }
                    }
                )
            }
        case let .imageLoaded(.success(image)):
            if let url = state.game.smallImage {
                imageCache.set(value: image, for: url)
            }
            state.gameImage = image
            return .none
        case .imageLoaded(.failure(_)):
            if let url = state.game.smallImage {
                imageCache.set(value: nil, for: url)
            }
            state.gameImage = nil
            return .none
        case .cardTapped:
            return .none
        }
    }
}
