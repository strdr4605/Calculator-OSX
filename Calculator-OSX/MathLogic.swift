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
        mathExpression = changeToRightSymbols(expression: mathExpression)
        mathExpression = replaceTrigonometricFunctions(expression: mathExpression)
        let stringWithMathematicalOperation: String = mathExpression
        let exp: NSExpression = NSExpression(format: stringWithMathematicalOperation)
        let result: Double = exp.expressionValue(with: nil, context: nil) as! Double
        mathExpression = ""
        print(result)
        var stringResult: String = String(result)
        if(stringResult.range(of: "0.0") == nil) {
            stringResult = stringResult.replacingOccurrences(of: ".0", with: "")
        }
        return stringResult
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
    
    func changeToRightSymbols(expression: String) -> String {
        var changedExpression: String = expression
        let wrongSymbols: [String: String] = ["^": "**"]
        for (wrong,right) in wrongSymbols {
            changedExpression = expression.replacingOccurrences(of: wrong, with: right)
        }
        
        return changedExpression
    }
    
    func containsTrigonometricFunctions(expression: String) -> [String] {
        var trigonometricFunctions = [String]()
        if(expression.contains("sin")) {
            trigonometricFunctions.append("sin")
        }
        if(expression.contains("cos")) {
            trigonometricFunctions.append("cos")
        }
        if(expression.contains("tan")) {
            trigonometricFunctions.append("tan")
        }
        if(expression.contains("cotan")) {
            trigonometricFunctions.append("cotan")
        }
        
        return trigonometricFunctions
    }
    
    func getMathExpression() -> String {
        return mathExpression.replacingOccurrences(of: ".0", with: "")
    }
    
    func replaceTrigonometricFunctions(expression: String) -> String {
        var changedExpression = expression
        var trigonometricFunctions: [String] = containsTrigonometricFunctions(expression: expression)
        while(trigonometricFunctions.count != 0) {
            for function in trigonometricFunctions {
                let start = changedExpression.range(of: function + "(")
                var functionArgument: String = ""
                for index in changedExpression.characters.indices[(start?.upperBound)!..<expression.endIndex] {
                    if(String(changedExpression[index]) != ")") {
                        functionArgument += String(changedExpression[index])
                    }
                    else {
                        break
                    }
                }
                //print("Function Argument:",functionArgument)
                let replaceOf = function + "(" + functionArgument + ")"
                let replaceWith = getTrigonometricValue(function: function, x: functionArgument)
                changedExpression = changedExpression.replacingOccurrences(of: replaceOf, with: replaceWith)
                //print("Changed Argument",changedExpression)
            }
            trigonometricFunctions = containsTrigonometricFunctions(expression: changedExpression)
        }
        print("Changed Expression)",changedExpression)
        return changedExpression
    }
    
    func getTrigonometricValue(function: String, x: String) -> String {
        var value: String? = nil
        var functionExpression: NSExpression? = nil
        switch function {
        case "sin":
            functionExpression = NSExpression(format:"FUNCTION(" + x + ", 'getSin')")
            break
        case "cos":
            functionExpression = NSExpression(format:"FUNCTION(" + x + ", 'getCos')")
            break
        default:
            value = "Not a trigonometric function"
            break
        }
        if(functionExpression != nil) {
            var functionValue: Double = functionExpression!.expressionValue(with: nil, context: nil) as! Double
            print(function + "(" + x + ") = ",functionValue)
            if(functionValue < 0.0000000001 && functionValue > 0) {
                functionValue = 0.0
            }
            value = String(functionValue)
        }
        return value!
    }
}

public extension NSNumber {
    func getSin() -> NSNumber {
        return NSNumber(value: sin(self.doubleValue))//sqrt(self.doubleValue)
    }
    
    func getCos() -> NSNumber {
        return NSNumber(value: cos(self.doubleValue))//sqrt(self.doubleValue)
    }
}
