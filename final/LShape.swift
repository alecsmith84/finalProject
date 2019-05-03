//
//  LShape.swift
//  final
//
//  Created by Alec Smith on 4/29/19.
//  Copyright © 2019 Alec Smith. All rights reserved.
//

class LShape: Shape {
    override var blockRowColumnPositions: [Orientation : Array<(columnDiff: Int, rowDiff: Int)>] {
        return [
            Orientation.Zero: [(0,0),(0,1),(0,2),(1,2)],
            Orientation.Ninety: [(1,1),(0,1),(-1,1),(-1,2)],
            Orientation.OneEighty: [(0,2),(0,1),(0,0),(-1,0)],
            Orientation.TwoSeventy: [(-1,1),(0,1),(1,1),(1,0)]
        ]
    }
    
    override var bottomBlocksForOrientations: [Orientation : Array<Block>] {
        return [
            Orientation.Zero: [blocks[ThirdBlockIndex],blocks[FourthBlockIndex]],
            Orientation.Ninety: [blocks[FirstBlockIndex],blocks[SecondBlockIndex],blocks[FourthBlockIndex]],
            Orientation.OneEighty: [blocks[FirstBlockIndex],blocks[FourthBlockIndex]],
            Orientation.TwoSeventy: [blocks[FirstBlockIndex],blocks[SecondBlockIndex],blocks[ThirdBlockIndex]]
        ]
    }
}
