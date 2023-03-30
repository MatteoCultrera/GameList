import Foundation
import PModels
import ComposableArchitecture

public struct List: ReducerProtocol {
	public struct State: Equatable {
		var games: IdentifiedArrayOf<GameItem.State> = []
		
		public init(
			games: IdentifiedArrayOf<GameItem.State> = []
		) {
			self.games = games
		}
	}
	
	public enum Action: Equatable {
		case gameCardAction(id: Int, action: GameItem.Action)
	}
	
	public init() {}
	
	public var body: some ReducerProtocol<State, Action> {
		Reduce { state, action in
			switch action {
			case let .gameCardAction(id, action):
				if case .cardTapped = action {
					print("Tapped \(id)")
				}
				return .none
			}
		}
		.forEach(\.games, action: /Action.gameCardAction(id:action:)) {
			GameItem()
		}
	}
}
