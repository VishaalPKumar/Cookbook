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
            CBMenuScreenView()
                .tabItem { Label("Menu", systemImage: "menucard") }
            
            CBRecipeScreenView()
                .tabItem { Label("Recipes", systemImage: "list.clipboard") }
            
            CBSettingScreenView()
                .tabItem { Label("Settings", systemImage: "gearshape")}
        }
    }
}

#Preview {
    CBTabView()
}
