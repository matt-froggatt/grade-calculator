//
//  DeletableRow.swift
//  Grade Tracker (iOS)
//
//  Created by Matthew Froggatt on 2021-03-30.
//

import SwiftUI
import SwipeCellSUI

struct DeletableRow<Content: View>: View {
    var availableWidth: CGFloat
    var item: String
    @State private var isPinned: Bool = false
    var deletionCallback: (String) -> Void
    @Binding var currentUserInteractionCellID: String?
    var content: () -> Content

    var body: some View {
        content()
            .swipeCell(
                id: self.item,
                cellWidth: availableWidth,
                leadingSideGroup: [],
                trailingSideGroup: rightGroup(),
                currentUserInteractionCellID: $currentUserInteractionCellID
            )
//            .onTapGesture {
//                if self.currentUserInteractionCellID != item {
//                    self.currentUserInteractionCellID = item
//                }
//            }
    }

    func rightGroup() -> [SwipeCellActionItem] {
        return [
            SwipeCellActionItem(
                buttonView: {
                    self.trashView(swipeOut: false)
                },
                swipeOutButtonView: {
                    self.trashView(swipeOut: true)
                },
                backgroundColor: .clear,
                swipeOutAction: true,
                swipeOutHapticFeedbackType: .warning,
                swipeOutIsDestructive: true,
                actionCallback: {
                    print("delete action")
                    self.deletionCallback(item)
                }
            )
        ]
    }

    func trashView(swipeOut: Bool) -> AnyView {
        Card {
            VStack(spacing: 3) {
                Image(systemName: "trash").font(.system(size: swipeOut ? 28 : 22)).foregroundColor(.red)
                Text("Delete").fixedSize().font(.system(size: swipeOut ? 16 : 12)).foregroundColor(.red)
            }
            .padding()
        }
        .accentColor(.red)
        .frame(maxHeight: 80)
        .animation(.default)
        .castToAnyView()
    }
}

struct PreviewWrapper: View {
    @State var thing: String? = "hello"

    var body: some View {
        DeletableRow(
            availableWidth: 400,
            item: "hello",
            deletionCallback: {(_: String) -> Void in } ,
            currentUserInteractionCellID: $thing,
            content: {
                CourseCard(
                    courseName: "Test",
                    school: School(name: .UW),
                    credits: 0.5,
                    grade: Grade(percentage: 15),
                    goal: Grade(percentage: 25)
                )
                .padding()
            }
        )
    }
}

struct DeletableRow_Previews: PreviewProvider {
    static var previews: some View {
        PreviewWrapper()
    }
}
