//
//  CBAddIngredientView.swift
//  Cookbook
//
//  Created by Vishaal Kumar on 7/30/24.
//

import SwiftUI

struct CBAddIngredientView: View {
    
    @Environment(\.dismiss) var dismiss
    @Binding var ingredients: [Ingredient]
    @State var newIngredient: Ingredient = Ingredient()
        
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Ingredient Information")) {
                    TextField("Ingredient Name", text: $newIngredient.name)
                    Picker("Type", selection: $newIngredient.ingredientType) {
                        ForEach(IngredientType.allCases) { ingredientType in
                            Text(ingredientType.rawValue)
                        }
                    }
                    HStack {
                        TextField("Amount", value: $newIngredient.amount, format: .number)
                            .keyboardType(.numberPad)
                        Picker("Unit", selection: $newIngredient.measurement) {
                            ForEach(FoodMeasurement.allCases) { fM in
                                Text(fM.rawValue)
                            }
                        }
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: .primaryAction) {
                    Button {
                        ingredients.append(newIngredient)
                        dismiss()
                    } label: {
                        Text("Add Ingredient")
                    }
                }
                ToolbarItemGroup(placement: .cancellationAction) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Cancel")
                            .foregroundStyle(.red)
                    }
                }
            }
        }
    }
}

#Preview {
    CBAddIngredientView(ingredients: .constant([Ingredient]()))
}
