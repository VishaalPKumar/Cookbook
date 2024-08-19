//
//  CBRecipeDetailView.swift
//  Cookbook
//
//  Created by Vishaal Kumar on 7/29/24.
//

import SwiftUI
import SwiftData

struct CBRecipeDetailView: View {
        
    @Bindable var recipe: Recipe
    @State private var isShowingInstructions = false
    @State private var recipeImage: Image?
    @State private var isEditRecipePresented: Bool = false
    @State private var updateView: Bool = false
    
    var body: some View {
        ZStack {
            ScrollView {
                if let recipeImage {
                    recipeImage
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 300)

                } else {
                    Image("food-placeholder")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 300)
                }
                
                VStack {
                    Text(recipe.name)
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundStyle(.primary)
                    
                    Text(recipe.macrosToString())
                        .font(.body)
                        .fontWeight(.semibold)
                        .padding(.bottom, 10)
                    
                    HStack(spacing: 20) {
                        Label("Serves: \(1)",
                              systemImage: "person.2")
                        Label("Prep: \(20)",
                              systemImage: "clock")
                        Label("Cooked: \(20)",
                              systemImage: "repeat")
                        
                    }
                    .padding(.horizontal)
                }
                
                if !recipe.caption.isEmpty {
                    Text(recipe.caption)
                        .font(.body)
                        .italic()
                        .padding(.top)
                }
                
                Divider()
                    .padding()
                
                Text("Ingredients")
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.bottom)
                
                IngredientsGridView(ingredients: recipe.ingredients)
                    .padding(.bottom, 50)
                
            }
            .if(!isShowingInstructions) { view in
                view.overlay(alignment: .bottomTrailing) {
                    Button {
                        isShowingInstructions = true
                    } label: {
                        FloatingButton(systemImageName: "list.clipboard")
                    }
                    .padding()
                }
            }
            .blur(radius: isShowingInstructions ? 20 : 0)
            .disabled(isShowingInstructions)
            
            if (isShowingInstructions) {
                CBRecipeInstructionView(
                    recipe: recipe,
                    isShowingInstructionView: $isShowingInstructions
                )
                .offset(y: -20)
            }
        }
        .navigationTitle(recipe.name)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            loadImage()
        }
        .toolbar {
            ToolbarItemGroup(placement: .topBarTrailing) {
                Button {
                    isEditRecipePresented = true
                } label: {
                    Text("Edit")
                }
            }
        }
        .fullScreenCover(isPresented: $isEditRecipePresented,
                         content: {
            CBRecipeEditorView(recipe: recipe)
        })
    }
    
    func loadImage() {
        guard let imageData = recipe.imageData else { return }
        guard let uiImage = UIImage(data: imageData) else { return }
        
        recipeImage = Image(uiImage: uiImage)
    }
}

#Preview {
    CBRecipeDetailView(recipe: RecipeMockData.sampleRecipe)
}
