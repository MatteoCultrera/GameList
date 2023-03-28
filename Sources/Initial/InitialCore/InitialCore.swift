import Foundation
import PNetwork
import PModels
import ComposableArchitecture

public struct Initial: ReducerProtocol {
    public struct State: Equatable {
        public var isLoginRequestInFlight = false
        
        public init() {}
    }
    
    public enum Action: Equatable {
        case startTapped
        case startRespond(TaskResult<Models.Response.List>)
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
                            
                            let string = "01/02/2020"
                            let dateFormatter = DateFormatter()
                            dateFormatter.dateFormat = "dd/MM/yy"
                            
                            guard let date = dateFormatter.date(from: string) else {
                                throw RawgClient.Error.invalidDate
                            }
                            
                            return try await self.rawgClient.getList(
                                .init(
                                    page: 1,
                                    pageSize: 30,
                                    dates: (startDate: date, endDate: Date())
                                )
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
