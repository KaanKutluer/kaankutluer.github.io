import SwiftUI
    
struct ContentView: View {
        
        let flavors = ["Vanilla", "Chocolate", "Strawberry", "Mint", "Caramel"]
        let scoopSizes = [40.0, 55.0, 50.0, 70.0, 45.0] // controls circle size
        
        var body: some View {
            VStack(spacing: 20) {
                
                Text("🍦 Ice Cream Visualizer")
                    .font(.largeTitle)
                    .bold()
                
                // Show scoops visually
                ScrollView(.horizontal) {
                    HStack(spacing: 30) {
                        ForEach(0..<flavors.count, id: \.self) { i in
                            VStack {
                                Circle()
                                    .fill(color(for: flavors[i]))
                                    .frame(width: scoopSizes[i], height: scoopSizes[i])
                                    .shadow(radius: 4)
                                
                                Text(flavors[i])
                                    .font(.headline)
                            }
                        }
                    }
                    .padding()
                }
                
                Divider().padding()
                
                // Show raw lists
                VStack(alignment: .leading, spacing: 12) {
                    Text("📋 Flavor List:")
                        .font(.title2).bold()
                    ForEach(flavors, id: \.self) { item in
                        Text("• \(item)")
                    }
                    
                    Text("🔢 Size Values:")
                        .font(.title2).bold()
                    ForEach(scoopSizes.indices, id: \.self) { i in
                        Text("\(flavors[i]): \(Int(scoopSizes[i])) pts")
                    }
                }
                .padding()
            }
        }
        
        // Assign fun colors
        func color(for flavor: String) -> Color {
            switch flavor {
            case "Vanilla": return .yellow.opacity(0.8)
            case "Chocolate": return .brown
            case "Strawberry": return .pink
            case "Mint": return .green.opacity(0.7)
            case "Caramel": return .orange.opacity(0.8)
            default: return .gray
            }
        }
    }
    
    struct IceCreamView_Previews: PreviewProvider {

