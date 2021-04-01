//
//  ProgressCapsule.swift
//  Grade Tracker
//
//  Created by Matthew Froggatt on 2021-03-31.
//

import SwiftUI

struct ProgressCapsule: View {
    var progress: CGFloat = 1
    var total: CGFloat = 1

    var body: some View {
        GeometryReader { geometry in
            Capsule()
                .fill(Color.accentColor)
                .frame(
                    width: geometry.size.width
                        * (progress
                            / total),
                    height: geometry.size.height / 2
                )
                .offset(y: geometry.size.height / 4)
        }
    }
}

struct ProgressCapsule_Previews: PreviewProvider {
    static var previews: some View {
        ProgressCapsule()
    }
}
