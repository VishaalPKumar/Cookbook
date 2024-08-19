//
//  Alert.swift
//  Cookbook
//
//  Created by Vishaal Kumar on 7/31/24.
//

import SwiftUI

struct AlertItem: Identifiable {
    let id = UUID()
    let title: Text
    let description: Text
    let dismissButton: Alert.Button
}

struct AlertContext {
    static let invalidIngredient = AlertItem(title: Text("Invalid Form"),
                                             description: Text("Please ensure all fields have been filled out."),
                                             dismissButton: .default(Text("OK")))
    
    static let invalidRecipe = AlertItem(title: Text("Invalid Form"),
                                             description: Text("Please ensure all fields have been filled out."),
                                             dismissButton: .default(Text("OK")))
}
