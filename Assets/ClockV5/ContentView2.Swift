// Kaan Ege Kutluer - Clock
import SwiftUI

struct ContentView: View {
    @State var hour = 0
    @State var minute = 0
    
    var minuteAngle: Angle { .degrees(Double(minute) * 6) }
    var hourAngle: Angle {
        let base = Double(hour % 12) * 30.0
        let quarter = Double(minute) / 2.0
        return .degrees(base + quarter)
    }
    var AMPM: String { hour < 12 ? "AM" : "PM" }
    var displayHour: Int { let h = hour % 12; return h == 0 ? 12 : h }
    
    var body: some View {
        ZStack {
            // Clock background
            (hour < 12 ? Color.yellow : Color.gray)
                .clipShape(Circle())
                .frame(width: 400, height: 400)
                .onTapGesture { // Tap gesture → increase hour
                    hour = (hour + 1) % 24
                }
            
            // Numbers around the clock
            ForEach(1...12, id: \.self) { num in
                let angle = Angle.degrees(Double(num) * 30)
                VStack {
                    Text("\(num)")
                        .font(.title2)
                        .foregroundColor(.white)
                        .bold()
                        .rotationEffect(-angle) // keep numbers upright
                    Spacer()
                }
                .frame(width: 300, height: 300)
                .rotationEffect(angle)
            }
            
            // Minute hand
            Rectangle()
                .frame(width: 6, height: 160)
                .foregroundColor(.black)
                .offset(y: -60)
                .rotationEffect(minuteAngle)
            
            // Hour hand
            Rectangle()
                .frame(width: 10, height: 110)
                .foregroundColor(.black)
                .offset(y: -40)
                .rotationEffect(hourAngle)
            
            // Center circle
            Circle()
                .frame(width: 20, height: 20)
                .foregroundColor(.white)
        }
        
        VStack(spacing: 20) {
            Text(String(format: "%02d:%02d %@", displayHour, minute, AMPM))
                .font(.title)
                .bold()
                .foregroundColor(.white)
            
            HStack(spacing: 22) {
                Button("Subtract 1 Hour") {
                    hour = (hour == 0) ? 23 : hour - 1
                }
                .buttonStyle(.borderedProminent)
                
                Button("Add 1 Hour") {
                    hour = (hour + 1) % 24
                }
                .buttonStyle(.borderedProminent)
            }
            HStack(spacing: 22) {
                Button("Subtract 1 Minute") {
                    if minute == 0 {
                        minute = 59
                        hour = (hour == 0) ? 23 : hour - 1
                    } else {
                        minute -= 1
                    }
                }
                .buttonStyle(.borderedProminent)
                
                Button("Add 1 Minute") {
                    if minute == 59 {
                        minute = 0
                        hour = (hour + 1) % 24
                    } else {
                        minute += 1
                    }
                }
                .buttonStyle(.borderedProminent)
            }
            
            // NEW: Random hour button
            Button("Jump to Random Hour") {
                hour = Int.random(in: 0..<24)
            }
            .buttonStyle(.borderedProminent)
        }
        .animation(.snappy(duration: 0.7), value: hourAngle)
        .animation(.snappy(duration: 0.7), value: minuteAngle)
    }
}

