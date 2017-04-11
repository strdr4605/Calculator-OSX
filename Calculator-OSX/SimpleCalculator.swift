//
//  ViewController.swift
//  Calculator-OSX
//
//  Created by Dragos Strainu on 29.03.2017.
//  Copyright © 2017 Dragos Strainu. All rights reserved.
//

import Cocoa

class SimpleCalculator: NSViewController {
    
    @IBOutlet weak var stack: NSTextField!
    @IBOutlet weak var lastNumber: NSTextField!
    var clearLastNumber = false;
    var clearStack = false;
    var allowOperation = false;
    
    @IBOutlet weak var equal: NSButton!
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
        if (lastNumber.stringValue != "" && allowOperation) {
            switch sender.tag {
            case 13:
                lastNumber.stringValue = String(lastNumber.doubleValue / 100);
                clearLastNumber = true;
                break;
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
            default:
                break;
            }
            allowOperation = sender.tag == 13 ? true : false;
        }
    }
    
    
    @IBAction func equal(_ sender: NSButton) {
        if (allowOperation) {
            stack.stringValue = stack.stringValue + lastNumber.stringValue;
            clearLastNumber = true;
            clearStack = true;
            lastNumber.stringValue = logic.getExpressionValue(expression: stack.stringValue)
            allowOperation = !allowOperation;
        }
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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
}
