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
    
    func appendToExpression(symbol: String) {
        if(isNumber(expression: symbol)) {
            let number: Double = Double(symbol)!
            mathExpression += String(number)
        }
        else {
            mathExpression += symbol
        }
    }
    
    func getExpressionValue() -> String {
        let stringWithMathematicalOperation: String = mathExpression
        let exp: NSExpression = NSExpression(format: stringWithMathematicalOperation)
        let result: Double = exp.expressionValue(with: nil, context: nil) as! Double
        mathExpression = ""
        print(result)
        return String(result)
    }
    
    func isNumber(expression: String) -> Bool {
        if(Double(expression) != nil) {
            return true
        }
        else {
            return false
        }
    }
    
    func resetMathExpression() {
        mathExpression = ""
    }
    
    func getMathExpression() -> String {
        return mathExpression.replacingOccurrences(of: ".0", with: "")
    }
}
