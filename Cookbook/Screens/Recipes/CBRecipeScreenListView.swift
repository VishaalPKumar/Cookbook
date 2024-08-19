//
//  CBRecipeScreenView.swift
//  Cookbook
//
//  Created by Vishaal Kumar on 7/28/24.
//

import SwiftUI
import SwiftData

struct CBRecipeScreenListView: View {
    
    
    @Query(sort: \Recipe.name) var recipes: [Recipe] = []
    @Environment(\.modelContext) var context
    @State private var isAddRecipePresented = false
    
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(recipes) { recipe in
                    ZStack {
                        NavigationLink(value: recipe) {
                            EmptyView()
                        }
                        .opacity(0.0)
                        CBRecipeListCell(recipe: recipe)
                    }
                }
                .onDelete { indexSet in
                    for index in indexSet {
                        context.delete(recipes[index])
                    }
                }
            }
            .navigationDestination(for: Recipe.self) { recipe in
                CBRecipeDetailView(recipe: recipes.first(where: {$0.id == recipe.id})!)
            }
            .listStyle(.plain)
            .navigationTitle("🫕 Recipes")
            .overlay(alignment: .bottomTrailing) {
                if !recipes.isEmpty {
                    Button {
                        isAddRecipePresented = true
                    } label: {
                        FloatingButton(systemImageName: "plus")
                            .padding()
                    }
                }
            }
            .overlay {
                if recipes.isEmpty {
                    ContentUnavailableView(label: {
                        Label("No Recipes", systemImage: "microwave")
                    }, description: {
                        Text("Start by adding a recipe!")
                    }, actions: {
                        Button {
                            isAddRecipePresented = true
                        } label: {
                            Text("Add Recipe")
                        }

                    })
                }
            }
            .fullScreenCover(isPresented: $isAddRecipePresented, content: {
                CBRecipeEditorView(recipe: nil)
            })
        }
    }
}

#Preview {
    CBRecipeScreenListView()
}
