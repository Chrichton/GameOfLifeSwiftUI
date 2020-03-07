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
        liveCells: Set([Point(x: 5,y: 4), Point(x: 5,y: 5), Point(x: 5,y: 6)]),
        width: 20, height: 20)
        
        func simulateGame() {
            if isStarted {
                store.nextGeneration()
                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(300), execute: simulateGame)
            }
        }

        var body: some View {
            VStack {
                ForEach(store.cells, id: \.self){ row in
                    HStack {
                        ForEach(row, id: \.self) { cell in
                            Text(cell)
                        }
                    }
                }
                Spacer()
                Button("Start/Stop"){
                    self.isStarted.toggle()
                    self.simulateGame()
                }
            }
        }
    }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
