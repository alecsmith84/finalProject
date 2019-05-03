//
//  TShape.swift
//  final
//
//  Created by Alec Smith on 4/29/19.
//  Copyright © 2019 Alec Smith. All rights reserved.
//

class TShape:Shape {
    
    
    override var blockRowColumnPositions: [Orientation : Array<(columnDiff: Int, rowDiff: Int)>] {
        return [
        Orientation.Zero: [(1,0),(0,1),(1,1),(2,1)],
        Orientation.Ninety: [(2,1),(1,0),(1,1),(1,2)],
        Orientation.OneEighty: [(1,2),(0,1),(1,1),(2,1)],
        Orientation.TwoSeventy: [(0,1),(1,0),(1,1),(1,2)]
        ]
    }
    
    override var bottomBlocksForOrientations: [Orientation : Array<Block>] {
        return [
            Orientation.Zero: [blocks[SecondBlockIndex],blocks[ThirdBlockIndex],blocks[FourthBlockIndex]],
            Orientation.Ninety: [blocks[FirstBlockIndex],blocks[FourthBlockIndex]],
            Orientation.OneEighty: [blocks[FirstBlockIndex],blocks[SecondBlockIndex],blocks[FourthBlockIndex]],
            Orientation.TwoSeventy: [blocks[FirstBlockIndex],blocks[FourthBlockIndex]]

        ]
    }
}

