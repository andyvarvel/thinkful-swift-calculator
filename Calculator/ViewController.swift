//
//  ViewController.swift
//  Calculator
//
//  Created by Andy Varvel on 6/08/2014.
//  Copyright (c) 2014 Andy Varvel. All rights reserved.
//

import UIKit

enum OperationType {
    case Add
    case Subtract
    case Multiply
    case Divide
    case Equals
    case None
}

enum AppState {
    case CalculatorHasBeenReset
    case ReadyForOperation
}

class ViewController: UIViewController {
    
    //set initial variables
    var isNewNumberEntryInAnswerField = true
    var previousValue:Double = 0
    var currentValue:Double = 0
    var currentOperation:OperationType = .None
    var previousOperation:OperationType = .None
    var calculatorState:AppState = .CalculatorHasBeenReset
    
    @IBAction func operationButtonDidPress(operationButton: UIButton) {
        isNewNumberEntryInAnswerField = true
        var valueOfOperationButtonPressed:String = operationButton.titleLabel.text
        var currentOperation = convertOperationString(valueOfOperationButtonPressed)
        var currentValue:Double = (answerLabel.text as NSString).doubleValue
        if (shouldOperationShouldBePerformed(currentValue, currentOperation: currentOperation, calculatorState: calculatorState) == true) {
            var answer = doOperation(previousValue, currentValue: currentValue, operation: previousOperation)
            previousValue = answer
            previousOperation = currentOperation
            printAnswer(answer)
        }
    }
    
    func shouldOperationShouldBePerformed (currentValue:Double, currentOperation:OperationType, calculatorState:AppState) -> Bool {
        switch calculatorState {
        case .ReadyForOperation:
            if (currentOperation == OperationType.Equals) {
                println("the current value is \(currentValue) and the previous is \(previousValue)")
                self.calculatorState = AppState.CalculatorHasBeenReset
            }
            return true
        case AppState.CalculatorHasBeenReset:
            previousValue = currentValue
            previousOperation = currentOperation
            self.calculatorState = AppState.ReadyForOperation
            return false
        }
    }
    
    
    func printAnswer(answer:Double) {
        answerLabel.text = toString(answer)
    }
    
    func doOperation(previousValue:Double, currentValue:Double, operation:OperationType)  -> Double {
        //do calculation here
        
        switch operation {
        case .Add:
            return previousValue + currentValue
        case .Multiply:
            return previousValue * currentValue
        case .Subtract:
            return previousValue - currentValue
        case .Divide:
            return previousValue / currentValue
        default:
            return 0
        }
        
    }
    
    
    //this function converts the string to an operation Type
    func convertOperationString(operationValue:String) -> OperationType {
        
        switch operationValue {
        case "+":
            return .Add
        case "-":
            return .Subtract
        case "x":
            return .Multiply
        case "/":
            return .Divide
        case "=":
            return .Equals
        default:
            return .None
        }
    }
    
    @IBAction func clearButton(sender: AnyObject) {
        var isNewNumberEntryInAnswerField = true
        var previousValue:Double = 0
        var currentValue:Double = 0
        var currentOperation:OperationType = .None
        var previousOperation:OperationType = .None
        var calculatorState = AppState.CalculatorHasBeenReset
        printAnswer(0)
    }
    
    @IBOutlet weak var answerLabel: UILabel!
    
    @IBAction func numberTapped(myButton: UIButton) {
        if isNewNumberEntryInAnswerField == true {
            answerLabel.text = myButton.titleLabel.text
            isNewNumberEntryInAnswerField = false
        } else {
            if isNewNumberEntryInAnswerField == false {
                answerLabel.text = answerLabel.text + myButton.titleLabel.text
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

