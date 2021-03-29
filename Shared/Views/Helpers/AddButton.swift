//
//  AddButton.swift
//  Grade Tracker (iOS)
//
//  Created by Matthew Froggatt on 2021-03-21.
//

import SwiftUI

struct AddButton: View {
    var action: () -> Void
    var body: some View {
        Button(action: action) {
            Image(systemName: "plus.circle")
        }
    }
}

struct AddButton_Previews: PreviewProvider {
    static var previews: some View {
        AddButton(action: {})
    }
}
