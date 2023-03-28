//
//  GameItemView.swift
//  GameList
//
//  Created by Matteo Cultrera on 17/03/23.
//

import ComposableArchitecture
import SwiftUI

struct GameCardView: View {
    let store: StoreOf<GameItem>
    
    struct ViewState: Equatable {
        let name: String
        let imageURL: URL?
        let rating: Double
        let maxRating: Double
        let genres: String
        
        init(store: GameItem.State) {
            self.name = store.name
            self.imageURL = store.smallImage
            self.rating = store.rating
            self.maxRating = store.ratingTop
            self.genres = store.genres.map { $0.prettyString() }.joined(separator: " • ")
        }
    }
    
    var body: some View {
        WithViewStore(self.store, observe: ViewState.init) { viewStore in
            VStack(spacing: 15) {
                Spacer()
                    .frame(maxWidth: .infinity)
                    .frame(height: 200)
                    .background {
                        AsyncImage(
                            url: viewStore.imageURL,
                            content: { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                            }, placeholder: {
                                
                            }
                        )
                    }
                    .mask(RoundedRectangle(cornerRadius: 20))
                
                titleHeader(store: viewStore)
            }
            .padding()
            .background {
                AsyncImage(
                    url: viewStore.imageURL,
                    content: { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    }, placeholder: {
                        
                    }
                )
                .overlay(.thinMaterial)
            }
            .clipped()
            .cornerRadius(20)
            .padding()
        }
    }
    
    @ViewBuilder
    func titleHeader(store: ViewStore<ViewState, GameItem.Action>) -> some View {
        VStack(spacing: 5) {
            Text(store.name)
                .foregroundColor(.primary)
                .font(.title2.bold())
                .frame(maxWidth: .infinity, alignment: .leading)
            Text(store.genres)
                .foregroundColor(.secondary)
                .font(.footnote)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

struct GameItemView_Previews: PreviewProvider {
    static var previews: some View {
        GameCardView(
            store: Store(
                initialState: GameItem.State(
                    id: 1,
                    name: "Sekiro",
                    imageBackground: URL(string: "https://media.rawg.io/media/games/5ec/5ecac5cb026ec26a56efcc546364e348.jpg"),
                    smallImage: URL(string: "https://media.rawg.io/media/screenshots/36f/36f941f72e2b2a41629f5fb3bd448688.jpg"),
                    rating: 2.3,
                    ratingTop: 5,
                    genres: [.card, .boardGames, .MMO]
                ),
                reducer: GameItem()
            )
        )
    }
}
