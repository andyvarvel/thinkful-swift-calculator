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
    case awaitingSecondInputValue
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
        
        //get the string value of the operation button that was pressed
        var valueOfOperationButtonPressed:String = operationButton.titleLabel.text
        
        //convert the string to the type of operation that was pressed
        var currentOperation = convertOperationString(valueOfOperationButtonPressed)
        
        //make the current value the value that is on the screen
        var currentValue:Double = (answerLabel.text as NSString).doubleValue
        
        checkIfOperationShouldBePerformed(currentValue, currentOperation: currentOperation, calculatorState: calculatorState)
    }
    
    func checkIfOperationShouldBePerformed (currentValue:Double, currentOperation:operationType, calculatorState:appState) {
        
        if (currentOperation == operationType.Equals) {
            
            //reset the calculator state
            self.calculatorState = appState.awaitingSecondInputValue
            printAnswer(performCalculatorOperation(previousValue, currentValue: currentValue, operation: previousOperation))
        } else {
            switch calculatorState {
            case appState.readyForOperation:
                var answer = performCalculatorOperation(previousValue, currentValue: currentValue, operation: previousOperation)
                println("and the answer is \(answer)")
                previousValue = answer
                previousOperation = currentOperation
                printAnswer(answer)
            default:
                previousValue = currentValue
                previousOperation = currentOperation
                self.calculatorState = appState.readyForOperation
            }
        }
        
        
        
    }
    

    
    func printAnswer(answer:Double) {
        answerLabel.text = toString(answer)
    }
    
    func performCalculatorOperation(previousValue:Double, currentValue:Double, operation:operationType)  -> Double {
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
        
        //do something
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
    
    //MARK: IB Outlets

    @IBAction func clearButton(sender: AnyObject) {
       //do something
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

