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
    var body: some View {
        GeometryReader {proxy in
            ScrollView {
                VStack {
                    HStack(alignment: .center) {
                        Button(action: {
                            self.viewModel.placeInitialSeed(row: Int(proxy.size.height + proxy.size.width/20), column: Int(proxy.size.width/24) )
                            self.seedPlaced = true
                            
                        }){
                            Text("Place Seed")
                                .padding(.all, 6)
                                .foregroundColor(.white)
                        }
                        .background(Color(UIColor.blue))
                        .cornerRadius(5)
                        
                        Button(action: {
                            if self.seedPlaced {
                                // start game
                                self.viewModel.startGame()
                            }
                        }){
                            Text("Start")
                                .padding(.all, 6)
                                .foregroundColor(.white)
                        }
                        .background(Color(UIColor.blue))
                        .cornerRadius(5)
                    }
                    .padding(.top, 6)
                    ScrollView(.vertical, showsIndicators: false) {
                        
                        LazyVStack(spacing: 0) {
                            ForEach(0..<viewModel.cellList.count, id: \.self) { y in
                                LazyHStack(spacing: 0) {
                                    ForEach(0..<viewModel.cellList[y].count, id: \.self) { x in
                                        Button(action: {
                                            viewModel.cellList[y][x].isAlive.toggle()
                                            print("x: \(x) y: \(y)")
                                            self.seedPlaced = true
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
                viewModel.initCells(rows: 144)
            }
            
            
            
            
        }
        
    }
}

//struct HomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView()
//            .previewInterfaceOrientation(.landscapeLeft)
//    }
//}
