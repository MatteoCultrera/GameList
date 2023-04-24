import ComposableArchitecture
import PModels
import PResources
import SwiftUI

public protocol MultiSelectable: Identifiable & CaseIterable & RawRepresentable<String> & Equatable & Hashable where AllCases == Array<Self> {
  func stringValue() -> String
}

public struct MultiSelectionCore<T: MultiSelectable>: ReducerProtocol {
  public struct State: Equatable {
    var isOpen: Bool
    var selection: T
    let icon: Image
    let description: String
    
    var backgroundGradient: LinearGradient {
      if isOpen {
        return LinearGradient(
          colors: [PResourcesAsset.accentDark.swiftUIColor, PResourcesAsset.accentLight.swiftUIColor],
          startPoint: .bottom,
          endPoint: .top
        )
      } else {
        return LinearGradient(
          colors: [Color.primary, Color.primary],
          startPoint: .bottom,
          endPoint: .top
        )
      }
    }
    
    public init(
      isOpen: Bool = false,
      description: String,
      selection: T,
      icon: Image = Image(systemName: "arrow.up.arrow.down")
    ) {
      self.isOpen = isOpen
      self.selection = selection
      self.description = description
      self.icon = icon
    }
  }
  
  public enum Action: Equatable {
    case didTap
    case didTapChevron
    case didSelect(T)
  }
  
  public var body: some ReducerProtocol<State, Action> {
    Reduce { state, action in
      switch action {
      case .didTap:
        state.isOpen.toggle()
        return .none
      case .didTapChevron:
        return .none
      case let .didSelect(selection):
        state.selection = selection
        return .none
      }
    }
  }
}

extension Models.App.Platform: MultiSelectable {
  
  public func stringValue() -> String {
    prettyString()
  }
  
  public var id: Models.App.Platform {
    self
  }
}
