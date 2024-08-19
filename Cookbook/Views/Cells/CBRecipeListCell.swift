//
//  CBRecipeListCell.swift
//  Cookbook
//
//  Created by Vishaal Kumar on 7/28/24.
//

import SwiftUI

struct CBRecipeListCell: View {
    
    let recipe: Recipe
    @State private var recipeImage: Image?
    
    var body: some View {
        HStack {
            if let recipeImage {
                recipeImage
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 75)
                    
            } else {
                Image("food-placeholder")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 75)
            }
            
            VStack(alignment: .leading) {
                Text(recipe.name)
                    .font(.title3)
                    .fontWeight(.bold)
                
                Text(recipe.macrosToString())
                    .font(.subheadline)
            }
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .onAppear {
            loadImage()
        }
    }
    
    func loadImage() {
        guard let imageData = recipe.imageData else { return }
        guard let uiImage = UIImage(data: imageData) else { return }
        
        recipeImage = Image(uiImage: uiImage)
    }
}

#Preview {
    CBRecipeListCell(recipe: RecipeMockData.sampleRecipe)
}
