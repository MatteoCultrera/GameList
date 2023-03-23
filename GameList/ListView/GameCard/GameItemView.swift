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
        
        init(store: GameItem.State) {
            self.name = store.name
            self.imageURL = store.imageBackground
            self.rating = store.rating
            self.maxRating = store.ratingTop
        }
    }
    
    var body: some View {
        WithViewStore(self.store, observe: ViewState.init) { viewStore in
            VStack {
                Spacer()
                VStack {
                    
                    Text(viewStore.name)
                        .font(.title2.bold())
                        .padding(20)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Material.ultraThinMaterial)
                .cornerRadius(20)
                .padding(5)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 250)
            .background {
                AsyncImage(
                    url: viewStore.imageURL,
                    content: { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    },
                    placeholder: {
                        
                    }
                )
            }
            .cornerRadius(20)
            .onTapGesture {
                viewStore.send(.cardTapped)
            }
        }
    }
}

//struct GameItemView_Previews: PreviewProvider {
//    static var previews: some View {
//        GameCardView(
//            state: Models.App.Game(
//                id: 1,
//                name: "DOOM Eternal",
//                imageBackground: URL(string: "https://media.rawg.io/media/games/3ea/3ea3c9bbd940b6cb7f2139e42d3d443f.jpg")
//            )
//        )
//    }
//}
