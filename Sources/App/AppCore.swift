import Foundation
import PModels
import ComposableArchitecture

public struct GameApp: ReducerProtocol {
	public enum State: Equatable {
		case initial(Initial.State)
		case list(List.State)
		
		public init() { self = .initial(Initial.State()) }
	}
	
	public enum Action: Equatable {
		case initial(Initial.Action)
		case list(List.Action)
	}
	
	public init() {}
	
	public var body: some ReducerProtocol<State, Action> {
		Reduce { state, action in
			switch action {
			case let .initial(.gameListReady(gameList)):
				state = .list(
					List.State(
						games: .init(
							uniqueElements: gameList.results.map {
								GameItem.State(id: $0.id, game: $0.normalize())
							}
						)
					)
				)
				return .none
			case .initial(_):
				return .none
			case .list:
				return .none
			}
		}
		.ifCaseLet(/State.initial, action: /Action.initial) {
			Initial()
		}
		.ifCaseLet(/State.list, action: /Action.list) {
			List()
		}
	}
}
