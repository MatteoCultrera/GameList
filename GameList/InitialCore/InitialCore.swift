import Foundation
import ComposableArchitecture

public struct Initial: ReducerProtocol {
    public struct State: Equatable {
        public var isLoginRequestInFlight = false
        
        public init() {}
    }
    
    public enum Action: Equatable {
        case startTapped
        case startRespond(TaskResult<RawgClient.List.Response>)
    }
    
    @Dependency(\.rawgClient) var rawgClient
    
    public init() {}
    
    public var body: some ReducerProtocol<State, Action> {
        Reduce { state, action in
            switch action {
            case .startTapped:
                state.isLoginRequestInFlight = true
                return .task {
                    .startRespond(
                        await TaskResult {
                            try await self.rawgClient.getList(
                                .init(page: 1, pageSize: 30, search: "")
                            )
                        }
                    )
                }
            case let .startRespond(.success(response)):
                return .none
            case let .startRespond(.failure(error)):
                state.isLoginRequestInFlight = false
                return .none
            }
        }
    }
    
}
