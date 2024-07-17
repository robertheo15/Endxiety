//
//  EndxietyApp.swift
//  Endxiety
//
//  Created by robert theo on 16/07/24.
//

import SwiftUI
import SwiftData

@main
struct EndxietyApp: App {
    let modelContainer: ModelContainer
    
    init() {
        do{
            modelContainer = try ModelContainer(for: Note.self)
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
        
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(modelContainer)
    }
}
