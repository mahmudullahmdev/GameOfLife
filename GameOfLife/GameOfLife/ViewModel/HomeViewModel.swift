//
//  HomeViewModel.swift
//  GameOfLife
//
//  Created by Mahmudullah on 3/8/22.
//

import Foundation
class HomeViewModel : ObservableObject {
    @Published var cellList:[[CellModel]] = []
    
    func initCells(rows:Int) {
        var parentList:[[CellModel]] = []
        for _ in 0...12 {
            var childLists: [CellModel] = []
            for _ in 0...12 {
                childLists.append(CellModel.init())
            }
            parentList.append(childLists)
        }
        self.cellList = parentList
        
    }
    
    func placeInitialSeed(row: Int ,column: Int) {
        
    }
    
    func startGame() {
        var cellList = self.cellList
        for y in 0..<cellList.count - 1 {
            for x in 0..<cellList[y].count - 1 {
                
                let list = cellList[y]
                let isAlive =  list[x].isAlive
                
                let topy = y - 1
                let topx = x
                
                let lefty = y
                let leftx = x - 1
                
                let righty = y
                let rightx = x + 1
                
                let bottomy = y + 1
                let bottomx = x
                
                let diagTopRighty = y - 1
                let diagTopRightx = x + 1
                
                let diagTopLefty = y - 1
                let diagTopLeftx = x - 1
                
                let diagBottomLefty = y + 1
                let diagBottomLeftx = x - 1
                
                let diagBottomRighty = y + 1
                let diagBottomRightx = x + 1
                
                var aliveCount: Int = 0
                
                
                if  topy >= 0 && topx >= 0 {
                    if cellList[topy][topx].isAlive {
                        aliveCount += 1
                    }
                }
                
                if  bottomx >= 0 && bottomy >= 0 {
                    if cellList[bottomy][bottomx].isAlive {
                        aliveCount += 1
                    }
                }
                if lefty >= 0 && leftx >= 0  {
                    if cellList[lefty][leftx].isAlive {
                        aliveCount += 1
                    }
                }
                if rightx >= 0 && righty >= 0 {
                    if cellList[righty][rightx].isAlive {
                        aliveCount += 1
                    }
                }
                
                if  diagTopRighty >= 0 && diagTopRightx >= 0 {
                    if cellList[diagTopRighty][diagTopRightx].isAlive {
                        aliveCount += 1
                    }
                }
                
                if  diagTopLeftx >= 0 && diagTopLefty >= 0 {
                    if cellList[diagTopLefty][diagTopLeftx].isAlive {
                        aliveCount += 1
                    }
                }
                
                if diagBottomLeftx >= 0 && diagBottomLefty >= 0 {
                    if cellList[diagBottomLefty][diagBottomLeftx].isAlive {
                        aliveCount += 1
                    }
                }
                if  diagBottomRightx >= 0 && diagBottomRighty >= 0 {
                    if cellList[diagBottomRighty][diagBottomRightx].isAlive {
                        aliveCount += 1
                    }
                }
                
                
                if isAlive {
                    if aliveCount < 2 {
                        cellList[y][x].isAlive = false
                        
                    } else if aliveCount >= 2 && aliveCount <= 3 {
                        cellList[y][x].isAlive = true
                    } else if aliveCount > 3 {
                        cellList[y][x].isAlive = false
                        
                    }
                    
                } else {
                    if aliveCount == 3 {
                        cellList[x][y].isAlive = true
                       
                    }
                }

            }
            self.cellList = cellList
        }
   
        
    }
    
}
