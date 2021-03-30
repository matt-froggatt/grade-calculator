//
//  Card.swift
//  Grade Tracker (iOS)
//
//  Created by Matthew Froggatt on 2021-03-30.
//

import SwiftUI

struct Card<Content: View>: View {
    var contents: () -> Content

    var body: some View {
        contents()
            .background(
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .stroke(Color.gray)
            )
    }
}

struct Card_Previews: PreviewProvider {
    static var previews: some View {
        Card {
            Text("hello")
        }
    }
}
