// Kaan Ege Kutluer - Clock
import SwiftUI

struct ContentView: View {
    // Variables that can change while the app is running
    @State var hour = 0
    @State var minute = 0
    
    // The minute hand moves 6 degrees per minute (360° / 60 = 6)
    var minuteAngle: Angle { .degrees(Double(minute) * 6) } 
    
    // The hour hand moves 30 degrees per hour (360° / 12 = 30)
    // It also slightly moves as minutes pass (minute / 2 adds that smooth shift)
    var hourAngle: Angle {
        let base = Double(hour % 12) * 30.0 // base angle for the hour
        let quarter = Double(minute / 2)    // adds partial movement for minutes
        return .degrees(base + quarter)     // total rotation of the hour hand
    }
    
    // Displays "AM" if hour < 12, otherwise "PM"
    var AMPM: String { hour < 12 ? "AM" : "PM" }
    
    // Converts 24-hour format to 12-hour format (e.g. 13 → 1)
    var displayHour: Int { 
        let h = hour % 12 
        return h == 0 ? 12 : h // show 12 instead of 0
    }
    
    var body: some View {
        ZStack {
            // Background circle: yellow for AM, indigo for PM
            ZStack {
                (hour < 12 ? Color.yellow : Color.indigo)
                    .clipShape(Circle())     // make it round
                    .frame(width: 400, height: 400) // size of clock face
            }
            
            // Minute hand (longer and thinner)
            Rectangle()
                .frame(width: 6, height: 160) // shape and size
                .foregroundColor(.black)      // color of the hand
                .offset(y: -60)               // move upwards so it rotates from center
                .rotationEffect(minuteAngle)  // rotate according to minute
            
            // Hour hand (shorter and thicker)
            Rectangle()
                .frame(width: 10, height: 110)
                .foregroundColor(.black)
                .offset(y: -40)
                .rotationEffect(hourAngle)    // rotate according to hour
            
            // Small center circle
            Circle()
                .frame(width: 20, height: 20)
                .foregroundColor(.white)
        }
        
        VStack(spacing: 20) {
            // Digital time display (e.g. "03:07 PM")
            Text(String(format: "%02d:%02d %@", displayHour, minute, AMPM))
                .font(.title)
                .bold()
                .foregroundColor(.white)
            
            // Buttons to change the hour
            HStack(spacing: 22) {
                Button("Subtract 1 Hour") {
                    // If hour is 0, go back to 23
                    if hour == 0 {
                        hour = 23
                    } else {
                        hour -= 1
                    }
                }
                .buttonStyle(.borderedProminent)
                
                Button("Add 1 Hour") {
                    // If hour is 24, reset to 0
                    if hour == 24 {
                        hour = 0
                    } else {
                        hour += 1
                    }
                }
                .buttonStyle(.borderedProminent)
            }
            
            // Buttons to change the minute
            HStack(spacing: 22) {
                Button("Subtract 1 Minute") {
                    // If minute is 0, go back 1 hour and set minute to 59
                    if minute == 0 {
                        if hour == 0 {
                            hour = 23
                        } else {
                            hour -= 1
                        }
                        minute = 59
                    } else {
                        minute -= 1 
                    }
                }
                .buttonStyle(.borderedProminent)
                
                Button("Add 1 Minute") {
                    // If minute is 59, add one hour and reset minutes to 0
                    if minute == 59 {
                        minute = 0
                        hour += 1
                    } else {
                        minute += 1   
                    }
                }
                .buttonStyle(.borderedProminent)
            }
        }
        // Smooth animation when clock hands move
        .animation(.snappy(duration: 0.5), value: hourAngle)
        .animation(.snappy(duration: 0.5), value: minuteAngle)
    }
}

