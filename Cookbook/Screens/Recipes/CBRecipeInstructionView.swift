//
//  CBRecipeInstructionView.swift
//  Cookbook
//
//  Created by Vishaal Kumar on 7/29/24.
//

import SwiftUI

struct CBRecipeInstructionView: View {
    
    let recipe: Recipe
    @State private var stepType: StepType = .preparation
    @Binding var isShowingInstructionView: Bool
    
    var body: some View {
        VStack {
            Text(recipe.name)
                .font(.title2)
                .fontWeight(.bold)
                .padding(.top, 50)
            
            Picker("Step Type", selection: $stepType) {
                ForEach(StepType.allCases) { stepType in
                    Text(stepType.rawValue.capitalized)
                }
            }
            .padding()
            .pickerStyle(.segmented)
            
            HStack(spacing: 10) {
                Image(systemName: stepType == .preparation ? "carrot" : "frying.pan")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .tint(.secondary)
                    .frame(width: 30, height: 30)
                Text(stepType.rawValue.capitalized)
                    .font(.title3)
                    .fontWeight(.semibold)
            }
            .padding(.bottom, 15)

            
            ScrollView(.horizontal) {
                HStack {
                    ForEach(recipe.steps.filter({$0.stepType == stepType})) { step in
                        CBInstructionStepCell(recipeStep: step)
                    }
                }
                .scrollTargetLayout()
            }
            .scrollIndicators(.hidden)
            .scrollTargetBehavior(.viewAligned)
            .safeAreaPadding(.horizontal, 30)
            
            Spacer()
                .frame(height: 50)
            
        }
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(radius: 40)
        .overlay(Button {
            isShowingInstructionView = false
        } label: {
            FloatingButton(systemImageName: "xmark", width: 30, height: 30, imageScale: .small)
                .padding(10)
        }, alignment: .topTrailing)
        .padding()
    }
}

#Preview {
    CBRecipeInstructionView(recipe: RecipeMockData.sampleRecipe, isShowingInstructionView: .constant(false))
}
