//
//  MultiProgressBar.swift
//  Grade Tracker
//
//  Created by Matthew Froggatt on 2021-04-01.
//

import SwiftUI

struct MultiProgressBar: View {
    var progress1: CGFloat
    var progress2: CGFloat
    var total: CGFloat
    var barHeight: CGFloat = 10
    var indicatedPosition: CGFloat?
    var indicatorHeight: CGFloat = 20
    var body: some View {
        ZStack {
            Group {
                ProgressCapsule()
                    .accentColor(.gray)
                ProgressCapsule(
                    progress: progress1 + progress2,
                    total: total
                )
                .accentColor(.red)
                ProgressCapsule(
                    progress: progress1,
                    total: total
                )
                .accentColor(.green)
            }
            .frame(height: 10)

            if indicatedPosition != nil {
                ProgressPositionIndicator(
                    progress: indicatedPosition!,
                    total: 100
                )
                .accentColor(.yellow)
                .frame(height: 20)
            }
        }
    }
}

struct MultiProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        MultiProgressBar(
            progress1: 10,
            progress2: 20,
            total: 100,
            barHeight: 10,
            indicatedPosition: 50,
            indicatorHeight: 20
        )
    }
}
