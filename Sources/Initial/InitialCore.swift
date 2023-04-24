import Foundation
import PNetwork
import PModels
import ComposableArchitecture

public struct Initial: ReducerProtocol {
  public struct State: Equatable {
    public var isLoginRequestInFlight = false
    public var response: Models.Response.List? = nil
    public var sliderState: SliderCore.State = SliderCore.State()
    public let animation = PResourcesAnimations.muscleCar
    
    public init() {}
  }
  
  public enum Action: Equatable {
    case apiResponded(TaskResult<Models.Response.List>)
    case sliderAction(SliderCore.Action)
    case gameListReady(Models.Response.List)
  }
  
  @Dependency(\.rawgClient) var rawgClient
  
  public init() {}
  
  public var body: some ReducerProtocol<State, Action> {
    Reduce { state, action in
      switch action {
      case let .apiResponded(.success(response)):
        state.isLoginRequestInFlight = false
        state.response = response
        return .task {
          .sliderAction(.updateStateMachine(newState: .loaded))
        }
      case .apiResponded(.failure(_)):
        state.isLoginRequestInFlight = false
        return .none
      case .gameListReady(_):
        return .none
      case .sliderAction(.updateStateMachine(.loading)):
        state.isLoginRequestInFlight = true
        state.animation.trigger(trigger: .drive)
        return .task {
          .apiResponded(
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
                  pageSize: 10,
                  dates: (startDate: date, endDate: Date())
                )
              )
            }
          )
        }
      case .sliderAction(.loadAnimationComplete):
        guard let response = state.response else { return .none }
        return .task {
          return .gameListReady(response)
        }
      case .sliderAction(_):
        return .none
      }
    }
    
    Scope(state: \.sliderState, action: /Action.sliderAction) {
      SliderCore()
    }
  }
}
