//
//  Array2D.swift
//  final
//
//  Created by Alec Smith on 4/22/19.
//  Copyright © 2019 Alec Smith. All rights reserved.
//

//define class <T> allows array to store any type of data
class Array2D<T> {
    let columns: Int
    let rows: Int
    
    //declare array with type <T>
    var array: Array<T?>
    
    init(columns: Int, rows: Int) {
        
        self.columns = columns
        
        self.rows = rows
        
        //initialize array size of rows by columns
        array = Array<T?>(repeating: nil, count:rows * columns)
    }
    //subscript to confirm array 
    subscript(column: Int, row: Int) -> T? {
        get {
            return array[(row * columns) + column]
        }
        
        set(newValue) {
            array[(row * columns) + column] = newValue
        }
    }
}
