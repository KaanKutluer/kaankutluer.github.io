import SwiftUI
//This right here is Apple's framework which is the key supporting sturcture for building UIs in macOS and etc devices. Without this, this and all future projects wouldn't happen

struct ContentView: View {
    var body: some View {
        ZStack{
            //ZStack allows the x's and o's to stay on top of the rectangle since ZStack overlays view on the top of one another, different stacks have different purposes like VStack (Vertical Stack) and HStack (Horizontal Stack)
            Rectangle()
            //shape
                .fill(Color.red)
            //color
                .frame(width:120, height:120)
            //size
                .offset(x:150)
            //the location of the shape on the screen to the left (Via using the y-axis and the x-axis)
            Text("X")
            //the "X"
                .foregroundStyle(.white)
            //color of the shape
                .font(.largeTitle)
            //size of the "X"
                .bold()
            //bold to stand out even more
                .offset(x:150)
            
            Rectangle()
                .fill(Color.blue)
                .frame(width:120, height:120)
                .offset(x:150,y:150)
            Text("O")
                .foregroundStyle(.white)
                .font(.largeTitle)
                .bold()
                .offset(x:150,y:150)
            
            Rectangle()
                .fill(Color.yellow)
                .frame(width:120, height:120)
                .offset()
            Text("O")
                .foregroundStyle(.white)
                .font(.largeTitle)
                .bold()
                .offset()
            Rectangle()
                .fill(Color.red)
                .frame(width:120, height:120)
                .offset(y:150)
            Text("X")
                .foregroundStyle(.white)
                .font(.largeTitle)
                .bold()
                .offset(y:150)
            Rectangle()
                .fill(Color.red)
                .frame(width:120, height:120)
                .offset(x:-150)
            Text("X")
                .foregroundStyle(.white)
                .font(.largeTitle)
                .bold()
                .offset(x:-150)
            
            Rectangle()
                .fill(Color.blue)
                .frame(width:120, height:120)
                .offset(x:-150,y:150)
            Text("O")
                .foregroundStyle(.white)
                .font(.largeTitle)
                .bold()
                .offset(x:-150,y:150)
            Rectangle()
                .fill(Color.red)
                .frame(width:120, height:120)
                .offset(y:-150)
            Text("X")
                .foregroundStyle(.white)
                .font(.largeTitle)
                .bold()
                .offset(y:-150)
            Rectangle()
                .fill(Color.blue)
                .frame(width:120, height:120)
                .offset(x:150, y:-150)
            Text("O")
                .foregroundStyle(.white)
                .font(.largeTitle)
                .bold()
                .offset(x:150,y:-150)
            
            Rectangle()
                .fill(Color.blue)      .frame(width:120, height:120)
                .offset(x:-150,y:-150)
            Text("O")
                .foregroundStyle(.white)
                .font(.largeTitle)
                .bold()
                .offset(x:-150,y:-150)
        }
    }
}
