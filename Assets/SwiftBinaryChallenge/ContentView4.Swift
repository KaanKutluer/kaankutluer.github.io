import SwiftUI

struct ContentView: View {
    @State private var studentID = 0
    @State private var showOverflow = false
    @State private var binary = "0000"
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Decimal: \(studentID)")
            Text("Binary: \(binary)")
            
            // 4 boxes
            HStack {
                ForEach(Array(binary), id: \.self) { bit in
                    Rectangle()
                        .fill(bit == "1" ? .green : .gray)
                        .frame(width: 50, height: 50)
                        .overlay(Text(String(bit)).foregroundColor(.white))
                        .cornerRadius(8)
                }
            }
            
            // Buttons
            HStack {
                Button("Enroll (+1)") {
                    let oldID = studentID
                    studentID = (studentID + 1) % 16
                    
                    // Update binary string
                    let b = String(studentID, radix: 2)
                    binary = String(repeating: "0", count: 4 - b.count) + b
                    
                    // Show overflow if wrapped
                    showOverflow = (oldID == 15 && studentID == 0)
                }
                .buttonStyle(.borderedProminent)
                
                Button("Reset (0)") {
                    studentID = 0
                    binary = "0000"
                    showOverflow = false
                }
                .buttonStyle(.bordered)
            }
            
            if showOverflow {
                Text("OVERFLOW!")
                    .foregroundColor(.red)
                    .bold()
            }
        }
        .padding()
    }
}
