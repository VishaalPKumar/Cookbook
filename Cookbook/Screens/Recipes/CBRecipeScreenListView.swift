//
//  CBRecipeScreenView.swift
//  Cookbook
//
//  Created by Vishaal Kumar on 7/28/24.
//

import SwiftUI

struct CBRecipeScreenListView: View {
    var body: some View {
        NavigationView {
            List {
                ForEach(MockData.recipes) { recipe in
                    NavigationLink {
                        CBRecipeDetailView(recipe: recipe)
                    } label: {
                        CBRecipeListCell(recipe: recipe)
                    }

                }
            }
            .listStyle(.plain)
            .padding(10)
            .navigationTitle("🫕 Recipes")
        }
    }
}

#Preview {
    CBRecipeScreenListView()
}
