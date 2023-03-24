//
//  ListCore.swift
//  GameList
//
//  Created by Matteo Cultrera on 15/03/23.
//

import Foundation
import PModels
import ComposableArchitecture

public struct List: ReducerProtocol {
    public struct State: Equatable {
        var games: IdentifiedArrayOf<Models.App.Game> = []
        
        public init(
            games: IdentifiedArrayOf<Models.App.Game> = []
        ) {
            self.games = games
        }
    }
    
    public enum Action: Equatable {
        case gameCardTapped(id: Int, action: GameItem.Action)
    }
    
    public init() {}
    
    public var body: some ReducerProtocol<State, Action> {
        Reduce { state, action in
            switch action {
            case let .gameCardTapped(id, action):
                print("Tapped \(id)")
                return .none
            }
        }
    }
}
