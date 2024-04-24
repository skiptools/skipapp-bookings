import SwiftUI

/// A custom button to dismiss the current view and go back in the navigation hierarchy
struct DismissButton : View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        HStack(alignment: .center) {
            Button {
                dismiss()
            } label: {
                // A custom back button image
                Chevron()
                    .stroke(style: StrokeStyle(lineWidth: 4, lineCap: .round, lineJoin: .bevel))
                    .foregroundStyle(.white)
                    .frame(width: 20, height: 20)
                    .accessibilityLabel(Text("Back"))
            }
            .padding()

            Spacer()
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

