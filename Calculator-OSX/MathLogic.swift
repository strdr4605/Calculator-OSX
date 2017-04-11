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
    
    func getExpressionValue(expression: String) -> String {
        mathExpression = covertExpressionElmentsToDouble(initialExpression: expression)
        let stringWithMathematicalOperation: String = mathExpression
        let exp: NSExpression = NSExpression(format: stringWithMathematicalOperation)
        let result: Double = exp.expressionValue(with: nil, context: nil) as! Double
        mathExpression = ""
        print(result)
        return String(result).replacingOccurrences(of: ".0", with: "")
    }
    
    func isNumber(expression: String) -> Bool {
        if(Double(expression) != nil) {
            return true
        }
        else {
            return false
        }
    }
    
    func convertToDouble(number: String) -> String {
        let converted: Double = Double(number)!
        return String(converted)
    }
    
    func covertExpressionElmentsToDouble(initialExpression: String) -> String {
        var convertedToDouble: String = ""
        var number: String = ""
        for index in initialExpression.characters.indices {
            if(isNumber(expression: String(initialExpression[index])) || String(initialExpression[index]) == ".") {
                number += String(initialExpression[index])
            }
            else {
                if(number != "") {
                    convertedToDouble += convertToDouble(number: number)
                }
                convertedToDouble += String(initialExpression[index])
                number = ""
//                print(convertedToDouble)
            }
        }
        if(number != "") {
            convertedToDouble += convertToDouble(number: number)
            number = ""
        }
        return convertedToDouble
    }
    
    func resetMathExpression() {
        mathExpression = ""
    }
    
    func getMathExpression() -> String {
        return mathExpression.replacingOccurrences(of: ".0", with: "")
    }
    
    func getTrigonometricValue(function: String) -> String {
        var value: String? = nil
        var functionExpression: NSExpression? = nil
        switch function {
        case "sin":
            functionExpression = NSExpression(format:"FUNCTION(90.0 * " + String(Double.pi) + " / 180, 'getSin')")
            break
        default:
            value = "Not a trigonometric function"
            break
        }
        if(functionExpression != nil) {
            let functionValue: Double = functionExpression!.expressionValue(with: nil, context: nil) as! Double
            print(functionValue)
            value = String(functionValue)
        }
        return value!
    }
}

public extension NSNumber {
    func getSin() -> NSNumber {
        return NSNumber(value: sin(self.doubleValue))//sqrt(self.doubleValue)
    }
}
