import ComposableArchitecture
import PResources
import PModels
import SwiftUI

struct MultiSelectionView<T: MultiSelectable>: View {
  let store: StoreOf<MultiSelectionCore<T>>

  var body: some View {
    WithViewStore(self.store, observe: { $0 }) { store in
      HStack(spacing: 0) {
        icon(store: store)
        
        if store.state.isOpen {
          openContent(store: store)
        }
      }
      .frame(minWidth: 30, alignment: .leading)
      .frame(height: 30, alignment: .leading)
      .background( Material.thick )
      .cornerRadius(15)
      .onTapGesture {
        store.send(.didTap)
      }
      .animation(.default, value: store.isOpen)
    }
  }

  @ViewBuilder
  func icon(store: ViewStore<MultiSelectionCore<T>.State, MultiSelectionCore<T>.Action>) -> some View {
    Rectangle()
      .fill (
        store.state.backgroundGradient
      )
      .aspectRatio(1, contentMode: .fit)
      .mask {
        store.icon
          .resizable()
          .scaledToFit()
          .rotationEffect(store.isOpen ? Angle.degrees(180) : Angle.zero, anchor: UnitPoint(x: 0.5, y: 0.5))
          .padding(.vertical, 9)
      }
  }

  @ViewBuilder
  func openContent(store: ViewStore<MultiSelectionCore<T>.State, MultiSelectionCore<T>.Action>) -> some View {
    Text(store.description)
      .padding(.trailing, 8)

    HStack(spacing:0) {
      Picker(
        selection: store.binding(
          get: \.selection,
          send: MultiSelectionCore.Action.didSelect),
        content: {
          ForEach(T.allCases) {
            Text($0.stringValue())
          }
        },
        label: {

        })
      .pickerStyle(.menu)
      .tint(PResourcesAsset.backgroundDark2.swiftUIColor)
      .frame(minWidth: 1)
    }
    .frame(height: 30)
    .background {
      LinearGradient(
        colors: [
          PResourcesAsset.accentDark.swiftUIColor,
          PResourcesAsset.accentLight.swiftUIColor
        ],
        startPoint: .leading,
        endPoint: .trailing
      )
    }
    .cornerRadius(15)
    .onTapGesture {
      store.send(.didTapChevron)
    }
    .animation(.none, value: store.state)
  }
}

struct MultiSelection_Previews: PreviewProvider {
  static var previews: some View {
    MultiSelectionView<Models.App.Platform>(
      store: Store(
        initialState: .init(
          description: "Sort:",
          selection: .android
        ),
        reducer: MultiSelectionCore())
    )
  }
}
