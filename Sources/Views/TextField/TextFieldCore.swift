import ComposableArchitecture
import PModels
import PResources
import SwiftUI

public struct CustomTextFieldCore: ReducerProtocol {
  public struct Design: Equatable {
    let placeholderColor: Color
    let textColor: Color
    let iconColor: Color
    let errorColor: Color
    let backgroundColor: Color
    
    public init(
      textColor: Color = Color.primary,
      placeholderColor: Color = Color.secondary,
      iconColor: Color = Color.secondary,
      errorColor: Color = Color.red,
      backgroundColor: Color = PResourcesAsset.textFieldBackground.swiftUIColor
    ) {
      self.placeholderColor = placeholderColor
      self.textColor = textColor
      self.iconColor = iconColor
      self.errorColor = errorColor
      self.backgroundColor = backgroundColor
    }
  }
  
  public struct State: Equatable {
    var text: String
    let placeholderText: String
    var errorText: String?
    let isSecured: Bool
    let image: Image?
    var isTextVisible: Bool
    var design: Design

    public init(
      text: String,
      placeholderText: String,
      errorText: String? = nil,
      isSecured: Bool = false,
      image: Image? = nil,
      design: Design = Design()
    ) {
      self.text = text
      self.placeholderText = placeholderText
      self.errorText = errorText
      self.isSecured = isSecured
      self.image = image
      self.isTextVisible = false
      self.design = design
    }
  }
  
  public enum Action: Equatable {
    case toggleTextVisibility
    case textFieldChanged(String)
  }
  
  public var body: some ReducerProtocol<State, Action> {
    Reduce { state, action in
      switch action {
      case .toggleTextVisibility:
        state.isTextVisible.toggle()
        return .none
      case let .textFieldChanged(newText):
        state.text = newText
        return .none
      }
    }
  }
}
