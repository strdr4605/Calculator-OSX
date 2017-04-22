//
//  ScientificCalculator.swift
//  Calculator-OSX
//
//  Created by Dragos Strainu on 04.04.2017.
//  Copyright © 2017 Dragos Strainu. All rights reserved.
//

import Cocoa

class ScientificCalculator: NSViewController {
    
    
    @IBOutlet weak var stack: NSTextField!
    @IBOutlet weak var lastNumber: NSTextField!
    var clearLastNumber = false;
    var clearStack = false;
    var allowOperation = false;
    
    @IBOutlet weak var deleteButton: NSButton!
    
    let logic: MathLogic = MathLogic()
    
    
    @IBAction func numbers(_ sender: NSButton) {
        if (clearStack) {
            stack.stringValue = "";
            clearStack = !clearStack;
        }
        if (!clearLastNumber) {
            lastNumber.stringValue = lastNumber.stringValue + String(sender.tag - 1);
        } else {
            lastNumber.stringValue = String(sender.tag - 1);
            clearLastNumber = false;
        }
        allowOperation = true;
    }
    
    
    @IBAction func operation(_ sender: NSButton) {
        //        tags
        //        13 percent
        //        14 Division
        //        15 Multipliction
        //        16 Minus
        //        17 Plus
        //        24 Power
        //        21 )
        if (stack.stringValue.characters.last == ")" ) {
            switch sender.tag {
            case 14:
                stack.stringValue = stack.stringValue  + "/";
                clearLastNumber = true;
                break;
            case 15:
                stack.stringValue = stack.stringValue + "*";
                clearLastNumber = true;
                break;
            case 16:
                stack.stringValue = stack.stringValue + "-";
                clearLastNumber = true;
                break;
            case 17:
                stack.stringValue = stack.stringValue + "+";
                clearLastNumber = true;
                break;
            case 24:
                stack.stringValue = stack.stringValue + "^";
                clearLastNumber = true;
                break;
            default:
                break;
            }
        } else if (lastNumber.stringValue != "" && allowOperation) {
            switch sender.tag {
//            case 13:
//                lastNumber.stringValue = String(lastNumber.doubleValue / 100);
//                clearLastNumber = true;
//                break;
            case 14:
                stack.stringValue = stack.stringValue + lastNumber.stringValue + "/";
                clearLastNumber = true;
                break;
            case 15:
                stack.stringValue = stack.stringValue + lastNumber.stringValue + "*";
                clearLastNumber = true;
                break;
            case 16:
                stack.stringValue = stack.stringValue + lastNumber.stringValue + "-";
                clearLastNumber = true;
                break;
            case 17:
                stack.stringValue = stack.stringValue + lastNumber.stringValue + "+";
                clearLastNumber = true;
                break;
            case 24:
                stack.stringValue = stack.stringValue + lastNumber.stringValue + "^";
                clearLastNumber = true;
                break;
            default:
                break;
            }
//            allowOperation = sender.tag == 13 ? true : false;
        }
        if (lastNumber.stringValue != "" && sender.tag == 21) {
            stack.stringValue = stack.stringValue + lastNumber.stringValue + ")";
            clearLastNumber = true;
            allowOperation = true;
        }
    }
    
    
    @IBAction func equal(_ sender: NSButton) {
        if((stack.stringValue.range(of: "y=") != nil) || (stack.stringValue.range(of: "=y") != nil)) {
            let myVC = self.storyboard?.instantiateController(withIdentifier: "GraphController") as! GraphController
            myVC.function = stack.stringValue
            self.presentViewControllerAsModalWindow(myVC)
        }
        if (allowOperation) {
            if(stack.stringValue.characters.last != ")") {
                stack.stringValue = stack.stringValue + lastNumber.stringValue;
            }
            clearLastNumber = true;
            clearStack = true;
            lastNumber.stringValue = logic.getExpressionValue(expression: stack.stringValue)
            allowOperation = !allowOperation;
        }
    }
    
    
    @IBAction func deleteAll(_ sender: NSButton) {
        lastNumber.stringValue = "";
        stack.stringValue = "";
    }
    
    @IBAction func delete(_ sender: NSButton) {
        if (lastNumber.stringValue != "") {
            lastNumber.stringValue.remove(at: lastNumber.stringValue.index(before: lastNumber.stringValue.endIndex));
        } else if (stack.stringValue != "") {
            stack.stringValue.remove(at: stack.stringValue.index(before: stack.stringValue.endIndex));
        }
    }
    
    
    @IBAction func reverse(_ sender: NSButton) {
        if (lastNumber.stringValue != "") {
            if (lastNumber.stringValue[lastNumber.stringValue.startIndex] == "-" ) {
                lastNumber.stringValue = String(lastNumber.stringValue.characters.dropFirst());
            } else {
                lastNumber.stringValue = "-" + lastNumber.stringValue;
            }
        }
    }
    
    
    @IBAction func comma(_ sender: NSButton) {
        if(!(lastNumber.stringValue.range(of: ".") != nil)) {
            lastNumber.stringValue = lastNumber.stringValue + ".";
        }
    }
    
    
    @IBAction func parenthesis(_ sender: NSButton) {
        switch sender.tag {
        case 20:
            stack.stringValue = stack.stringValue + "(";
            break;
        default:
            break;
        }
    }
    
    
    @IBAction func advancedOperation(_ sender: NSButton) {
        switch sender.tag {
        case 22:
            if(lastNumber.stringValue == "" || clearLastNumber) {
                lastNumber.stringValue = String(M_E);
            }
            else {
                lastNumber.stringValue += String(M_E)
            }
            break;
        case 23:
            if(lastNumber.stringValue == "" || clearLastNumber) {
                lastNumber.stringValue = String(M_PI);
            }
            else {
                lastNumber.stringValue += String(M_PI);
            }
            break;
        case 25:
            lastNumber.stringValue = String(sqrt(lastNumber.doubleValue));
            break;
        case 26:
            if(lastNumber.stringValue != "") {
                lastNumber.stringValue = String(sin(lastNumber.doubleValue));
            }
            else {
                lastNumber.stringValue = "sin("
                clearLastNumber = false
                allowOperation = true
            }
            break;
        case 27:
            if(lastNumber.stringValue != "") {
                lastNumber.stringValue = String(cos(lastNumber.doubleValue));
            }
            else {
                lastNumber.stringValue = "cos("
                clearLastNumber = false
                allowOperation = true
            }
            break;
        case 28:
            lastNumber.stringValue = String(log(lastNumber.doubleValue));
            break;
        case 29:
            lastNumber.stringValue = String(log10(lastNumber.doubleValue));
            break;
        default:
            break;
        }
        if(clearStack) {
            stack.stringValue = ""
            clearStack = !clearStack
        }
    }
    
    func longTap(_ sender: NSGestureRecognizer){
        //print("Long tap")
        if sender.state == .ended {
            //print("UIGestureRecognizerStateEnded")
            //Do Whatever You want on End of Gesture
        }
        else if sender.state == .began {
            //print("UIGestureRecognizerStateBegan.")
            //Do Whatever You want on Began of Gesture
            lastNumber.stringValue = ""
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        //let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(longTap(_:)))
        let longPress = NSPressGestureRecognizer(target: self, action: #selector(longTap(_:)))
        deleteButton.addGestureRecognizer(longPress)
        // Do view setup here.
    }
    
}
