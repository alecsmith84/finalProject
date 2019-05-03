//
//  SquareShape.swift
//  final
//
//  Created by Alec Smith on 4/24/19.
//  Copyright © 2019 Alec Smith. All rights reserved.
//

class SquareShape:Shape {
    
    /*
// 9
    |0|1|
    |2|3|
 */
    
    //10
    
    override var blockRowColumnPositions: [Orientation : Array<(columnDiff: Int, rowDiff: Int)>] {
        return [Orientation.Zero: [(0,0),(1,0),(0,1),(1,1)],
                Orientation.OneEighty: [(0,0),(1,0),(0,1),(1,1)],
                Orientation.Ninety: [(0,0),(1,0),(0,1),(1,1)],
                Orientation.TwoSeventy: [(0,0),(1,0),(0,1),(1,1)]]
    }
    
    // 11
    override var bottomBlocksForOrientations: [Orientation : Array<Block>] {
        return [Orientation.Zero: [blocks[ThirdBlockIndex],blocks[FourthBlockIndex]],
                Orientation.OneEighty:[blocks[ThirdBlockIndex],blocks[FourthBlockIndex]],
                Orientation.Ninety:[blocks[ThirdBlockIndex],blocks[FourthBlockIndex]],
                Orientation.TwoSeventy:[blocks[ThirdBlockIndex],blocks[FourthBlockIndex]]]
    }

}
