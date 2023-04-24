import ComposableArchitecture
import PModels
import SwiftUI

struct ListView: View {
  let store: StoreOf<List>
  
  var body: some View {
    WithViewStore(self.store, observe: { $0 }) { store in
      
      ZStack(alignment: .top) {
        HStack {
          
          MultiSelectionView<Models.Request.List.SortedBy>(
            store: self.store.scope(
              state: \.sortSelection,
              action: List.Action.sortSelectionUpdated
            )
          )
          Spacer()
          
          Text("Game List")
          Spacer()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .frame(height: 50)
        .zIndex(1)
        .animation(.default, value: store.state.sortSelection)
        .padding(.horizontal)
        .background(Material.ultraThin)
        
        VStack {
          Spacer()
            .frame(height: 50)
          SwiftUI.List {
            ForEachStore(
              self.store.scope(
                state: \.games,
                action: List.Action.gameCardAction(id:action:))
            ) {
              GameItemView(store: $0)
                .listRowSeparator(.hidden)
            }
            if !store.games.isEmpty {
              LoadingItemView()
                .onAppear {
                  store.send(.loadMoreGames)
                }
            }
          }
          .listStyle(.plain)
        }
        .zIndex(0.2)
      }
      
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
          ],
          sortSelection: .metacriticDescending
        ),
        reducer: List()
      )
    )
  }
}
