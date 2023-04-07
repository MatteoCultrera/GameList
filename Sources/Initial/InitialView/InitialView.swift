//
//  InitialView.swift
//  GameList
//
//  Created by Matteo Cultrera on 15/03/23.
//

import ComposableArchitecture
import RiveRuntime
import SwiftUI

struct InitialView: View {
	let store: StoreOf<Initial>
	
	struct ViewState: Equatable {
		var isQueryPerforming: Bool
		
		init(state: Initial.State) {
			self.isQueryPerforming = state.isLoginRequestInFlight
		}
	}
	
	let animation = RiveViewModel(fileName: "zombie_character", stateMachineName: "State Machine 1")
	
	var body: some View {
		WithViewStore(self.store, observe: ViewState.init) { viewStore in
			VStack {
				animation
					.view()
				Spacer()
				Button("Start") {
					animation.triggerInput("Hit")
//					viewStore.send(.startTapped)
				}
				.disabled(viewStore.isQueryPerforming)
			}
			.frame(maxWidth: .infinity)
			.background(Color.red)
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
