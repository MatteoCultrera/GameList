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
                }
            }
            .listStyle(.plain)
        }
    }
    
    
}

//struct ListView_Previews: PreviewProvider {
//    static var previews: some View {
//        ListView(
//            store: Store(
//                initialState: List.State(
//                games: [
//                    .init(
//                        id: 2,
//                        name: "hello",
//                        imageBackground: URL(string: "https://www.hello.com")!,
//                        rating: 1,
//                        ratingTop: 5
//                    ),
//                    .init(
//                        id: 2,
//                        name: "hello2",
//                        imageBackground: URL(string: "https://www.hello.com")!,
//                        rating: 1,
//                        ratingTop: 5
//                    )
//                ]
//                ),
//                reducer: List()
//            )
//        )
//    }
//}
