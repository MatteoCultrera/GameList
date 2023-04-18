import ComposableArchitecture
import SwiftUI
import PResources

struct SliderView: View {
	let store: StoreOf<SliderCore>

	var body: some View {
		GeometryReader { geometry in
			WithViewStore(self.store, observe: { $0 }) { viewStore in
				ZStack(alignment: .leading) {
					slider(store: viewStore)
						.animation(.default, value: viewStore.state)
				}
				.frame(height: SliderCore.Constants.sliderHeight)
				.frame(maxWidth: .infinity, alignment: .leading)
				.background {
					RoundedRectangle(cornerRadius: 200)
						.fill(Material.ultraThin)
						.frame(width: viewStore.state.sliderWidth)
				}
				.cornerRadius(SliderCore.Constants.sliderCornerRadius)
				.offset(y: viewStore.state.sliderYOffset)
				.onAppear {
					viewStore.send(.updateSliderSize(newSize: geometry.size))
				}
				.animation(.default, value: viewStore.state.toggleOffset)
				.animation(.default, value: viewStore.state.sliderYOffset)
			}
		}
		.frame(maxHeight: SliderCore.Constants.sliderHeight)
	}
	
	@ViewBuilder
	func slider(store: ViewStore<SliderCore.State, SliderCore.Action>) -> some View {
		loading(store: store)
			.padding(SliderCore.Constants.borderSize)
			.offset(x: store.state.toggleOffset)
			.transition(.scale)
			.gesture(
				DragGesture(minimumDistance: 0)
					.onChanged({ (value) in
						guard store.state.stateMachine == .interactable else {
							return
						}
						
						let translation = value.translation
						guard translation.width > 0 else {
							return
						}
						
						guard translation.width < store.state.sliderWidth - SliderCore.Constants.toggleMinWidth - 2 * SliderCore.Constants.borderSize else {
							return
						}
						store.send(.updateToggleOffset(newOffset: translation.width))
					})
					.onEnded { (value) in
						if store.state.toggleOffset > store.state.sliderWidth * 2/3 {
							store.send(.updateStateMachine(newState: .loading))
						} else {
							store.send(.updateStateMachine(newState: .backToStart))
						}
					}
			)
	}
	
	@ViewBuilder
	func loading(store: ViewStore<SliderCore.State, SliderCore.Action>) -> some View {
		HStack {
			store.animation.view
		}
		.background {
			RoundedRectangle(cornerRadius: 2000)
				.fill(LinearGradient(
					colors: [PResourcesAsset.accentDark.swiftUIColor, PResourcesAsset.accentLight.swiftUIColor],
					startPoint: .bottomTrailing,
					endPoint: .topLeading
				))
				.frame(width: SliderCore.Constants.toggleMinWidth, height: SliderCore.Constants.toggleMinWidth)
		}
		.frame(width: SliderCore.Constants.toggleMinWidth, height: SliderCore.Constants.toggleMinWidth)
	}
}

struct Slider_Previews: PreviewProvider {
	static var previews: some View {
		SliderView(store: Store(
			initialState: .init(),
			reducer: SliderCore())
		)
	}
}
