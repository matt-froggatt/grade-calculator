//
//  DecimalField.swift
//  Grade Tracker (iOS)
//
//  Created by Matthew Froggatt on 2021-03-19.
//

import Combine
import SwiftUI

struct DecimalField: View {
    var message: String
    @Binding var number: Decimal?
    @State private var strNumber = ""
    @State private var hasBeenShown = false

    private func sanitizeInput(newValue: Just<String>.Output) {
        if hasBeenShown == false {
            strNumber = number != nil ? "\(NSDecimalNumber(decimal: number!))" : ""
            hasBeenShown = true
        }
        else {
            let filtered = newValue.filter { "0123456789.".contains($0) }
            if filtered != newValue {
                strNumber = filtered
            } else {
                number = Decimal(string: strNumber)
            }
        }
    }

    private func showDefault() {
        strNumber = number != nil ? "\(NSDecimalNumber(decimal: number!))" : ""
    }

    var body: some View {
        TextField(message, text: $strNumber)
            .keyboardType(.numberPad)
            .onReceive(Just(strNumber), perform: sanitizeInput)
    }
}

struct DecimalFieldPreviewWrapper: View {
    @State var number1: Decimal?
    @State var number2: Decimal?

    var body: some View {
        VStack {
            VStack {
                DecimalField(message: "No start number", number: $number1)
                Text(number1 != nil ? "\(NSDecimalNumber(decimal: number1!))" : "")
            }
            VStack {
                DecimalField(message: "Start number", number: $number2)
                Text(number2 != nil ? "\(NSDecimalNumber(decimal: number2!))" : "")
            }
        }
    }
}

struct DecimalField_Previews: PreviewProvider {
    static var previews: some View {
        DecimalFieldPreviewWrapper(number1: 0, number2: 2)
    }
}
