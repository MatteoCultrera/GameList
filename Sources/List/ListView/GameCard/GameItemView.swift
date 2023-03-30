import ComposableArchitecture
import PModels
import SwiftUI

struct GameItemView: View {
    let store: StoreOf<GameItem>
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack(spacing: 15) {
                Spacer()
                    .frame(maxWidth: .infinity)
                    .frame(height: 200)
                    .background {
                        gameImage(image: viewStore.gameImage)
                            .animation(.default, value: viewStore.gameImage)
                            .transition(.opacity)
                    }
                    .mask(RoundedRectangle(cornerRadius: 20))
                
                titleHeader(name: viewStore.game.name, genres: viewStore.game.name)
            }
            .padding()
            .background {
                gameImage(image: viewStore.gameImage)
                .overlay(.thinMaterial)
            }
            .clipped()
            .cornerRadius(20)
            .padding()
            .onAppear {
                viewStore.send(.cardAppeared)
            }
        }
    }
    
    @ViewBuilder
    private func titleHeader(name: String, genres: String) -> some View {
        VStack(spacing: 5) {
            Text(name)
                .foregroundColor(.primary)
                .font(.title2.bold())
                .frame(maxWidth: .infinity, alignment: .leading)
            Text(genres)
                .foregroundColor(.secondary)
                .font(.footnote)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    
    @ViewBuilder
    private func gameImage(image: Image?) -> some View {
        if let image {
            image
                .resizable()
                .scaledToFill()
        } else {
            VStack{
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.red)
        }
    }
}

struct GameItemView_Previews: PreviewProvider {
    static var previews: some View {
        GameItemView(
            store: Store(
                initialState: GameItem.State(
                    id: 1,
                    game: Models.App.Game(
                        name: "Sekiro"
                    )),
                reducer: GameItem()
            )
        )
    }
}
