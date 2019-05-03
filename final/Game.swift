//
//  Game.swift
//  final
//
//  Created by Alec Smith on 5/3/19.
//  Copyright © 2019 Alec Smith. All rights reserved.
//

// Total number of rows and the starting location of the block
let NumColumns = 10
let NumRows = 20

let StartingColumn = 4
let StartingRow = 0

let PreviewColumn = 12
let PreviewRow = 1


class Game {
    var blockArray:Array2D<Block>
    var nextShape:Shape?
    var fallingShape:Shape?
    
    init() {
        fallingShape = nil
        nextShape = nil
        blockArray = Array2D<Block> (columns: NumColumns, rows: NumRows)
    }
    
    func beginGame() {
        if (nextShape == nil) {
            nextShape = Shape.random(startingColumn: PreviewColumn, startingRow: PreviewRow)
        }
    }
    
    // create shape and a preview shape
    func newShape() -> (fallingShape:Shape?, nextShape:Shape?) {
        fallingShape = nextShape
        nextShape = Shape.random(startingColumn: StartingColumn, startingRow: StartingRow)
        
        return(fallingShape, nextShape)
    }
}
