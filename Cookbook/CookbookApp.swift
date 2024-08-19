//
//  CookbookApp.swift
//  Cookbook
//
//  Created by Vishaal Kumar on 7/28/24.
//

import SwiftUI
import SwiftData

@main
struct CookbookApp: App {
        
    var body: some Scene {
        WindowGroup {
            CBTabView()
        }
        .modelContainer(for: Recipe.self)
    }
}
