//
//  ClassDetailView.swift
//  ClassTracker
//
//  Created by Sebastian Kassai on 2024.01.06.
//

import SwiftUI
import SFSymbolsPicker

struct StudyClassDetailView: View {
    @Environment(\.presentationMode) private var presentationMode
    @Environment(\.modelContext)     private var modelContext
    
    @State var studyClass: StudyClass = .defaultNew
    
    @State var isSymbolPickerPresented = false;
    @State var selectedColor: Color
    
    init(studyClass: StudyClass) {
        _studyClass    = State(initialValue: studyClass)
        _selectedColor = State(initialValue: studyClass.color.color)
    }
    
    var body: some View {
        VStack {
            
            Form {
                Section("Basics") {
                    TextField("Class name",  text: $studyClass.name)
                    TextField("Description", text: $studyClass.info)
                }
                
                Section("Customization") {
                    // TODO: this could use a better preview
                    Button(action: { isSymbolPickerPresented = true }) {
                        Label("Choose icon...", systemImage: studyClass.iconName)
                    }.sheet(isPresented: $isSymbolPickerPresented, content: {
                        SymbolsPicker(selection: $studyClass.iconName, title: "Select icon...", autoDismiss: true)
                            .symbolRenderingMode(.multicolor)
                            .padding()
                    })
                    
                    Button(action: {}) {
                        Label("Choose color...", systemImage: "square.fill")
                            .overlay {
                                // TODO: HACK!
                                ColorPicker("", selection: $selectedColor)
                                    .labelsHidden()
                                    .scaleEffect(CGSize(width: 20.0, height: 20.0))
                                    .opacity(0.015)
                                    .onChange(of: selectedColor, {
                                        studyClass.color = ColorData(selectedColor)
                                    })
                            }
                    }
                }
                
                Section("Event settings") {
                    DatePicker("From", selection: $studyClass.dateRange.start)
                    DatePicker("To",   selection: $studyClass.dateRange.end)
                    
                    TimePicker($studyClass.duration)
                }
                
                Section("Notes") {
                    
                }
                Section("Debug") {
                    
                }
            }
            //.scrollContentBackground(.hidden)
            
        }
        .tint(selectedColor)
        .toolbar {
            ToolbarItem {
                Button(role: .destructive, action: deleteClass, label: { Label("Delete", systemImage: "trash") }).tint(.red)
            }
        }
    }
 
    func deleteClass() {
        modelContext.delete(studyClass)
        try! modelContext.save()
        presentationMode.wrappedValue.dismiss()
    }
}

#Preview {
    StudyClassDetailView(studyClass: .defaultNew)
}
