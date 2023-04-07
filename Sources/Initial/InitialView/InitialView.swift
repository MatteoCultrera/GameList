//
//  InitialView.swift
//  GameList
//
//  Created by Matteo Cultrera on 15/03/23.
//

import ComposableArchitecture
import RiveRuntime
import PResources
import SwiftUI

struct InitialView: View {
	let store: StoreOf<Initial>
	
	struct ViewState: Equatable {
		var isQueryPerforming: Bool
		
		init(state: Initial.State) {
			self.isQueryPerforming = state.isLoginRequestInFlight
		}
	}
	
	let animation = PResourcesAnimations.zombie
	
	var body: some View {
		WithViewStore(self.store, observe: ViewState.init) { viewStore in
			VStack {
				
				Spacer()
				Button("Start") {
					animation.trigger(trigger: .hit)
//					viewStore.send(.startTapped)
				}
				.disabled(viewStore.isQueryPerforming)
				Spacer()
			}
			.frame(maxWidth: .infinity)
			.background {
				animation
					.view
					.ignoresSafeArea()
			}
			.ignoresSafeArea()
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
