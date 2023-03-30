import ComposableArchitecture
import SwiftUI

public struct AppView: View {
	let store: StoreOf<GameApp>
	
	public init(store: StoreOf<GameApp>) {
		self.store = store
	}
	
	public var body: some View {
		SwitchStore(self.store) {
			CaseLet(state: /GameApp.State.initial, action: GameApp.Action.initial) { store in
				InitialView(store: store)
					.transition(.opacity.combined(with: .offset(x: 0, y: 20)))
			}
			CaseLet(state: /GameApp.State.list, action: GameApp.Action.list) { store in
				ListView(store: store)
					.transition(.opacity)
			}
		}
	}
}
