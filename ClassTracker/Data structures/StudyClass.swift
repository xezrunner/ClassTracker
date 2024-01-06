//
//  Item.swift
//  ClassTracker
//
//  Created by Sebastian Kassai on 2024.01.05.
//

import Foundation
import SwiftData
import SwiftUI

@Model
final class StudyClass: Identifiable {
    var id: UUID = UUID()
    
    var name:     String
    var enabled:  Bool
    var info:     String
    
    var color:    ColorData
    var iconName: String
    
    var dateRange: DateInterval
    var duration:  TimePickerValues
    
    // TODO: more with notes?
    // Link to and integrate with Reminders and Calendar?
    var notes: [String]
    
    convenience init() {
        self.init(
            name: "<#> New study class",
            enabled: true, 
            info: "Description for this class.",
            color: ColorData(.brown),
            iconName: "clock.circle",
            dateRange: DateInterval(start: .now, end: .distantFuture),
            duration: StudyClass.defaultDuration,
            notes: []);
    }
    init(name: String, enabled: Bool, info: String, color: ColorData, iconName: String, dateRange: DateInterval, duration: TimePickerValues, notes: [String]) {
        self.name = name
        self.enabled = enabled
        self.info = info
        self.color = color
        self.iconName = iconName
        self.dateRange = dateRange
        self.duration = duration
        self.notes = notes
    }
    
    public static var defaultNew: StudyClass {
        return StudyClass(name: "A class",
                          enabled: true,
                          info: "Class where we learn about things.",
                          color: ColorData(Color.blue),
                          iconName: "graduationcap.circle",
                          dateRange: DateInterval(start: .now, end: .distantFuture),
                          duration: StudyClass.defaultDuration,
                          notes: [])
    }
    
    public static var defaultDuration: TimePickerValues {
        return TimePickerValues(0,45,0)
    }
}
