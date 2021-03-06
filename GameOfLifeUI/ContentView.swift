//
//  ContentView.swift
//  GameOfLifeUI
//
//  Created by Heiko Goes on 07.03.20.
//  Copyright © 2020 Heiko Goes. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var isStarted = false
    
    @ObservedObject var store = Store(
        liveCells: glider,
        size: Size(height: 20, width: 20))
    
    let fps = 10
    
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(store.rows, id: \.self){ row in
                Text(row)
                    .font(.system(.body, design: .monospaced))
            }
            Spacer()
            Button(self.isStarted ? "Stop" : "Start"){
                self.isStarted.toggle()
                self.gameLoop()
            }
        }
    }
    
    func gameLoop() {
        if isStarted {
            store.nextGeneration()
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1000/fps), execute: gameLoop)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
