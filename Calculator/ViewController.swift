//
//  ViewController.swift
//  Calculator
//
//  Created by Andy Varvel on 6/08/2014.
//  Copyright (c) 2014 Andy Varvel. All rights reserved.
//

import UIKit

enum operationType {
    case Add
    case Subtract
    case Multiply
    case Divide
    case Equals
    case None
}

enum appState {
    case calculatorHasBeenReset
    case readyForOperation
}

class ViewController: UIViewController {
    
    //set initial variables
    var isNewNumberEntryInAnswerField = true
    var previousValue:Double = 0
    var currentValue:Double = 0
    var currentOperation:operationType = operationType.None
    var previousOperation:operationType = operationType.None
    var calculatorState = appState.calculatorHasBeenReset
    
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
    
    func shouldOperationShouldBePerformed (currentValue:Double, currentOperation:operationType, calculatorState:appState) -> Bool {
        
            switch calculatorState {
            case appState.readyForOperation:
                if (currentOperation == operationType.Equals) {
                    println("the current value is \(currentValue) and the previous is \(previousValue)")
                    self.calculatorState = appState.calculatorHasBeenReset
                }
                return true
            case appState.calculatorHasBeenReset:
                previousValue = currentValue
                previousOperation = currentOperation
                self.calculatorState = appState.readyForOperation
                return false
            }
    }
    
    
    func printAnswer(answer:Double) {
        answerLabel.text = toString(answer)
    }
    
    func doOperation(previousValue:Double, currentValue:Double, operation:operationType)  -> Double {
        //do calculation here
        
        switch operation {
            case operationType.Add:
                return previousValue + currentValue
            case operationType.Multiply:
                return previousValue * currentValue
            case operationType.Subtract:
                return previousValue - currentValue
            case operationType.Divide:
                return previousValue / currentValue
            default:
                return 0
        }
       
    }
    
    
    //this function converts the string to an operation Type
    func convertOperationString(operationValue:String) -> operationType {
        
        switch operationValue {
            case "+":
                return operationType.Add
            case "-":
                return operationType.Subtract
            case "x":
                return operationType.Multiply
            case "/":
                return operationType.Divide
            case "=":
                return operationType.Equals
            default:
                return operationType.None
        }
    }
    
    @IBAction func clearButton(sender: AnyObject) {
        var isNewNumberEntryInAnswerField = true
        var previousValue:Double = 0
        var currentValue:Double = 0
        var currentOperation:operationType = operationType.None
        var previousOperation:operationType = operationType.None
        var calculatorState = appState.calculatorHasBeenReset
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

