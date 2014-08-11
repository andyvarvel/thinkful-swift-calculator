//
//  ViewController.swift
//  Calculator
//
//  Created by Andy Varvel on 6/08/2014.
//  Copyright (c) 2014 Andy Varvel. All rights reserved.
//

import UIKit

enum OperatorType {
    case Addition
    case Subtraction
    case Division
    case Multiplication
    case None
    func name() -> String {
        switch self {
        case .Addition:
            return "Addition"
        case .Subtraction:
            return "Subtraction"
        case .Division:
            return "Division"
        case .Multiplication:
            return "Multiplication"
        case .None:
            return "None"
        }
        
    }
    static func fromString(input:String) -> OperatorType {
        switch input {
            case "+":
                return OperatorType.Addition
            case "-":
                return OperatorType.Subtraction
            case "x":
                return OperatorType.Multiplication
            case "/":
                return OperatorType.Division
            default:
                return OperatorType.None
        }
    }
}

enum InterfaceState {
    case AwaitingFirstValue // empty
    case AwaitingSecondValue // you've hit 5+
    case PendingCalc // this would be when you hit 5*5+ (you have a pending multiplcation)
    func name() -> String {
        switch self {
        case .AwaitingFirstValue:
            return "AwaitingFirstValue"
        case .AwaitingSecondValue:
            return "AwaitingSecondValue"
        case .PendingCalc:
            return "PendingCalc"
        }
    }
}


class ViewController: UIViewController {
    
    var isNewNumberEntryInAnswerField = true
    
    var currentValue:Double? = nil {
        didSet {
            if (self.currentValue == nil) {
                answerLabel.text = "0"
            } else {
                answerLabel.text = toString(self.currentValue!)
            }
        }
    }

    var lastOperation:OperatorType?
    var calculatorState:InterfaceState = .AwaitingFirstValue
    var pendingOperation:OperatorType?
    
    var pendingValueInput:Double?
    
    @IBOutlet weak var answerLabel: UILabel!
    
    // MARK: IBAction Methods
    @IBAction func operationButtonDidPress(operationButton: UIButton) {
        isNewNumberEntryInAnswerField = true
        var operationType:String = operationButton.titleLabel.text
        var answer:Double = 0
        
        if (self.calculatorState == .AwaitingFirstValue) {
            // next step is set the currentValue and perform no operation
            currentValue = pendingValueInput
            self.calculatorState = .AwaitingSecondValue
            pendingValueInput = nil
        }
        
        self.performPendingOpIfExists()
        
        if (operationType != "=") {
            self.pendingOperation = OperatorType.fromString(operationType)
        }
    }
    
    func performPendingOpIfExists() {
        if (calculatorState == .AwaitingSecondValue && self.pendingOperation != OperatorType.None && self.pendingOperation != nil) {
            println("pendingValueInput: \(pendingValueInput)")
            self.currentValue = self.doCalculation(pendingValueInput!, operation: self.pendingOperation!)
            self.pendingOperation = OperatorType.None
        }
    }
 
    
    @IBAction func clearButton(sender: AnyObject) {
        isNewNumberEntryInAnswerField = true
        currentValue = nil
        lastOperation = nil
        self.calculatorState = .AwaitingFirstValue
    }
    
    @IBAction func numberTapped(myButton: UIButton) {
        if isNewNumberEntryInAnswerField == true {
            answerLabel.text = myButton.titleLabel.text
            isNewNumberEntryInAnswerField = false
        } else {
            if isNewNumberEntryInAnswerField == false {
                answerLabel.text = answerLabel.text + myButton.titleLabel.text
            }
        }

        pendingValueInput = (answerLabel.text as NSString).doubleValue
    }
    

    
    // MARK: Custom Methods
    func doCalculation(second:Double?, operation:OperatorType) -> Double {

        // NOTE: this what's often called a 'guard' clause
        if (second == nil) {
            return currentValue!
        }
        
        var value = currentValue!
        
        switch operation {
            case .Addition:
                value = currentValue! + second!
            case .Division:
                value = currentValue! / second!
            case .Multiplication:
                value = currentValue! * second!
            case .Subtraction:
                value = currentValue! - second!
            default:
                println("do nothing")
        }
        
        return value
    }
    
    
    // MARK: View Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

