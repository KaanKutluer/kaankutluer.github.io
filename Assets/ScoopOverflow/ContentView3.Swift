//Kaan Ege Kutluer
import SwiftUI

// Cone
struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        path.closeSubpath()
        return path
    }
}
struct ContentView: View {
    @State private var scoopCount = 0
    
    // Random scoop colors
    let scoopColors: [Color] = [.pink, .mint, .yellow, .brown, .red]
    
    var body: some View {
        VStack(spacing: 30) {
            
            // 🍦 Ice cream cone
            ZStack(alignment: .bottom) {
                Triangle()
                    .fill(.brown)
                    .frame(width: 120, height: 150)
                
                // Stack scoops visually
                VStack(spacing: -10) {
                    ForEach(0..<scoopCount, id: \.self) { i in
                        ZStack {
                            Circle()
                                .fill(scoopColors[i % scoopColors.count])
                                .frame(width: 90, height: 90)
                            Text("\(i + 1)")
                                .font(.title)
                                .bold()
                                .foregroundColor(.white)
                        }
                    }
                }
                .offset(y: -120)
            }
            .animation(.spring(), value: scoopCount)
            
            // 🍨 Buttons
            HStack {
                Button("Add Scoop") {
                    if scoopCount < 5 {
                        scoopCount += 1
                    } else {
                        // Overflow — reset to empty
                        scoopCount = 0
                        print("OVERFLOW! The ice cream melted 🫠")
                    }
                }
                
                Button("Reset") {
                    scoopCount = 0
                }
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}
