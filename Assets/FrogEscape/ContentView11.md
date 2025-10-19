//Kaan Ege Kutluer
import SwiftUI

// MARK: - Maze layout
// 0 = empty, 1 = wall/obstacle
let maze = [
    [0, 1, 0, 0, 0],
    [0, 1, 0, 1, 0],
    [0, 0, 0, 1, 0],
    [1, 1, 0, 1, 0],
    [0, 0, 0, 0, 0]
]

let startPosition = (x: 0, y: 4)
let goalPosition = (x: 4, y: 0)

// MARK: - ContentView
struct ContentView: View {
    // Frog position
    @State private var frogPosition = startPosition
    
    // Moving obstacles (a copy of the maze that shifts)
    @State private var movingMaze = maze
    
    // Timer
    @State private var timeRemaining = 20
    @State private var running = false
    
    // Messages
    @State private var message = ""
    @State private var level = 1
    
    // Timers
    let tick = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    let moveTick = Timer.publish(every: 0.8, on: .main, in: .common).autoconnect() // move obstacles
    
    let totalTime = 20
    
    var body: some View {
        VStack(spacing: 20) {
            
            // Clock-style timer
            ZStack {
                Circle()
                    .stroke(lineWidth: 6)
                    .foregroundColor(.blue.opacity(0.3))
                    .frame(width: 120, height: 120)
                
                Rectangle()
                    .fill(Color.red)
                    .frame(width: 3, height: 50)
                    .offset(y: -25)
                    .rotationEffect(.degrees(handAngle()))
                    .animation(.linear(duration: 0.2), value: timeRemaining)
                
                Text("\(timeRemaining)s")
                    .foregroundColor(.white)
                    .bold()
            }
            
            // Level info
            Text("Level \(level)")
                .foregroundColor(.yellow)
                .font(.headline)
            
            // Maze grid
            ForEach(0..<movingMaze.count, id: \.self) { row in
                HStack(spacing: 10) {
                    ForEach(0..<movingMaze[row].count, id: \.self) { col in
                        ZStack {
                            Rectangle()
                                .fill(movingMaze[row][col] == 1 ? Color.red.opacity(0.8) : Color.white)
                                .frame(width: 50, height: 50)
                                .border(Color.gray)
                            
                            // Frog
                            if frogPosition.x == col && frogPosition.y == row {
                                Text("🐸")
                                    .font(.system(size: 30))
                            }
                            
                            // Start
                            if startPosition.x == col && startPosition.y == row {
                                Text("🚩").font(.system(size: 25))
                            }
                            
                            // Goal
                            if goalPosition.x == col && goalPosition.y == row {
                                Text("🏁").font(.system(size: 25))
                            }
                        }
                    }
                }
            }
            
            // Movement Controls
            HStack(spacing: 20) {
                Button("⬅️") { moveFrog(dx: -1, dy: 0) }
                VStack(spacing: 20) {
                    Button("⬆️") { moveFrog(dx: 0, dy: -1) }
                    Button("⬇️") { moveFrog(dx: 0, dy: 1) }
                }
                Button("➡️") { moveFrog(dx: 1, dy: 0) }
            }
            
            // Message
            Text(message)
                .font(.title3)
                .foregroundColor(.cyan)
                .padding(.top, 10)
            
            // Start/Reset Button
            Button(running ? "Restart" : "Start") {
                startGame()
            }
            .padding()
            .background(Color.blue.opacity(0.7))
            .cornerRadius(10)
        }
        .padding()
        .background(Color.black.opacity(0.85))
        .onReceive(tick) { _ in
            guard running else { return }
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                message = "Time’s up! Overflow!"
                running = false
            }
        }
        // Move obstacles every few ticks
        .onReceive(moveTick) { _ in
            guard running else { return }
            moveObstacles()
        }
    }
    
    // MARK: - Movement
    func moveFrog(dx: Int, dy: Int) {
        guard running else { return }
        let newX = frogPosition.x + dx
        let newY = frogPosition.y + dy
        
        if newY >= 0, newY < movingMaze.count,
           newX >= 0, newX < movingMaze[0].count {
            
            if movingMaze[newY][newX] == 1 {
                message = "Overflow! You hit an obstacle!"
                running = false
            } else {
                frogPosition = (x: newX, y: newY)
                message = ""
                
                if frogPosition == goalPosition {
                    message = "Level Up!"
                    running = false
                    nextLevel()
                }
            }
        }
    }
    
    // MARK: - Timer & Levels
    func startGame() {
        frogPosition = startPosition
        movingMaze = maze
        timeRemaining = totalTime
        message = ""
        running = true
    }
    
    func nextLevel() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            level += 1
            timeRemaining = max(totalTime - level * 2, 8)
            running = true
            startGame()
        }
    }
    
    // MARK: - Moving Obstacles
    func moveObstacles() {
        // Shift one row horizontally (simulate moving obstacles)
        for row in 0..<movingMaze.count {
            if row % 2 == 1 { // only move every other row
                if Bool.random() {
                    // shift right
                    let last = movingMaze[row].removeLast()
                    movingMaze[row].insert(last, at: 0)
                } else {
                    // shift left
                    let first = movingMaze[row].removeFirst()
                    movingMaze[row].append(first)
                }
            }
        }
    }
    
    // MARK: - Clock hand rotation
    func handAngle() -> Double {
        let fraction = Double(timeRemaining) / Double(totalTime)
        return (1 - fraction) * 360 - 90
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
