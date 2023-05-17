import ComposableArchitecture
import PResources
import PModels
import SwiftUI

struct CustomTextFieldView : View {
  let store: StoreOf<CustomTextFieldCore>
  enum ProtectedFocusState {
    /// The textfield does not have hidden text.
    case plain
    
    /// The textfield does have hidden text.
    case secured
  }
  
  // MARK: - Stored Properties
  /// The focus state of the textfield.
  @FocusState var inFocus: ProtectedFocusState?
  
  // MARK: - Body
  
  public var body: some View {
    WithViewStore(self.store, observe: { $0 }) { store in
      VStack(alignment: .leading, spacing: 0) {
        HStack(spacing: 15) {
          if let image = store.image {
            image
              .resizable()
              .aspectRatio(contentMode: .fit)
              .frame(width: 30, height: 30, alignment: .center)
              .padding(.leading, 10)
              .foregroundColor(store.design.iconColor)
          } else {
            Spacer(minLength: 10)
          }
          
          Group {
            if store.isSecured {
              if store.isTextVisible {
                TextField(
                  "",
                  text: store.binding(get: \.text, send: CustomTextFieldCore.Action.textFieldChanged)
                )
                .placeholder(when: store.text.isEmpty) {
                  Text(store.placeholderText).foregroundColor(store.design.placeholderColor)
                }
                .foregroundColor(store.design.textColor)
                .focused($inFocus, equals: .plain)
                .disableAutocorrection(true)
                .keyboardType(.asciiCapable)
              } else {
                SecureField(
                  "",
                  text: store.binding(get: \.text, send: CustomTextFieldCore.Action.textFieldChanged)
                )
                .placeholder(when: store.text.isEmpty) {
                  Text(store.placeholderText).foregroundColor(store.design.placeholderColor)
                }
                .foregroundColor(store.design.textColor)
                .focused($inFocus, equals: .secured)
                .disableAutocorrection(true)
                .keyboardType(.asciiCapable)
              }
            } else {
              TextField(
                "",
                text: store.binding(get: \.text, send: CustomTextFieldCore.Action.textFieldChanged)
              )
              .placeholder(when: store.text.isEmpty) {
                Text(store.placeholderText).foregroundColor(store.design.placeholderColor)
              }
              .foregroundColor(store.design.textColor)
              .keyboardType(.emailAddress)
              .disableAutocorrection(true)
              .autocapitalization(.none)
            }
          }
          .keyboardType(.emailAddress)
          .font(.system(size: 20, weight: .light, design: .rounded))
          .frame(maxHeight: .infinity)
          .padding(.trailing, 10)
          .background(.clear)
          .submitLabel(.done)
          
          if store.isSecured {
            showPasswordButton(store: store)
          }
        }
        .overlay(
          RoundedRectangle(cornerRadius: 20)
            .stroke(
              store.errorText?.isEmpty ?? true ?
                .clear :
                store.design.errorColor,
              lineWidth: 3
            )
        )
        .background(store.design.backgroundColor)
        .frame(height: 60)
        .cornerRadius(20)
        
        if let error = store.errorText {
          errorText(text: error)
            .foregroundColor(store.design.errorColor)
        }
      }
    }
  }
  
  @ViewBuilder
  func showPasswordButton(store: ViewStore<CustomTextFieldCore.State, CustomTextFieldCore.Action>) -> some View {
    Button(
      action: {
        store.send(.toggleTextVisibility)
        inFocus = store.isTextVisible ? .plain : .secured
      },
      label: {
        Image(systemName: "eye\(store.isTextVisible ? ".slash" : "")")
          .resizable()
          .aspectRatio(contentMode: .fit)
          .frame(width: 30, height: 30, alignment: .center)
          .padding(.trailing, 10)
          .foregroundColor(store.design.iconColor)
      }
    )
  }
  
  @ViewBuilder
  func errorText(text: String) -> some View {
    Text(text)
      .font(.system(size: 12, weight: .light, design: .rounded))
      .frame(height: 15)
      .padding(.leading, 10)
      .padding(.top, 5)
  }
}


struct UI_Textfield_Previews: PreviewProvider {
  static var previews: some SwiftUI.View {
    VStack(spacing: 10) {
      CustomTextFieldView(
        store: Store(
          initialState: CustomTextFieldCore.State(
            text: "",
            placeholderText: "Mail",
            isSecured: false,
            image: Image(systemName: "envelope"),
            design: .init(
              textColor: .blue,
              placeholderColor: .yellow,
              iconColor: .red
            )
          ),
          reducer: CustomTextFieldCore())
      )
      
      CustomTextFieldView(
        store: Store(
          initialState: CustomTextFieldCore.State(
            text: "Prova",
            placeholderText: "Mail",
            errorText: "Erroreeeee",
            isSecured: true
          ),
          reducer: CustomTextFieldCore())
      )
      
      CustomTextFieldView(
        store: Store(
          initialState: CustomTextFieldCore.State(
            text: "",
            placeholderText: "Name"
          ),
          reducer: CustomTextFieldCore())
      )
    }
    .padding(20)
  }
}

private extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {

        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}
