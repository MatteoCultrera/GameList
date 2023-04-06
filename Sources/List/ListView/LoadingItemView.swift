//
//  LoadingItemView.swift
//  GameList
//
//  Created by Daniele Leto on 31/03/23.
//  Copyright © 2023 com.prometheus. All rights reserved.
//

import ComposableArchitecture
import SwiftUI

struct LoadingItemView: View {
	@Dependency(\.uuid) var uuid
	
	var body: some View {
		VStack {
			Color.clear
				.frame(maxWidth: .infinity)
				.frame(height: 50)
				.mask(RoundedRectangle(cornerRadius: 20))
				.overlay {
					HStack {
						Text("LoadingItemView... ")
						ProgressView().id(self.uuid())
					}
				}
		}
		.padding()
		.background {
			Color.gray
				.overlay(.thinMaterial)
		}
		.clipped()
		.cornerRadius(20)
	}
}

struct LoadingItemView_Previews: PreviewProvider {
	static var previews: some View {
		LoadingItemView()
	}
}
