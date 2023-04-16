//
//  InitialView.swift
//  GameList
//
//  Created by Matteo Cultrera on 15/03/23.
//

import ComposableArchitecture
import RiveRuntime
import PResources
import PModels
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
				PResourcesAsset.testImage.swiftUIImage
					.resizable()
					.aspectRatio(contentMode: .fill)
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
