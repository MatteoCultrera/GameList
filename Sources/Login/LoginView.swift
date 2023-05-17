import ComposableArchitecture
import PResources
import PModels
import SwiftUI

struct LoginView: View {
  let store: StoreOf<Login>
  
  var body: some View {
    WithViewStore(self.store, observe: { $0 }) { store in
      LoginBackgroundView()
        .overlay(alignment: .bottom) {
          VStack(spacing: 20) {
            CustomTextFieldView(
              store: self.store.scope(
                state: \.nameTextField,
                action: Login.Action.nameTextFieldChanged
              )
            )
            
            CustomTextFieldView(
              store: self.store.scope(
                state: \.passwordTextField,
                action: Login.Action.passwordTextFieldChanged
              )
            )
            
            Button(
              action: {
                
              }
            ) {
              VStack {
                Text("Login")
                  .font(.system(size: 24, weight: .bold))
                  .foregroundColor(.white)
              }
              .frame(height: 60)
              .frame(maxWidth: .infinity)
              .background(LinearGradient(
                colors: [PResourcesAsset.accentDark.swiftUIColor, PResourcesAsset.accentLight.swiftUIColor],
                startPoint: .bottomTrailing,
                endPoint: .topLeading
              ))
              .cornerRadius(20)
            }
            .padding(.top)
            .disabled(!store.isButtonEnabled)
            .opacity(store.isButtonEnabled ? 1 : 0.5)
            
            Text(store.registerMessage)
              .frame(maxWidth: .infinity, alignment: .leading)
          }
          .frame(maxWidth: .infinity)
          .padding(20)
          .background(Material.ultraThin)
          .cornerRadius(20)
          .padding()
        }
    }
  }
}

struct LoginView_Previews: PreviewProvider {
  static var previews: some View {
    LoginView(
      store: Store(
        initialState: Login.State(),
        reducer: Login()
      )
    )
  }
}
