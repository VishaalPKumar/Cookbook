//
//  CBRecipeListCell.swift
//  Cookbook
//
//  Created by Vishaal Kumar on 7/28/24.
//

import SwiftUI

struct CBRecipeListCell: View {
    
    let recipe: Recipe
    
    var body: some View {
        VStack (alignment: .leading) {
            Image("food-placeholder")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .border(.bar)
            
            Text(recipe.name)
                .font(.title2)
                .fontWeight(.bold)
            
            Text("Cal: \(recipe.calories) | P: \(recipe.protein) | C: \(recipe.carbs) | F: \(recipe.fats)")
                .font(.body)
        }
    }
}

#Preview {
    CBRecipeListCell(recipe: MockData.sampleRecipe)
}
