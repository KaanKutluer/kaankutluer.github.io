// Kaan Ege Kutluer
import SwiftUI

struct ContentView: View {
    @State private var n1 = ""
    @State private var n2 = ""
    
    // Computed properties convert text to numbers safely
    var num1: Double { Double(n1) ?? 0 }
    var num2: Double { Double(n2) ?? 0 }
    
    var body: some View {
        VStack(spacing: 15) {
            Text("🧮 Calc-Calc Calculator")
                .font(.title)
                .bold()
            
            // User input fields
            TextField("Enter 1st number", text: $n1)
                .textFieldStyle(RoundedBorderTextFieldStyle())            
                .keyboardType(.decimalPad)

            TextField("Enter 2nd number", text: $n2)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.decimalPad)

            Divider()
            
            // Display results
            VStack(alignment: .leading, spacing: 8) {
                Text("Addition: \(num1 + num2, specifier: "%.2f")")
                Text("Subtraction: \(num1 - num2, specifier: "%.2f")")
                Text("Multiplication: \(num1 * num2, specifier: "%.2f")")
                if num2 != 0 {
                    Text("Division: \(num1 / num2, specifier: "%.2f")")
                } else {
                    Text("Division: ❌ Cannot divide by zero")
                        .foregroundColor(.red)
                }
            }
            .font(.headline)
            .padding()
            
            Spacer()
        }
        .padding()
    }
}
