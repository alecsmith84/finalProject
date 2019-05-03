//
//  LineShape.swift
//  final
//
//  Created by Alec Smith on 4/29/19.
//  Copyright © 2019 Alec Smith. All rights reserved.
//

class LineShape: Shape {
    
    
    
    override var blockRowColumnPositions: [Orientation : Array<(columnDiff: Int, rowDiff: Int)>] {
        return [
            Orientation.Zero: [(0,0),(0,1),(0,2),(0,3)],
            Orientation.Ninety: [(-1,0),(0,0),(1,0),(2,0)],
            Orientation.OneEighty: [(0,0),(0,1),(0,2),(0,3)],
            Orientation.TwoSeventy: [(-1,0),(0,0),(1,0),(2,0)]
        ]
    }
    
    override var bottomBlocksForOrientations: [Orientation : Array<Block>] {
        return [
            Orientation.Zero: [blocks[FourthBlockIndex]],
            Orientation.Ninety: blocks,
            Orientation.OneEighty: [blocks[FourthBlockIndex]],
            Orientation.TwoSeventy: blocks
        ]
    }
}
