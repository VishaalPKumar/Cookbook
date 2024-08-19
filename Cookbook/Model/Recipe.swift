//
//  Recipe.swift
//  Cookbook
//
//  Created by Vishaal Kumar on 7/28/24.
//

import SwiftUI
import SwiftData

@Model
final class Recipe {
    var name: String
    var caption: String
    var imageData: Data?
    var ingredients: [Ingredient]
    var steps: [RecipeStep]
    
    var calories: Int
    var protein: Int
    var carbs: Int
    var fats: Int
    
    init(name: String = "", caption: String = "", imageData: Data? = nil, ingredients: [Ingredient] = [], steps: [RecipeStep] = [], calories: Int = 0, protein: Int = 0, carbs: Int = 0, fats: Int = 0) {
        self.name = name
        self.caption = caption
        self.imageData = imageData
        self.ingredients = ingredients
        self.steps = steps
        self.calories = calories
        self.protein = protein
        self.carbs = carbs
        self.fats = fats
    }
    
    func addIngredient(_ ingredient: Ingredient) {
        ingredients.append(ingredient)
    }
    
    func deleteIngredient(at offsets: IndexSet) {
        ingredients.remove(atOffsets: offsets)
    }
    
    func macrosToString() -> String {
        return "Cal: \(self.calories) | P: \(self.protein) | C: \(self.carbs) | F: \(self.fats)"
    }
}

enum StepType: String, CaseIterable, Identifiable, Codable {
    case preparation
    case cooking
    
    var id: Self {self}
}

enum HeatLevel: String, CaseIterable, Identifiable, Codable {
    case low = "Low"
    case medium = "Medium"
    case mediumHigh = "Medium-High"
    case high = "High"
    
    var id: Self { self }
}

@Model
final class RecipeStep {
    
    var stepType: StepType
    var stepTitle: String
    var instructions: String
    var ingredientsUsed: [Ingredient]
    var heatLevel: HeatLevel
    var duration: Int
    
    init(stepType: StepType = .preparation, stepTitle: String = "", instructions: String = "", ingredientsUsed: [Ingredient] = [], heatLevel: HeatLevel = .low, duration: Int = 0) {
        self.stepType = stepType
        self.stepTitle = stepTitle
        self.instructions = instructions
        self.ingredientsUsed = ingredientsUsed
        self.heatLevel = heatLevel
        self.duration = duration
    }
    
    
    func toString() -> String {
        var string: String = ""
        
        if !stepTitle.isEmpty {
            string += "**\(stepTitle)**" + "\n"
        }
        
        string += instructions
        
        return string
    }
}

struct RecipeMockData {
    
    static let stepOne = RecipeStep(stepType: .preparation,
                                    stepTitle: "Prep Chicken",
                                    instructions: "Cut the chicken into bite size pieces")
    
    static let stepTwo = RecipeStep(stepType: .cooking,
                                    stepTitle: "Cook Chicken",
                                    instructions: "Prepare a pan on medium-high heat. Spray a light layer of oil and cook the chicken on each side for 2 minutes each until you get some color",
                                    heatLevel: .mediumHigh,
                                    duration: 4)
    
    static let stepThree = RecipeStep(stepType: .cooking,
                                      instructions: "Prepare a pan on medium-high heat. Spray a light layer of oil and cook the chicken on each side for 2 minutes each until you get some color",
                                      heatLevel: .mediumHigh)
    
    static let stepFour = RecipeStep(stepType: .cooking,
                                     instructions: "Prepare a pan on medium-high heat. Spray a light layer of oil and cook the chicken on each side for 2 minutes each until you get some color",
                                     heatLevel: .mediumHigh)
    
    static let sampleRecipe: Recipe = Recipe(
        name: "Chicken Shawarma",
        caption: "Very tasty. Yumm!",
        ingredients: IngredientMockData.sampleIngredients,
        steps: [
            stepOne,
            stepTwo,
            stepThree,
            stepFour
        ],
        calories: 500,
        protein: 10,
        carbs: 20,
        fats: 30)
    
    static let recipes: [Recipe] = [sampleRecipe]
}
