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
    @Binding var number: Decimal
    @State private var strNumber = ""

    var body: some View {
        TextField(message, text: $strNumber)
            .keyboardType(.numberPad)
            .onAppear {
                self.strNumber = !number.isZero ? "\(NSDecimalNumber(decimal: number))" : ""
            }
            .onReceive(Just(strNumber)) { newValue in
                let filtered = newValue.filter { "0123456789.".contains($0) }
                if filtered != newValue {
                    self.strNumber = filtered
                } else {
                    let tmp = Decimal(string: self.strNumber)
                    number = tmp != nil ? tmp! : number
                }
            }
    }
}

struct DecimalFieldPreviewWrapper: View {
    @State var number1: Decimal
    @State var number2: Decimal

    var body: some View {
        VStack {
            VStack {
                DecimalField(message: "No start number", number: $number1)
                Text("\(NSDecimalNumber(decimal: number1))")
            }
            VStack {
                DecimalField(message: "Start number", number: $number2)
                Text("\(NSDecimalNumber(decimal: number2))")
            }
        }
    }
}

struct DecimalField_Previews: PreviewProvider {
    static var previews: some View {
        DecimalFieldPreviewWrapper(number1: 0, number2: 2)
    }
}
