import Foundation
import PNetwork
import PModels
import ComposableArchitecture

public struct Login: ReducerProtocol {
  public struct State: Equatable {
    
  }
  
  public enum Action: Equatable {
    
  }
  
  public init() {}
  
  public var body: some ReducerProtocol<State, Action> {
    Reduce { state, action in
      return .none
    }
  }
}
