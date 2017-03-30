//
//  MathLogic.swift
//  Calculator-OSX
//
//  Created by Hackintosh on 3/29/17.
//  Copyright © 2017 Dragos Strainu. All rights reserved.
//

import Foundation

class MathLogic {
    var mathExpression : String = ""
    
    func evalExpression(mathExpression: String) {
        let stringWithMathematicalOperation: String = mathExpression
        let exp: NSExpression = NSExpression(format: stringWithMathematicalOperation)
        let result: Double = exp.expressionValue(with: nil, context: nil) as! Double
        print(result)
    }
}
