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
            self.imageURL = store.smallImage
            self.rating = store.rating
            self.maxRating = store.ratingTop
        }
    }
    
    var body: some View {
        WithViewStore(self.store, observe: ViewState.init) { viewStore in
            VStack(spacing: 0) {
                VStack() {
                    Spacer()
                    Rectangle()
                        .fill (
                            LinearGradient(
                                colors: [.black, .clear],
                                startPoint: .bottom,
                                endPoint: .top)
                        )
                        .frame(height: 100)
                }
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
                }
                .frame(height: 250)
                .clipped()
                
                titleHeader(store: viewStore)
            }
            .cornerRadius(20)
            .padding(2)
            .background(Color.white)
            .cornerRadius(20)
            .padding()
            
            //            VStack {
//                Spacer()
//                VStack {
//
//                    Text(viewStore.name)
//                        .font(.title2.bold())
//                        .padding(20)
//                }
//                .frame(maxWidth: .infinity, alignment: .leading)
//                .background(Material.ultraThinMaterial)
//                .cornerRadius(20)
//                .padding(5)
//            }
//            .frame(maxWidth: .infinity)
//            .frame(height: 250)
//            .background {
//                AsyncImage(
//                    url: viewStore.imageURL,
//                    content: { image in
//                        image
//                            .resizable()
//                            .aspectRatio(contentMode: .fill)
//                    },
//                    placeholder: {
//
//                    }
//                )
//            }
//            .cornerRadius(20)
//            .onTapGesture {
//                viewStore.send(.cardTapped)
//            }
        }
    }
    
    @ViewBuilder
    func titleHeader(store: ViewStore<ViewState, GameItem.Action>) -> some View {
        VStack {
            Text(store.name)
                .foregroundColor(.white)
                .font(.title2.bold())
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.vertical, 4)
        .padding(.horizontal, 16)
        .background(Color.black)
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
                    ratingTop: 5
                ),
                reducer: GameItem()
            )
        )
    }
}
