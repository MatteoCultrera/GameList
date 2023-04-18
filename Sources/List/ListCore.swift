import Foundation
import PModels
import PNetwork
import ComposableArchitecture

public struct List: ReducerProtocol {
	public struct State: Equatable {
		var isLoginRequestInFlight = false
		var games: IdentifiedArrayOf<GameItem.State> = []
		
		public init(
			games: IdentifiedArrayOf<GameItem.State> = []
		) {
			self.games = games
		}
	}
	
	public enum Action: Equatable {
		case gameCardAction(id: Int, action: GameItem.Action)
		case loadMoreGames
		case startRespond(TaskResult<Models.Response.List>)
	}
	
	@Dependency(\.rawgClient) var rawgClient
	
	public init() {}
	
	public var body: some ReducerProtocol<State, Action> {
		Reduce { state, action in
			switch action {
			case let .gameCardAction(id, action):
				if case .cardTapped = action {
					print("Tapped \(id)")
				}
				return .none
				
			case .loadMoreGames:
				state.isLoginRequestInFlight = true
				let numberOfGames = state.games.count
				return .task {
					.startRespond(
						await TaskResult {
							let string = "01/02/2020"
							let dateFormatter = DateFormatter()
							dateFormatter.dateFormat = "dd/MM/yy"
							
							guard let date = dateFormatter.date(from: string) else {
								throw RawgClient.Error.invalidDate
							}
							
							let newGames = try await self.rawgClient.getList(
								.init(
									page: numberOfGames / 10 + 1,
									pageSize: 10,
									dates: (startDate: date, endDate: Date())
								)
							)
							
							return newGames
						}
					)
				}
			case let .startRespond(.success(response)):
				state.isLoginRequestInFlight = false
				var games = state.games
				
				games.append(contentsOf: IdentifiedArrayOf<GameItem.State>(uniqueElements: response.results.map {
					GameItem.State(id: $0.id, game: $0.normalize())
				}))
				state = .init(games: games)
				return .none
			case let .startRespond(.failure(error)):
				state.isLoginRequestInFlight = false
				return .none
			}
		}
		.forEach(\.games, action: /Action.gameCardAction(id:action:)) {
			GameItem()
		}
	}
}
