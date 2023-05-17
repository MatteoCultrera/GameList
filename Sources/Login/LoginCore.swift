import Foundation
import PNetwork
import PModels
import PResources
import ComposableArchitecture
import SwiftUI

public struct Login: ReducerProtocol {
  public struct State: Equatable {
    var nameTextField: CustomTextFieldCore.State
    var passwordTextField: CustomTextFieldCore.State
    var registerMessage: AttributedString {
      var result = AttributedString("Register")
      result.foregroundColor = PResourcesAsset.accentLight.swiftUIColor
      result.link = URL(string: "https://www.hackingwithswift.com")
      result.font = .system(size: 16, weight: .bold)
      return "Don’t have an account? " + result
    }
    
    var isButtonEnabled: Bool {
      buttonEnabled()
    }
    
    public init() {
      nameTextField = .init(
        text: "",
        placeholderText: "E-Mail",
        design: Login.textFieldDesign
      )
      
      passwordTextField = .init(
        text: "",
        placeholderText: "Password",
        isSecured: true,
        design: Login.textFieldDesign
      )
    }
  }
  
  public enum Action: Equatable {
    case nameTextFieldChanged(CustomTextFieldCore.Action)
    case passwordTextFieldChanged(CustomTextFieldCore.Action)
  }
  
  public init() {}
  
  public var body: some ReducerProtocol<State, Action> {
    Reduce { state, action in
      return .none
    }
    
    Scope(state: \.nameTextField, action: /Action.nameTextFieldChanged) {
      CustomTextFieldCore()
    }
    
    Scope(state: \.passwordTextField, action: /Action.passwordTextFieldChanged) {
      CustomTextFieldCore()
    }
  }
}

extension Login {
  static var textFieldDesign: CustomTextFieldCore.Design {
    CustomTextFieldCore.Design(
      textColor: .black,
      placeholderColor: Color.black.opacity(0.5),
      iconColor: Color.black.opacity(0.5),
      backgroundColor: PResourcesAsset.backgroundStaticWhite.swiftUIColor
    )
  }
}

private extension Login.State {
  func buttonEnabled() -> Bool {
    if nameTextField.text.isEmpty || passwordTextField.text.isEmpty {
      return false
    }
    
    return true
  }
}
