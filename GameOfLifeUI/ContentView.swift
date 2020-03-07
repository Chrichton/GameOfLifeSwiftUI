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
        @ObservedObject var store: Store = Store(cells: [
            ["X", " ", "X"],
            [" ", "X", " "]
        ])
        
        func simulateGame() {
            if isStarted {
                store.cells = [[]]
                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(300), execute: simulateGame)
            }
        }

        var body: some View {
            VStack {
                HStack {
                    Text("X")
                    Text(" ")
                    Text("X")
                }
                HStack {
                    Text(" ")
                    Text("X")
                    Text(" ")
                }
                
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
