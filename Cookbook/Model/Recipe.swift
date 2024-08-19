//
//  Recipe.swift
//  Cookbook
//
//  Created by Vishaal Kumar on 7/28/24.
//

import Foundation

struct Recipe: Hashable, Identifiable {
    let id = UUID()
    let name: String
    let description: String
    let ingredients: [Ingredient]
    let recipe: String
    
    let calories: Int
    let protein: Int
    let carbs: Int
    let fats: Int
    
}

struct Ingredient: Hashable, Identifiable {
    let id = UUID()
    let name: String
    let measurement: FoodMeasurement
}


enum FoodMeasurement: Hashable {
    case weight(Measurement<UnitMass>)
    case volume(Measurement<UnitVolume>)
    
    func string() -> String {
        switch self {
        case .volume(let measurement):
            return Measurement<UnitVolume>.FormatStyle(width: .narrow, usage: .asProvided).format(measurement)
        case .weight(let measurement):
            return Measurement<UnitMass>.FormatStyle(width: .narrow, usage: .asProvided).format(measurement)
        }
    }
}



struct MockData {
    static let sampleIngredients = [
        Ingredient(name: "Potatoes", measurement: .weight(.init(value: 200, unit: .grams))),
        Ingredient(name: "Chicken", measurement: .weight(.init(value: 200, unit: .grams))),
        Ingredient(name: "Tahini", measurement: .weight(.init(value: 50, unit: .grams))),
        Ingredient(name: "Milk", measurement: .volume(.init(value: 40, unit: .milliliters))),
        Ingredient(name: "Potatoes", measurement: .weight(.init(value: 200, unit: .grams))),
        Ingredient(name: "Chicken", measurement: .weight(.init(value: 200, unit: .grams))),
        Ingredient(name: "Tahini", measurement: .weight(.init(value: 50, unit: .grams))),
        Ingredient(name: "Milk", measurement: .volume(.init(value: 40, unit: .milliliters))),
        Ingredient(name: "Milk", measurement: .volume(.init(value: 40, unit: .milliliters)))
    ]
    static let sampleRecipe: Recipe = Recipe(
        name: "Chicken Shawarma",
        description: "Very tasty. Yumm!",
        ingredients: sampleIngredients,
        recipe: """
Step 1: Make the chicken
Step 2: Make the bread
Step 3: Assemble
Step 4: Present on a plate.
""",
        calories: 500,
        protein: 10,
        carbs: 20,
        fats: 30)
    
    static let recipes: [Recipe] = [sampleRecipe, sampleRecipe, sampleRecipe, sampleRecipe, sampleRecipe]
}
