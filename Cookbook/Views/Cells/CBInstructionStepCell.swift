//
//  CBInstructionStepCell.swift
//  Cookbook
//
//  Created by Vishaal Kumar on 7/30/24.
//

import SwiftUI

struct CBInstructionStepCell: View {
    let recipeStep: RecipeStep
    
    var body: some View {
        ZStack {
            VStack {
                
                StepTitle(recipeStep: recipeStep)
                
                Divider()
                    .padding(.horizontal)
                
                Spacer()
                Text(recipeStep.instructions)
                    .font(.title3)
                    .fontWeight(.light)
                    .multilineTextAlignment(.center)
                
                Spacer()
            }
            .padding()
            
        }
        .frame(width: 300, height: 300)
        .background(Color(.cream))
        .foregroundStyle(Color(.black))
        .cornerRadius(30)
        
    }
}


struct StepTitle: View {
    
    let recipeStep: RecipeStep
    
    var body: some View {
        if !recipeStep.stepTitle.isEmpty {
            Text(recipeStep.stepTitle)
                .font(.title3)
                .fontWeight(.bold)
        }
        
        if recipeStep.stepType == .cooking {
            HStack {
                switch recipeStep.heatLevel {
                case .low:
                    Label("Low", systemImage: "thermometer.high")
                        .foregroundStyle(.yellow)
                        .fontWeight(.bold)
                case .medium:
                    Label("Medium", systemImage: "thermometer.orange")
                        .foregroundStyle(.red)
                        .fontWeight(.bold)
                case .mediumHigh:
                    Label("Medium-High", systemImage: "thermometer.high")
                        .foregroundStyle(.orange)
                        .fontWeight(.bold)
                case .high:
                    Label("High", systemImage: "thermometer.high")
                        .foregroundStyle(.red)
                        .fontWeight(.bold)
                }
                Label("\(recipeStep.duration) minutes", systemImage: "timer")
            }
        }
    }
    
}

#Preview {
    CBInstructionStepCell(recipeStep: RecipeMockData.stepTwo)
}
