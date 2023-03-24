//
//  GameCore.swift
//  GameList
//
//  Created by Matteo Cultrera on 21/03/23.
//

import ComposableArchitecture
import PModels
import Foundation

public struct GameReducer: ReducerProtocol {
    public typealias State = Models.App.Game
    
    public enum Action: Equatable {}
    
    public func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        return .none
    }
}
