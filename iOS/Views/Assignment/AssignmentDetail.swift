//
//  AssignmentDetail.swift
//  Grade Tracker
//
//  Created by Matthew Froggatt on 2021-03-19.
//

import SwiftUI

struct AssignmentDetail: View {
    var assignment: Assignment
    
    var body: some View {
        VStack(alignment: .center) {
            Text(assignment.grade != nil ? assignment.grade!.formattedPercentage() : "Enter Grade")
                .font(.title)
                .foregroundColor(.primary)
            Text("Weight - \(NSDecimalNumber(decimal: assignment.weight))")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .navigationTitle(Text(assignment.name))
    }
}

struct AssignmentDetail_Previews: PreviewProvider {
    static var previews: some View {
        AssignmentDetail(assignment: Assignment(id: 1, name: "Assignment with grade", weight: 10, grade: Grade(percentage: 50)))
        AssignmentDetail(assignment: Assignment(id: 1, name: "Assignment without grade", weight: 10))
    }
}
