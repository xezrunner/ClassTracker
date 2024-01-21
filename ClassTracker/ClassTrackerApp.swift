//
//  ClassTrackerApp.swift
//  ClassTracker
//
//  Created by Sebastian Kassai on 2024.01.05.
//

import SwiftUI
import SwiftData

@main
struct ClassTrackerApp: App {
  var sharedModelContainer: ModelContainer = {
    let schema = Schema([
      StudyClass.self,
    ])
    let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
    
    do {
      return try ModelContainer(for: schema, configurations: [modelConfiguration])
    } catch {
      fatalError("Could not create ModelContainer: \(error)")
    }
  }()
  
  init() {
    let context = sharedModelContainer.mainContext
    let descriptor = FetchDescriptor<StudyClass>()
    do {
      let studyClasses = try context.fetch(descriptor)
      
#if DEBUG
      print("[init] \(studyClasses.count) study classes registered:")
      for studyClass in studyClasses {
        print("  - name: \"\(studyClass.name)\"  id: \(studyClass.id)")
      }
#endif
    } catch {
      print("[init] failed to fetch study classes!")
    }
    
    
  }
  
  var body: some Scene {
    WindowGroup {
      ContentView()
    }
    .modelContainer(sharedModelContainer)
  }
}
