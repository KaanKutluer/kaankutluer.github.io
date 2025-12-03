import SwiftUI   // Bring in SwiftUI tools

struct ContentView: View {
                
        let sharedMinutes = "45"   // All cities use :45
        
        // City names + hour values
        let cities = [
            ("Tokyo 🇯🇵", 9),
            ("Paris 🇫🇷", 3),
            ("Istanbul 🇹🇷", 4),
            ("New York 🇺🇸", 10),
            ("Sydney 🇦🇺", 7),
            ("Rio de Janeiro 🇧🇷", 6),
            ("Cairo 🇪🇬", 2),
            ("Toronto 🇨🇦", 11)
        ]
        
        var body: some View {
            VStack(spacing: 15) {   // Stack vertically
                
                Text("🌍 World Clock")
                    .font(.largeTitle)
                    .bold()
                
                ForEach(cities, id: \.0) { city, hour in  // Loop through cities
                    HStack {
                        Text(city)                       // Show city + flag
                            .font(.title3)
                        
                        Spacer()
                        
                        Text("\(hour):\(sharedMinutes)") // Same minutes, diff hours
                            .font(.title3)
                            .monospacedDigit()
                    }
                    .padding(.horizontal)
                }
            }
            .padding()
        }
    }


