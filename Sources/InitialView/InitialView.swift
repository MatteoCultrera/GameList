//
//  InitialView.swift
//  GameList
//
//  Created by Matteo Cultrera on 15/03/23.
//

import ComposableArchitecture
import SwiftUI

struct InitialView: View {
    let store: StoreOf<Initial>
    
    struct ViewState: Equatable {
        var isQueryPerforming: Bool
        
        init(state: Initial.State) {
            self.isQueryPerforming = state.isLoginRequestInFlight
        }
    }
    
    var body: some View {
        WithViewStore(self.store, observe: ViewState.init) { viewStore in
            VStack {
                Spacer()
                Button("Start") {
                    viewStore.send(.startTapped)
                }
                .disabled(viewStore.isQueryPerforming)
            }
            .frame(maxWidth: .infinity)
            .background(Color.red)
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
