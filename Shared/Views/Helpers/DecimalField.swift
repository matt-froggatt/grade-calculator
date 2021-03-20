//
//  DecimalField.swift
//  Grade Tracker (iOS)
//
//  Created by Matthew Froggatt on 2021-03-19.
//

import SwiftUI
import Combine

struct DecimalField: View {
    var message: String
    @Binding var number: Decimal
    @State private var strNumber = ""

    var body: some View {
        TextField(message, text: $strNumber)
            .keyboardType(.numberPad)
            .onReceive(Just(strNumber)) { newValue in
                    self.strNumber = newValue
                    let tmp = Decimal(string: self.strNumber)
                    number = tmp != nil ? tmp! : number
                }
    }
}

struct DecimalFieldPreviewWrapper: View {
    @State var number: Decimal
    
    var body: some View {
        VStack {
            DecimalField(message: "Test message", number: $number)
            Text("\(NSDecimalNumber(decimal: number))")
        }
    }
}

struct DecimalField_Previews: PreviewProvider {
    static var previews: some View {
        DecimalFieldPreviewWrapper(number: 0)
    }
}
