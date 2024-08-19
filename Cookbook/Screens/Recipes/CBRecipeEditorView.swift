//
//  CBEditRecipeView.swift
//  Cookbook
//
//  Created by Vishaal Kumar on 8/2/24.
//

import SwiftUI
import SwiftData
import PhotosUI

struct CBRecipeEditorView: View {
    
    @Environment(\.modelContext) var context
    let recipe: Recipe?
    
    @State private var name: String = ""
    @State private var caption: String = ""
    @State private var ingredients: [Ingredient] = []
    @State private var imageData: Data? = nil
    @State private var steps: [RecipeStep] = []

    @State private var calories: Int = 0
    @State private var protein: Int = 0
    @State private var carbs: Int = 0
    @State private var fats: Int = 0
    
    
    @State private var isShowingEditStepSheet: Bool = false
    @State private var isShowingAddIngredientSheet: Bool = false
    
    @State private var selectedItem: PhotosPickerItem?
    @State private var recipeImage: Image?
    @State private var selectedStep: RecipeStep?
    
    @Environment(\.dismiss) var dismiss
        
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Recipe Image")) {
                    
                    if let recipeImage {
                        recipeImage
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: 250)
                    } else {
                        Image("food-placeholder")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: 250)
                    }
                    
                    PhotosPicker("Change image", selection: $selectedItem, matching: .images)
                }
                .onChange(of: selectedItem) {
                    loadImage()
                }
                
                Section(header: Text("Recipe Details")) {
                    TextField("Recipe Name", text: $name)
                    TextField("Caption", text: $caption)
                }
                
                Section(header: Text("Ingredients")) {
                    List {
                        ForEach($ingredients) { ingredient in
                            HStack {
                                Image(ingredient.imageName.wrappedValue)
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                Text(ingredient.name.wrappedValue)
                                Spacer()
                                Text(ingredient.measurement.wrappedValue.string())
                            }
                        }
                        .onDelete{ indexSet in
                            for index in indexSet {
                                ingredients.remove(at: index)
                            }
                        }
                        Button {
                            isShowingAddIngredientSheet = true
                        } label: {
                            Text("Add New Ingredient")
                        }
                    }
                    
                }
                
                Section(header: Text("Nutritional Information")) {
                    HStack {
                        Text("Calories:")
                        TextField("Calories", value: $calories, format: .number)
                            .multilineTextAlignment(.trailing)
                    }
                    
                    HStack {
                        Text("Protein:")
                        TextField("Calories", value: $protein, format: .number)
                            .multilineTextAlignment(.trailing)
                    }
                    
                    HStack {
                        Text("Carbs:")
                        TextField("Carbs", value: $carbs, format: .number)
                            .multilineTextAlignment(.trailing)
                    }
                    
                    HStack {
                        Text("Fats:")
                        TextField("Fats", value: $fats, format: .number)
                            .multilineTextAlignment(.trailing)
                    }
                }
                
                Section(header: Text("Preparation Steps:")) {
                    List {
                        ForEach(steps.filter({$0.stepType == .preparation})) { step in
                            Button {
                                selectedStep = step
                                isShowingEditStepSheet = true
                            } label: {
                                Text(.init(step.toString()))
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
                
                Section(header: Text("Cooking Steps:")) {
                    ForEach(steps.filter({$0.stepType == .cooking})) { step in
                        Button {
                            selectedStep = step
                            isShowingEditStepSheet = true
                        } label: {
                            Text(.init(step.toString()))
                        }
                        .buttonStyle(.plain)
                    }
                }
                
                Button {
                    selectedStep = nil
                    isShowingEditStepSheet = true
                } label: {
                    Text("Add New Step")
                }
            }
            .toolbar {
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button {
                        save()
                        dismiss()
                    } label: {
                        Text((recipe != nil) ? "Save" : "Add")
                    }
                }
                
                ToolbarItemGroup(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Cancel")
                            .foregroundStyle(.red)
                    }
                }
            }
            .onAppear {
                loadExistingData()
            }
            .sheet(isPresented: $isShowingAddIngredientSheet, content: {
                CBAddIngredientView(ingredients: $ingredients)
            })
            .sheet(isPresented: $isShowingEditStepSheet, content: {
                if let selectedStep {
                    CBEditStepView(steps: $steps,
                                   index: steps.firstIndex(of: selectedStep))
                } else {
                    CBEditStepView(steps: $steps)
                }
            })
        }
        
        
    }
    
    func save() {
        if let recipe {
            recipe.name = name
            recipe.caption = caption
            recipe.ingredients = ingredients
            recipe.steps = steps
            recipe.calories = calories
            recipe.protein = protein
            recipe.carbs = carbs
            recipe.fats = fats
            recipe.imageData = imageData
        } else {
            let newRecipe = Recipe(name: name,
                                   caption: caption,
                                   imageData: imageData,
                                   ingredients: ingredients,
                                   steps: steps,
                                   calories: calories,
                                   protein: protein,
                                   carbs: carbs,
                                   fats: fats)
            context.insert(newRecipe)
        }
    }
    
    func loadExistingData() {
        Task {
            guard let recipe else {
                return
            }
            
            name = recipe.name
            caption = recipe.caption
            ingredients = recipe.ingredients
            steps = recipe.steps
            calories = recipe.calories
            protein = recipe.protein
            carbs = recipe.carbs
            fats = recipe.fats
            
            guard let imageData = recipe.imageData else { return }
            
            guard let uiImage = UIImage(data: imageData) else { return }
            
            recipeImage = Image(uiImage: uiImage)
        }
        
    }
    
    func loadImage() {
        Task {
            guard let imageData = try await selectedItem?.loadTransferable(type: Data.self) else { return }
            
            guard let uiImage = UIImage(data: imageData) else { return }
            
            recipeImage = Image(uiImage: uiImage)
            self.imageData = imageData
        }
    }
}

#Preview {
    CBRecipeEditorView()
}
