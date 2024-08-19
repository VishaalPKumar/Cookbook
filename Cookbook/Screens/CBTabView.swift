//
//  ContentView.swift
//  Cookbook
//
//  Created by Vishaal Kumar on 7/28/24.
//

import SwiftUI

struct CBTabView: View {
        
    var body: some View {
        TabView {

            CBRecipeScreenListView()
                .tabItem { Label("Recipes", systemImage: "list.clipboard") }

        }
    }
}

#Preview {
    CBTabView()
}
