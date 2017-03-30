//
//  ViewController.swift
//  Calculator-OSX
//
//  Created by Dragos Strainu on 29.03.2017.
//  Copyright © 2017 Dragos Strainu. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    @IBOutlet weak var stack: NSTextField!
    @IBOutlet weak var lastNumber: NSTextField!
    
    @IBOutlet weak var equal: NSButton!
    let logic: MathLogic = MathLogic()

    
    
    @IBAction func numbers(_ sender: NSButton) {
        lastNumber.stringValue = lastNumber.stringValue + String(sender.tag - 1);
    }
    
    
    @IBAction func operation(_ sender: NSButton) {
//        tags
//        14 Division
//        15 Multipliction
//        16 Minus
//        17 Plus
        switch sender.tag {
        case 14:
            stack.stringValue = stack.stringValue + lastNumber.stringValue + "/";
            break;
        case 15:
            stack.stringValue = stack.stringValue + lastNumber.stringValue + "*";
            break;
        case 16:
            stack.stringValue = stack.stringValue + lastNumber.stringValue + "-";
            break;
        case 17:
            stack.stringValue = stack.stringValue + lastNumber.stringValue + "+";
            break;
        default:
            break;
        }
    }
    
    @IBAction func equalAction(_ sender: Any) {
        stack.stringValue = stack.stringValue + lastNumber.stringValue
        print(stack.stringValue)
        logic.evalExpression(mathExpression: stack.stringValue)
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

