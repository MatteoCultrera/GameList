//
//  ContentView.swift
//  GameList
//
//  Created by Matteo Cultrera on 15/03/23.
//

import ComposableArchitecture
import SwiftUI

struct RootView: View {
    
    let store = Store(
        initialState: GameApp.State(),
        reducer: GameApp()._printChanges()
    )
    
    var body: some View {
        AppView(store: store)
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
