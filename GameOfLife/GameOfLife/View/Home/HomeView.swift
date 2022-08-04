//
//  HomeView.swift
//  GameOfLife
//
//  Created by Mahmudullah on 3/8/22.
//

import SwiftUI

struct HomeView: View {
    var items: [GridItem] = []
    @ObservedObject  var viewModel = HomeViewModel()
    @State var seedPlaced: Bool = false
    @State var generation: Int = 1
    var body: some View {
        GeometryReader {proxy in
            ScrollView {
                VStack {
                    // Start of Top Portion of the screen
                    HStack(alignment: .center) {
                        Text( self.generation > 1 ?  "Generation: \(self.generation)" : "Tap in the cells and place your first generation" )
                            .foregroundColor(Color.accentColor)
                        
                        // Start and generate next generations by tapping this button.
                        // Only start game when seed is placed to the chart..
                        Button(action: {
                                self.generation += 1
                                self.viewModel.startGame()
                        }){
                            Text("Next")
                                .padding(.all, 6)
                                .foregroundColor(.white)
                        }
                        .background(Color(UIColor.blue))
                        .cornerRadius(5)
                    }
                    .padding(.top, 6)  // End of Top Portion of the screen

                    ScrollView(.vertical, showsIndicators: false) {
                        // This stack generates the coloumns
                        LazyVStack(spacing: 0) {
                            ForEach(0..<viewModel.cellList.count, id: \.self) { y in
                                
                                // This stack generates the rows
                                LazyHStack(spacing: 0) {
                                    ForEach(0..<viewModel.cellList[y].count, id: \.self) { x in
                                        Button(action: {
                                            viewModel.cellList[y][x].isAlive.toggle()
                                            self.seedPlaced.toggle()
                                        }){
                                            Rectangle()
                                                .foregroundColor(self.viewModel.cellList[y][x].isAlive ? .black : .white )
                                                .frame(width: proxy.size.width/30, height:  proxy.size.width/30)
                                                .border(.gray, width: 1)
                                        }
                                        
                                    }
                                }
                                
                            }
                        }
                        .padding(.leading, 6)
                        .padding(.trailing, 6)
                        .padding(.bottom, 6)
                    }
  
                }
            }
            .onAppear{
                viewModel.initCells()
            }
   
        }
        
    }
}
