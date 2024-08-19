//
//  CBRecipeDetailView.swift
//  Cookbook
//
//  Created by Vishaal Kumar on 7/29/24.
//

import SwiftUI

struct CBRecipeDetailView: View {
    
    let recipe: Recipe
    
    var body: some View {
        ScrollView{
            Image("food-placeholder")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 250)
            
            VStack {
                Text(recipe.name)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundStyle(.primary)
                
                Text("Cal: \(recipe.calories) | P: \(recipe.protein) | C: \(recipe.carbs) | F: \(recipe.fats)")
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
            
            Divider()
                .padding()
            
            Text("Ingredients")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.bottom)
            
            IngredientsGridView(ingredients: MockData.sampleIngredients)
            
        }
    }
}

#Preview {
    CBRecipeDetailView(recipe: MockData.sampleRecipe)
}
