//
//  ProgressPositionIndicator.swift
//  Grade Tracker
//
//  Created by Matthew Froggatt on 2021-04-01.
//

import SwiftUI

struct ProgressPositionIndicator: View {
    var progress: CGFloat
    var total: CGFloat
    var width: CGFloat = 5

    var body: some View {
        GeometryReader { geometry in
            Capsule()
                .offset(x: (progress / total) * geometry.size.width)
                .foregroundColor(.accentColor)
                .frame(width: width, height: geometry.size.height)
                .shadow(radius: 2)
        }
    }
}

struct ProgressPositionIndicator_Previews: PreviewProvider {
    static var previews: some View {
        ProgressPositionIndicator(progress: 50, total: 100)
    }
}
