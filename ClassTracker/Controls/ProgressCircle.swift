//
//  ProgressCircle.swift
//  classtimetracker
//
//  Created by Sebastian Kassai on 02/03/2023.
//

import SwiftUI

struct ProgressCircle: View {
    var foregroundColor   : Color = Color(UIColor.systemGreen)
    var backgroundColor   : Color = Color(UIColor.secondarySystemBackground)
    
    var foregroundOpacity : Double = 1
    var backgroundOpacity : Double = 0.55
    
    @State var lineWidth    : Double = 30
    @Binding var progress   : Double
    
    @State private var lineWidth_frac : Double = 0
    @State private var progress_internal  : Double = 0
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(backgroundColor, lineWidth: lineWidth)
                .opacity((max(progress_internal * 2, 1)) * backgroundOpacity)
            
            Circle()
                .trim(from: 0, to: progress_internal)
                .stroke(foregroundColor,
                        style: StrokeStyle(
                            lineWidth: lineWidth,
                            lineCap: .round
                        ))
                .rotationEffect(.degrees(-90))
                .opacity(foregroundOpacity)
        }
        .onAppear {
            withAnimation(.easeOut(duration: 1)) {
                progress_internal = progress
            }
        }
        .onChange(of: progress) {
          withAnimation(.easeOut(duration: 1)) {
              progress_internal = progress
          }
        }
    }
}

struct ProgressCircle_Previews: PreviewProvider {
    static var previews: some View {
        ProgressCircle(progress: .constant(0.35))
            .padding()
    }
}
