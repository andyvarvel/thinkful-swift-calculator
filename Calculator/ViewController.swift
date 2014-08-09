//
//  ViewController.swift
//  Calculator
//
//  Created by Andy Varvel on 6/08/2014.
//  Copyright (c) 2014 Andy Varvel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var isNewNumberEntryInAnswerField = true
    var numberOne:Double = 0
    var numberTwo:Double = 0
    var lastOperation:String = "Awaiting Second Number"
    
    @IBAction func operationButtonDidPress(operationButton: UIButton) {
        isNewNumberEntryInAnswerField = true
        var operationType:String = operationButton.titleLabel.text
        var answer:Double = 0
        println("the \(operationType) button was pressed")
            switch lastOperation {
                case "+":
                    numberTwo = Double(answerLabel.text.toInt()!)
                    answer = numberOne + numberTwo
                    println("Performing the operation \(numberOne) plus \(numberTwo)")
                    answerLabel.text = toString(answer)
                    numberOne = answer
                    lastOperation = operationType
                case "-":
                    println("Performing the operation \(numberOne) minus \(numberTwo)")
                    numberTwo = Double(answerLabel.text.toInt()!)
                    answer = numberOne - numberTwo
                    answerLabel.text = toString(answer)
                    numberOne = answer
                    lastOperation = operationType
                case "*":
                    println("Performing the operation \(numberOne) times \(numberTwo)")
                    numberTwo = Double(answerLabel.text.toInt()!)
                    answer = numberOne * numberTwo
                    answerLabel.text = toString(answer)
                    numberOne = answer
                    lastOperation = operationType
                case "/":
                    println("Performing the operation \(numberOne) divide by \(numberTwo)")
                    numberTwo = Double(answerLabel.text.toInt()!)
                    answer = numberOne / numberTwo
                    answerLabel.text = toString(answer)
                    numberOne = answer
                    lastOperation = operationType
                case "Awaiting Second Number":
                    lastOperation = operationType
                    numberOne = Double(answerLabel.text.toInt()!)
                    println("awaiting second number")
                default:
                    println("there was an error")
            }
        }
    
    

    @IBAction func clearButton(sender: AnyObject) {
        isNewNumberEntryInAnswerField = true
        answerLabel.text = "0"
        var numberOne:Double = 0
        var numberTwo:Double = 0
        var lastOperation:String = "Awaiting Second Number"
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

