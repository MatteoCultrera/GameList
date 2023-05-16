import ComposableArchitecture
import PResources
import PModels
import RiveRuntime
import SwiftUI

struct InitialView: View {
  let store: StoreOf<Initial>
  
  var body: some View {
    WithViewStore(self.store, observe: { $0 }) { store in
      VStack {
        Spacer()
        SliderView(
          store: self.store.scope(
            state: \.sliderState,
            action: Initial.Action.sliderAction
          )
        )
        .padding()
        .padding(.bottom)
      }
      .frame(maxWidth: .infinity)
      .background {
        LoginBackgroundView()
      }
    }
  }
  
}


struct InitialView_Previews: PreviewProvider {
  static var previews: some View {
    InitialView(
      store: Store(
        initialState: Initial.State(),
        reducer: Initial()
      )
    )
  }
}
