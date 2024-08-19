//
//  IngredientsGridView.swift
//  Cookbook
//
//  Created by Vishaal Kumar on 7/29/24.
//

import SwiftUI

struct IngredientsGridView: View {
    
    let ingredients: [Ingredient]
    
    var body: some View {
        LazyVGrid(columns: [GridItem(), GridItem(), GridItem()], content: {
            ForEach(ingredients, id: \.self) { ingredient in
                IngredientCell(ingredient: ingredient)
            }
            
        })
        .padding(.horizontal)
    }
}

struct IngredientCell: View {
    
    let ingredient: Ingredient
    
    var body: some View {
        VStack {
            Image(ingredient.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50, height: 50)
                .padding(.bottom, 5)
            Text(ingredient.name)
                .multilineTextAlignment(.center)
                .font(.footnote)
            Text("\(ingredient.amount) \(ingredient.measurement.rawValue)")
                .font(.footnote)
                .italic()
        }
        .padding(5)
        
    }
}

#Preview {
    IngredientsGridView(ingredients: IngredientMockData.sampleIngredients)
}
