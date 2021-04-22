//
//  DeletableRow.swift
//  Grade Tracker (iOS)
//
//  Created by Matthew Froggatt on 2021-03-30.
//

import CoreData
import SwiftUI
import SwipeCellSUI

struct DeletableRow<Content: View>: View {
    @State private var isPinned: Bool = false
    var availableWidth: CGFloat
    var item: String
    var onDelete: (String) -> Void
    @Binding var currentUserInteractionCellID: String?
    var content: () -> Content

    func rightGroup() -> [SwipeCellActionItem] {
        [
            SwipeCellActionItem(
                buttonView: {
                    trashView(swipeOut: false).castToAnyView()
                },
                swipeOutButtonView: {
                    trashView(swipeOut: true).castToAnyView()
                },
                backgroundColor: .clear,
                swipeOutAction: true,
                swipeOutHapticFeedbackType: .warning,
                swipeOutIsDestructive: true,
                actionCallback: {
                    onDelete(item)
                }
            )
        ]
    }

    func trashView(swipeOut: Bool) -> some View {
        Card {
            VStack(spacing: 3) {
                Image(systemName: "trash")
                    .font(.system(size: swipeOut ? 28 : 22))
                    .foregroundColor(.accentColor)
                Text("Delete").fixedSize()
                    .font(.system(size: swipeOut ? 16 : 12))
                    .foregroundColor(.accentColor)
            }
            .padding()
        }
        .accentColor(.red)
    }

    var body: some View {
        content()
            .swipeCell(
                id: self.item,
                cellWidth: availableWidth,
                leadingSideGroup: [],
                trailingSideGroup: rightGroup(),
                currentUserInteractionCellID: $currentUserInteractionCellID
            )
    }
}

private struct PreviewWrapper: View {
    @State var thing: String? = "hello"

    var body: some View {
        let grades: [GradeModel] = (try? PersistenceController.preview.container
            .viewContext.fetch(NSFetchRequest(entityName: "GradeModel")) as [GradeModel]) ?? []
        GeometryReader { geometry in
            DeletableRow(
                availableWidth: geometry.size.width,
                item: "hello",
                onDelete: { (_: String) -> Void in },
                currentUserInteractionCellID: $thing,
                content: {
                    CourseCard(
                        courseName: "Test",
                        school: .UW,
                        credits: 0.5,
                        grade: grades[0],
                        goal: grades[1]
                    )
                    .padding()
                }
            )
        }
    }
}

struct DeletableRow_Previews: PreviewProvider {
    static var previews: some View {
        PreviewWrapper()
    }
}
