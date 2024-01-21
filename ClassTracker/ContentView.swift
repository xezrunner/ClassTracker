//
//  ContentView.swift
//  ClassTracker
//
//  Created by Sebastian Kassai on 2024.01.05.
//

import SwiftUI
import SwiftData

struct ContentView: View {
  @Environment(\.modelContext) private var modelContext
  @Query private var studyClasses: [StudyClass]
  
  var body: some View {
    if (true) {
      NavigationSplitView(columnVisibility: .constant(.doubleColumn)) {
        if studyClasses.count == 0 {
          VStack {
            Image(systemName: "sparkles")
              .symbolRenderingMode(.multicolor)
              .resizable().frame(width: 48, height: 48)
              .padding()
            Text("You have no classes added.").bold()
            Button(action: addFirstItem) { Label("Add a class", systemImage: "plus.circle") }
              .buttonStyle(.bordered).foregroundStyle(Color.accentColor)
              .padding(8)
          }
          .padding(.horizontal, 35)
          .padding(.vertical, 15)
          .foregroundStyle(Color.secondary)
          .background(Color(UIColor.secondarySystemBackground))
          .clipShape(RoundedRectangle(cornerRadius: 8))
          .toolbar {
            ToolbarItem {
              NavigationLink {
                Text("Settings") } label: { Label("Settings", systemImage: "gearshape") }
            }
          }
        } else {
          List() {
            ForEach(studyClasses, id: \.self) { item in
              NavigationLink {
                StudyClassDetailView(studyClass: item)
              } label: {
                HStack {
                  Image(systemName: item.iconName)
                    .resizable()
                    .frame(width: 30, height: 30)
                    .padding(.trailing, 6)
                    .foregroundStyle(item.color.color)
                  VStack(alignment: .leading) {
                    Text(item.name).bold().foregroundStyle(item.color.color)
                    if !item.info.isEmpty { Text(item.info) }
                  }
                }
              }
              .foregroundStyle(Color.primary)
              
            }
            .onDelete(perform: deleteItems)
          }
          .listStyle(.sidebar)
          .accentColor(Color(UIColor.secondarySystemFill))
          .scrollContentBackground(.hidden)
          .navigationTitle("Classes")
          .toolbar(removing: .sidebarToggle)
          .toolbar {
            ToolbarItem() {
              Menu(content: {
                Button(role: .destructive, action: reset, label: {
                  Label("Delete all", systemImage: "trash")
                })
                NavigationLink {
                  Text("Settings") } label: { Label("Settings", systemImage: "gearshape") }
              }, label: {Image(systemName: "ellipsis.circle")})
            }
            
            ToolbarItemGroup(placement: .topBarTrailing) {
              EditButton()
              Button(action: addItem) { Label("Add Item", systemImage: "plus") }
            }
          }
        }
      } detail: {
        Text("nuh-uh!").bold()
        Text("Nothing is selected.")
      }
      .animation(.default, value: studyClasses)
      .navigationSplitViewStyle(.balanced)
    }
    
  }
  
  private func addFirstItem() {
    withAnimation {
      let newItem = StudyClass.defaultNew
      modelContext.insert(newItem)
    }
  }
  
  private func addItem() {
    withAnimation {
      let newItem = StudyClass.defaultNew
      modelContext.insert(newItem)
    }
  }
  
  private func deleteItems(offsets: IndexSet) {
    withAnimation {
      for index in offsets {
        modelContext.delete(studyClasses[index])
      }
    }
  }
  
  private func reset() {
    withAnimation {
      do {
        try modelContext.delete(model: StudyClass.self)
        try modelContext.save()
      } catch {
        print("Failed to clear.")
      }
    }
  }
}

#if DEBUG
@MainActor
var previewModelContainer: ModelContainer = {
  let schema = Schema([
    StudyClass.self,
  ])
  let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
  do {
    let container = try ModelContainer(for: schema, configurations: [modelConfiguration])
    container.mainContext.insert(StudyClass())
    container.mainContext.insert(StudyClass.defaultNew)
    return container
  } catch {
    fatalError("Could not create ModelContainer: \(error)")
  }
}()
#endif

#Preview {
  ContentView()
    .modelContainer(previewModelContainer)
}
