//
//  Shape.swift
//  final
//
//  Created by Alec Smith on 4/23/19.
//  Copyright © 2019 Alec Smith. All rights reserved.
//

import SpriteKit

let NumOrientations: UInt32 = 4

enum Orientation: Int, CustomStringConvertible {
    case Zero = 0, Ninety, OneEighty, TwoSeventy
    
    var description: String {
        switch self {
        case .Zero:
            return "0"
        case .Ninety:
            return "90"
        case .OneEighty:
            return "180"
        case .TwoSeventy:
            return "270"
        }
    }
    
    // returns the next orientation  while rotating
    static func rotate(orientation:Orientation, clockwise: Bool) -> Orientation {
        var rotated = orientation.rawValue + (clockwise ? 1 : -1)
        if rotated > Orientation.TwoSeventy.rawValue {
            rotated = Orientation.Zero.rawValue
        } else if rotated < 0 {
            rotated = Orientation.TwoSeventy.rawValue
        }
        
        return Orientation(rawValue:rotated)!
    }
}

// total number of shapes possible
let NumShapeTypes: UInt32 = 7

// shape indexes
let FirstBlockIndex: Int = 0
let SecondBlockIndex: Int = 1
let ThirdBlockIndex: Int = 2
let FourthBlockIndex: Int = 3

class Shape: Hashable, CustomStringConvertible {
    
    // set block color
    let color:BlockColor
    // give the blocks a shape
    var blocks = Array<Block>()
    // give blocks an orientation
    var orientation: Orientation
    // give blocks an anchor point in column,row
    var column, row:Int
    
    
    // Required Overrides
    
    // this defines a dictionary for column and row
    
    var blockRowColumnPositions: [Orientation: Array<(columnDiff: Int, rowDiff: Int)>] {
        return [:]
    }
    
    // dictionary for the blocks array
    
    var bottomBlocksForOrientations: [Orientation: Array<Block>] {
        return [:]
    }
    
    // returns the bottom blocks of the shape for use later on how it interacts with the walls
    
    var bottomBlocks:Array<Block> {
        guard let bottomBlocks = bottomBlocksForOrientations[orientation] else {
            return []
        }
        return bottomBlocks
    }
    
    // do the Hash things
    
    var hashValue:Int {
        return blocks.reduce(0) { $0.hashValue ^ $1.hashValue}
    }
    // CustomStringConvertible things
    var description: String {
        return "\(color) block facing \(orientation): \(blocks[FirstBlockIndex]), \(blocks[SecondBlockIndex]), \(blocks[ThirdBlockIndex]), \(blocks[FourthBlockIndex])"
    }
    
    init(column:Int, row:Int, color: BlockColor, orientation:Orientation) {
        self.color = color
        self.column = column
        self.row = row
        self.orientation = orientation
        
        initializeBlocks()
    }
    // used to generate a random color and shape
    convenience init(column:Int, row:Int) {
        self.init(column:column, row:row, color:BlockColor.random(), orientation:Orientation.random())
    }
    
    // declares the shape and orientation
    final func initializeBlocks() {
        guard let blockRowColumnTranslations = blockRowColumnPositions[orientation] else {
            return
        }
        // create blocks array  that returns a block object
        blocks = blockRowColumnTranslations.map { (diff) -> Block in
            return Block(column: column + diff.columnDiff, row: row + diff.rowDiff, color: color)
        }
    }
    
    final func rotateBlocks(orientation: Orientation) {
        guard let blockRowColumnTranslation: Array<(columnDiff: Int, rowDiff: Int)> = blockRowColumnPositions[orientation] else {
            return
        }
        // enumerate function to iterate through array
        for (idx, diff) in blockRowColumnTranslation.enumerated() {
            blocks[idx].column = column + diff.columnDiff
            blocks[idx].row = row + diff.rowDiff
        }
    }
    final func lowerShapeByOneRow() {
        shiftBy(columns: 0, rows:1)
    }
    
    // adjust each row and column by row and column
    final func shiftBy(columns: Int, rows: Int) {
        self.column += columns
        self.row += rows
        for block in blocks {
            block.column += columns
            block.row += rows
        }
    }
    
    // where does it move to
    final func moveTo(column: Int, row:Int) {
        self.column = column
        self.row = row
        rotateBlocks(orientation)
    }
    
    final class func random(startingColumn:Int, startingRow:Int) -> Shape {
        switch Int(arc4random_uniform(NumShapeTypes)) {
        // generate a random shape
        case 0:
            return SquareShape(column: startingColumn, row: startingRow)
        case 1:
            return LineShape(column: startingColumn, row: startingRow)
        case 2:
            return TShape(column: startingColumn, row: startingRow)
        case 3:
            return LShape(column: startingColumn, row: startingRow)
        case 4:
            return JShape(column: startingColumn, row: startingRow)
        case 5:
            return SShape(column: startingColumn, row: startingRow)
        default:
            return ZShape(column: startingColumn, row: startingRow)

        }
    }
}

func ==(lhs: Shape, rhs: Shape) -> Bool {
    return lsh.row == rsh.row && lhs.column == rhs.column
}
