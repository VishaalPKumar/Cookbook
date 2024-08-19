//
//  CBEditStepView.swift
//  Cookbook
//
//  Created by Vishaal Kumar on 8/1/24.
//

import SwiftUI

struct CBEditStepView: View {
    
    @Environment(\.dismiss) var dismiss
    @Binding var steps: [RecipeStep]
    @State var step: RecipeStep = RecipeStep()
    var index: Int?
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section(header: Text("Step Details")) {
                        HStack {
                            Text("Title")
                                .padding(.trailing)
                            Divider()
                            TextField("Step Title", text: $step.stepTitle)
                                .multilineTextAlignment(.trailing)
                        }
                        
                        Picker("Step Type", selection: $step.stepType) {
                            ForEach(StepType.allCases) { stepType in
                                Text(stepType.rawValue.capitalized)
                            }
                        }
                    }
                    
                    if step.stepType == .cooking {
                        Section(header: Text("Cooking Options")) {
                            Picker("Heat Level", selection: $step.heatLevel) {
                                ForEach(HeatLevel.allCases) { heatLevel in
                                    Text(heatLevel.rawValue)
                                }
                            }
                            
                            HStack {
                                Text("Duration")
                                Divider()
                                TextField("Duration", value: $step.duration, format: .number)
                                    .multilineTextAlignment(.trailing)
                            }
                        }
                    }
                }
                Text("Instructions:")
                TextEditor(text: $step.instructions)
                    .padding()
            }
            .onAppear {
                loadExistingData()
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button {
                        if let index {
                            steps[index] = step
                        } else {
                            steps.append(step)
                        }
                        dismiss()
                    } label: {
                        Text(index != nil ? "Save" : "Add")
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
        }
    }
    func loadExistingData() {
        if let index {
            step = steps[index]
        }
    }
    
}

#Preview {
    CBEditStepView(steps: .constant(RecipeMockData.sampleRecipe.steps), step: RecipeMockData.stepOne)
}
