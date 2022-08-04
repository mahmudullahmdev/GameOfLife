//
//  HomeViewModel.swift
//  GameOfLife
//
//  Created by Mahmudullah on 3/8/22.
//

import Foundation
class HomeViewModel : ObservableObject {
    @Published var cellList:[[CellModel]] = []
    
    // Generate Columns and Rows for 12x12 matrix the playground
    func initCells() {
        var listOfColoumn:[[CellModel]] = []
        for _ in 0...11 {
            var listOfRows: [CellModel] = []
            for _ in 0...11 {
                listOfRows.append(CellModel.init())
            }
            listOfColoumn.append(listOfRows)
        }
        self.cellList = listOfColoumn
        
    }
    
    // This method starts the game and applies all the rules of GameOfLife
    func startGame() {
        var cellList = self.cellList
        for y in 0..<cellList.count {
            for x in 0..<cellList[y].count {
                
                // Take the positions of 8 cells around the target cell vertically
                // horizontally and diagonally
                let isAlive =  cellList[y][x].isAlive
                
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
                
                
                // Checkf if a cell is alive or not and increase the alive count for all cells of row
                // Don't take any negative and > cellList count indexes.
                var aliveCount: Int = 0
                if  topy >= 0 && topx >= 0 && topy < cellList.count && topx < cellList.count {
                    if cellList[topy][topx].isAlive {
                        aliveCount += 1
                    }
                }
                
                if  bottomx >= 0 && bottomy >= 0 && bottomx < cellList.count && bottomy < cellList.count {
                    if cellList[bottomy][bottomx].isAlive {
                        aliveCount += 1
                    }
                }
                if lefty >= 0 && leftx >= 0 && lefty < cellList.count && leftx < cellList.count {
                    if cellList[lefty][leftx].isAlive {
                        aliveCount += 1
                    }
                }
                if rightx >= 0 && righty >= 0 && rightx < cellList.count && righty < cellList.count {
                    if cellList[righty][rightx].isAlive {
                        aliveCount += 1
                    }
                }
                
                if  diagTopRighty >= 0 && diagTopRightx >= 0 && diagTopRightx < cellList.count && diagTopRightx < cellList.count {
                    if cellList[diagTopRighty][diagTopRightx].isAlive {
                        aliveCount += 1
                    }
                }
                
                if  diagTopLeftx >= 0 && diagTopLefty >= 0 && diagTopLeftx < cellList.count && diagTopLefty < cellList.count {
                    if cellList[diagTopLefty][diagTopLeftx].isAlive {
                        aliveCount += 1
                    }
                }
                
                if diagBottomLeftx >= 0 && diagBottomLefty >= 0 && diagBottomLeftx < cellList.count && diagBottomLefty < cellList.count {
                    if cellList[diagBottomLefty][diagBottomLeftx].isAlive {
                        aliveCount += 1
                    }
                }
                if  diagBottomRightx >= 0 && diagBottomRighty >= 0 && diagBottomRightx < cellList.count && diagBottomRighty < cellList.count {
                    if cellList[diagBottomRighty][diagBottomRightx].isAlive {
                        aliveCount += 1
                    }
                }
                
                // We have now the total alive count of cell around neighbours
                // Apply the rules now
                if isAlive {
                    // Any live cell with fewer then 2 live neighbors die, as if by underpopulation.
                    // Any live cell with two or three live neighbors lives on the next generation.
                    // Any live cell with more than three live neighbors dies, as if by overpopulation.
                    if aliveCount < 2 {
                        cellList[y][x].isAlive = false
                    } else if aliveCount >= 2 && aliveCount <= 3 {
                        cellList[y][x].isAlive = true
                    } else if aliveCount > 3 {
                        cellList[y][x].isAlive = false
                    }
                    
                } else {
                    // Any dead cell with exactly three live neighbors becomes a live cell, as if by reproduction.
                    if aliveCount == 3 {
                        cellList[y][x].isAlive = true
                        
                    }
                }
                
            }
            self.cellList = cellList
            
        }
        
        
    }
    
}
