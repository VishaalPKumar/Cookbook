//
//  Ingredients.swift
//  Cookbook
//
//  Created by Vishaal Kumar on 7/29/24.
//

import Foundation
import SwiftData


@Model
final class Ingredient {
    var name: String
    var ingredientType: IngredientType
    var amount: Int
    var measurement: FoodMeasurement
    
    init(name: String = "",
         ingredientType: IngredientType = .poultry,
         amount: Int = 0,
         measurement: FoodMeasurement = .grams) {
        
        self.name = name
        self.ingredientType = ingredientType
        self.amount = 0
        self.measurement = measurement
        
    }
    
    var imageName: String {
        get {
            switch ingredientType {
            case .poultry:
                "poultry"
            case .redMeat:
                "red_meat"
            case .seafood:
                "seafood"
            case .fruit:
                "fruits"
            case .vegetables:
                "vegetables"
            case .milk:
                "milk"
            case .oil:
                "oil"
            case .sauce:
                "sauce"
            case.cheese:
                "cheese"
            }
        }
        set { }
    }
    
    func isValid() -> Bool {
        if amount != 0 && !name.isEmpty  {
            return true
        }
        return false
    }
}

enum FoodMeasurement: String, CaseIterable, Identifiable, Codable {
    case grams = "g"
    case milliliters = "ml"
    
    var id: Self { self }
}

enum IngredientType: String, CaseIterable, Identifiable, Codable {
    case poultry = "Poultry"
    case redMeat = "Red Meat"
    case seafood = "Seafood"
    case fruit = "Fruit"
    case vegetables = "Vegetables"
    case milk = "Milk"
    case oil = "Oil"
    case sauce = "Sauce"
    case cheese = "Cheese"
    
    var id: Self {self}
}


struct IngredientMockData {
    static let potato               = Ingredient(name: "Potatoes",
                                                 ingredientType: .vegetables,
                                                 amount: 200,
                                                 measurement: .grams)
    
    static let chicken              = Ingredient(name: "Chicken",
                                                 ingredientType: .poultry,
                                                 amount: 200,
                                                 measurement: .grams)
    
    static let tahini               = Ingredient(name: "Tahini",
                                                 ingredientType: .sauce,
                                                 amount: 50,
                                                 measurement: .grams)
    
    static let milk                 = Ingredient(name: "Milk",
                                                 ingredientType: .milk,
                                                 amount: 40,
                                                 measurement: .milliliters)
    
    static let salmon               = Ingredient(name: "Salmon",
                                                 ingredientType: .seafood,
                                                 amount: 200,
                                                 measurement: .grams)
    
    static let oil                  = Ingredient(name: "Oil",
                                                 ingredientType: .oil,
                                                 amount: 4,
                                                 measurement: .grams)
    
    static let broccoli             = Ingredient(name: "Broccoli",
                                                 ingredientType: .vegetables,
                                                 amount: 100,
                                                 measurement: .grams)
    
    static let cheese               = Ingredient(name: "Cheese",
                                                 ingredientType: .cheese,
                                                 amount: 100,
                                                 measurement: .grams)
    
    static let beef                 = Ingredient(name: "Beef",
                                                 ingredientType: .redMeat,
                                                 amount: 180,
                                                 measurement: .grams)
    
    static let sampleIngredients    = [potato, chicken, tahini, milk, salmon, oil, broccoli, cheese, beef]
}
