//
//  ListView.swift
//  GameList
//
//  Created by Matteo Cultrera on 15/03/23.
//
import ComposableArchitecture
import SwiftUI

struct ListView: View {
	let store: StoreOf<List>
	
	var body: some View {
		WithViewStore(self.store, observe: { $0 }) { store in
			SwiftUI.List {
				ForEachStore(
					self.store.scope(
						state: \.games,
						action: List.Action.gameCardAction(id:action:))
				) {
					GameItemView(store: $0)
						.listRowSeparator(.hidden)
				}
				LoadingItemView()
					.onAppear {
						store.send(.loadMoreGames)
					}
			}
			.listStyle(.plain)
		}
	}
}

struct ListView_Previews: PreviewProvider {
	static var previews: some View {
		ListView(
			store: Store(
				initialState: List.State(
					games: [
						GameItem.State(
							id: 1,
							game: .init(
								id: 1,
								name: "Sekiro",
								genres: [.action, .MMO],
								platforms: [.commodore, .appleII]
							)
						),
						GameItem.State(
							id: 2,
							game: .init(
								id: 2,
								name: "Assassin's Creed Liberation Path",
								genres: [.action, .MMO],
								platforms: [.commodore, .appleII]
							)
						)
					]
				),
				reducer: List()
			)
		)
	}
}
