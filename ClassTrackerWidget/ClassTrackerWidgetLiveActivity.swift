//
//  ClassTrackerWidgetLiveActivity.swift
//  ClassTrackerWidget
//
//  Created by Sebastian Kassai on 2024.01.21.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct ClassTrackerWidgetAttributes: ActivityAttributes {
  public struct ContentState: Codable, Hashable {
    // Dynamic stateful properties about your activity go here!
    var seconds: Int
  }
  
  // Fixed non-changing properties about your activity go here!
  var name       : String
  var description: String
  var icon       : String
  var color      : ColorData
  var durationSec: Int
}

struct ClassTrackerWidgetLiveActivity: Widget {
  var body: some WidgetConfiguration {
    ActivityConfiguration(for: ClassTrackerWidgetAttributes.self) { context in
      // Lock screen/banner UI goes here
      HStack {
        ProgressView(value: (Double(context.state.seconds / context.attributes.durationSec))) {
          Image(systemName: context.attributes.icon)
            .resizable()
            //.symbolRenderingMode(.multicolor)
            .frame(width: 20, height: 20)
            .foregroundStyle(context.attributes.color.color)
        }
        .frame(width: 50, height: 50)
        .progressViewStyle(.circular)
        .padding([.horizontal], 12)
        
        VStack(alignment: .leading) {
          Text(context.attributes.name)
            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
            .foregroundStyle(context.attributes.color.color)
          
//          Text(context.attributes.description)
//            .font(.system(size: 14))
        }
        
        Spacer()
        
        Text("0:00:60")
          .font(.system(size: 14))
        
        HStack {
//          Button(action: {}) {
//            Image(systemName: "info.circle")
//              .resizable()
//              .frame(width: 30, height: 30)
//          }
//          .buttonStyle(.borderless)
          
          Button(action: {}) {
            Image(systemName: "stop.fill")
              .resizable()
              .frame(width: 15, height: 15)
              .padding(2)
              .foregroundStyle(.red)
          }
          .buttonStyle(.bordered)
          .buttonBorderShape(.circle)
        }
        .padding()
      }
      .padding()
      .activityBackgroundTint(Color.red)
      .activitySystemActionForegroundColor(Color.black)
      
    } dynamicIsland: { context in
      DynamicIsland {
        // Expanded UI goes here.  Compose the expanded UI through
        // various regions, like leading/trailing/center/bottom
        DynamicIslandExpandedRegion(.leading) {
          
        }
        DynamicIslandExpandedRegion(.trailing) {
          
        }
        DynamicIslandExpandedRegion(.bottom) {
          HStack {
            ProgressView(value: (Double(context.state.seconds / context.attributes.durationSec))) {
              Image(systemName: context.attributes.icon)
                .resizable()
                //.symbolRenderingMode(.multicolor)
                .frame(width: 20, height: 20)
                .foregroundStyle(context.attributes.color.color)
            }
            .frame(width: 50, height: 50)
            .progressViewStyle(.circular)
            .padding([.horizontal], 12)
            
            VStack(alignment: .leading) {
              Text(context.attributes.name)
                .font(.headline)
                .foregroundStyle(context.attributes.color.color)
              
//              Text(context.attributes.description)
//                .foregroundStyle(.foreground)
//                .font(.system(size: 14))
            }
            
            Spacer()
            
            Text("00:00:60")
            
            HStack {
//              Button(action: {}) {
//                Image(systemName: "info")
//              }
              
              Button(action: {}) {
                Image(systemName: "stop.fill")
                  .resizable()
                  .frame(width: 15, height: 15)
                  .padding(2)
                  .foregroundStyle(.red)
                  
              }
            }
            .padding()
            .buttonBorderShape(.circle)
          }
        }
      } compactLeading: {
        ProgressView(value: (Double(context.state.seconds / context.attributes.durationSec))) {
          Image(systemName: context.attributes.icon)
            .resizable()
            .frame(width: 10, height: 10)
            //.symbolRenderingMode(.multicolor)
            .foregroundStyle(context.attributes.color.color)
        }
        .frame(width: 25, height: 25)
        .progressViewStyle(.circular)
      } compactTrailing: {
        Text("00:60")
          .foregroundStyle(context.attributes.color.color)
      } minimal: {
        ProgressView(value: (Double(context.state.seconds / context.attributes.durationSec))) {
          Image(systemName: context.attributes.icon)
            .resizable()
            .frame(width: 10, height: 10)
            //.symbolRenderingMode(.multicolor)
            .foregroundStyle(context.attributes.color.color)
        }
        .frame(width: 25, height: 25)
        .progressViewStyle(.circular)
      }
      .widgetURL(URL(string: "http://www.apple.com"))
      .keylineTint(Color.red)
    }
  }
}

extension ClassTrackerWidgetAttributes {
  fileprivate static var preview: ClassTrackerWidgetAttributes {
    ClassTrackerWidgetAttributes(name: "A class", description: "Description for this class", icon: "sparkles", color: ColorData(.blue), durationSec: 60)
  }
}

extension ClassTrackerWidgetAttributes.ContentState {
  fileprivate static var smiley: ClassTrackerWidgetAttributes.ContentState {
    ClassTrackerWidgetAttributes.ContentState(seconds: 60)
  }
  
  fileprivate static var starEyes: ClassTrackerWidgetAttributes.ContentState {
    ClassTrackerWidgetAttributes.ContentState(seconds: 60)
  }
}

#Preview("Notification", as: .content, using: ClassTrackerWidgetAttributes.preview) {
  ClassTrackerWidgetLiveActivity()
} contentStates: {
  ClassTrackerWidgetAttributes.ContentState(seconds: 60)
}
