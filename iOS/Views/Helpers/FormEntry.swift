//
//  FormEntry.swift
//  Grade Tracker
//
//  Created by Matthew Froggatt on 2021-04-01.
//

import SwiftUI

struct FormEntry<Content>: View where Content: View {
    var label: String
    var content: () -> Content

    init(label: String, @ViewBuilder content: @escaping () -> Content) {
        self.label = label
        self.content = content
    }

    var body: some View {
        HStack {
            Text(label).font(.headline)
            content()
        }
    }
}

struct FormEntry_Previews: PreviewProvider {
    static var previews: some View {
        FormEntry(label: "Test") {
            Text("hello world")
        }
    }
}
