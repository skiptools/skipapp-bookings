import SwiftUI

/// A custom button to dismiss the current view and go back in the navigation hierarchy
struct DismissButton : View {
    @Environment(\.layoutDirection) var layoutDirection
    @Environment(\.dismiss) var dismiss

    var body: some View {
        Button {
            dismiss()
        } label: {
            // A custom back button image
            Chevron()
                .scale(x: layoutDirection == .rightToLeft ? -1.0 : 1.0)
                .stroke(style: StrokeStyle(lineWidth: 4, lineCap: .round, lineJoin: .bevel))
                .frame(width: 18, height: 18)
                .accessibilityLabel(Text("Back"))
        }
    }
}

/// A simple chevron shape to act as a custom back button
struct Chevron: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
        return path
    }
}

