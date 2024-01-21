//
//  TimePicker.swift
//  ClassTracker
//
//  Created by Sebastian Kassai on 2024.01.06.
//

import SwiftUI

extension UIPickerView {
  open override var intrinsicContentSize: CGSize {
    return CGSize(width: UIView.noIntrinsicMetric , height: 150)
  }
}

struct TimePickerValues: Codable {
  init(_ hours: Int, _ minutes: Int, _ seconds: Int) {
    self.hours = hours
    self.minutes = minutes
    self.seconds = seconds
  }
  
  var hours   : Int
  var minutes : Int
  var seconds : Int
  
  func asSeconds() -> Int {
    return (hours * 3600) + (minutes * 60) + seconds
  }
  
  static var zeros: TimePickerValues {
    return TimePickerValues(0,0,0)
  }
}

struct TimePicker: View {
  @Binding var timeValues: TimePickerValues
  
  init(_ values: Binding<TimePickerValues>) {
    self._timeValues = values
  }
  
  var body: some View {
    HStack {
      VStack {
        Picker("hours", selection: $timeValues.hours) {
          ForEach(0..<13) { number in
            Text("\(number)").tag(number)
          }
        }.clipped().frame(height: 140)
        Text("hours")
      }
      
      VStack {
        Picker("minutes", selection: $timeValues.minutes) {
          ForEach(0..<60) { number in
            Text("\(number)").tag(number)
          }
        }.clipped().frame(height: 140)
        Text("minutes")
      }
      
      VStack {
        Picker("seconds", selection: $timeValues.seconds) {
          ForEach(0..<60) { number in
            Text("\(number)").tag(number)
          }
        }.clipped().frame(height: 140)
        Text("seconds")
      }
    }
    .foregroundColor(.secondary)
    .pickerStyle(.wheel)
    .padding()
  }
}

#Preview {
  TimePicker(.constant(.zeros))
}
