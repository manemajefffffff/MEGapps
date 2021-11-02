//
//  DoubleClassModel.swift
//  MEGapps
//
//  Created by Aldo Febrian on 29/10/21.
//

import Foundation

struct DoubleClassModel {
    var leftVal: String?
    var rightVal: String?
    
    init(leftVal: String, rightVal: String) {
        self.leftVal = leftVal
        self.rightVal = rightVal
    }
    
    static func initDummyData() -> [DoubleClassModel] {
        return [
            DoubleClassModel(leftVal: "Left 1", rightVal: "Right 1"),
            DoubleClassModel(leftVal: "Left 2", rightVal: "Right 2"),
            DoubleClassModel(leftVal: "Left 3", rightVal: "Right 3"),
            DoubleClassModel(leftVal: "Left 4", rightVal: "Right 4")
        ]
    }
}
