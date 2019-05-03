//
//  Block.swift
//  final
//
//  Created by Alec Smith on 4/22/19.
//  Copyright © 2019 Alec Smith. All rights reserved.
//

import SpriteKit
// define number of colors availabile
let NumberOfColors: UInt32 = 6
enum BlockColor: Int, CustomStringConvertible {
   // list of colors
    case Blue = 0, Orange, Purple, Red, Teal, Yellow
    // allows the return of the correct color name for display
    var spriteName: String {
        switch self {
        case .Blue:
            return "blue"
        case .Orange:
            return "orange"
        case .Purple:
            return "purple"
        case .Red:
            return "red"
        case .Teal:
            return "teal"
        case .Yellow:
            return "yellow"
            
        }
    }
    // this is required with CustomStringConvertible
    var description: String {
        return self.spriteName
    }
    // creates a random block color
    static func random() -> BlockColor {
        return BlockColor(rawValue: Int(arc4random_uniform(NumberOfColors)))!
    }
}
// declares block as a class
class Block: Hashable, CustomStringConvertible {
    
    //MARK: Constants
    
    // define color so that it doesn't have a seizure
    let color: BlockColor
    
    
    
    //MARK: Properties
    
    // define column and row for the board and sprite to display block
    var column: Int
    var row: Int
    var sprite: SKSpriteNode?
    
    // get the block sprite file name so you dont have to say block.color.spriteName
    var spriteName: String {
        return color.spriteName
    }
    // ensures that each block is a unique integer
    var hashValue: Int {
        return self.column ^ self.row
    }
    // required for CustomStringConvertable
    // returns something like "blue: [7,9]"
    var description: String {
        return "\(color): [\(column), \(row)]"
    }
    
    init(column:Int, row:Int, color:BlockColor) {
        self.column = column
        self.row = row
        self.color = color
    }
}
// comparing block with another and returns true if blocks are in the same location and the same color
func ==(lhs: Block, rhs: Block) -> Bool {
    return lhs.column == rhs.column && lhs.row == rhs.row && lhs.color.rawValue == rhs.color.rawValue
}


