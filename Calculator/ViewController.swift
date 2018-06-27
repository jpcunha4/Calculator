//
//  ViewController.swift
//  Calculator
//
//  Created by Joao Paulo Cunha Ávila on 23/06/18.
//  Copyright © 2018 Joao Paulo Cunha Ávila. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIGestureRecognizerDelegate {
    
    var numberOnScreen:Double = 0
    var previousNum:Double!
    var performingMath = false
    var operation = 0
    var isAffirmative:Bool = true
    var isResult:Bool = false
    @IBOutlet weak var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(deleteText(gesture:)))
        swipeLeft.direction = .left
        view.addGestureRecognizer(swipeLeft)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    /*
     This method is responsable the numbers themselves.
     Tags:
     1 - 10: numbers 0 - 9
     11: Adds a comma(,) symbol to the number
     13: Changes the sign of the number
     */
    @IBAction func Numbers(_ sender: UIButton) {
        isResult = false
        if(sender.tag != 11){
            if sender.tag == 13{
                if isAffirmative{
                    resultLabel.text = "-\(resultLabel.text!)"
                    isAffirmative = false
                }else{
                    resultLabel.text!.removeFirst(1)
                    isAffirmative = true
                }
            }else if performingMath{
                resultLabel.text = String(sender.tag - 1)
                performingMath = false
            }else if(resultLabel.text != "0"){
                resultLabel.text = "\(resultLabel.text! + String(sender.tag - 1))"
            }else if(sender.tag - 1) != 0{
                resultLabel.text = "\(String(sender.tag - 1))"
            }
            
            numberOnScreen = testComma(number:resultLabel.text!)
        }else if !(resultLabel.text!.contains(",")){
            resultLabel.text = "\(resultLabel.text!),"
        }
    }
    
    /*
     This method is responsable for operations with numbers
     Tags:
     12: Cleans the memory
     14: Percentage
     15: Division
     16: Multiplication
     17: Subtraction
     18: Addition
     19: Answer
    */
    @IBAction func Buttons(_ sender: UIButton) {
        if sender.tag == 14{
            if previousNum != nil{
                numberOnScreen = previousNum * testComma(number: resultLabel.text!) / 100
            }else{
                numberOnScreen /= 100
            }
            
            resultLabel.text = setResultLabel(number: numberOnScreen)
            isResult = true
        }else if sender.tag != 12 && sender.tag != 19{
            previousNum = testComma(number:resultLabel.text!)
            operation = sender.tag
            performingMath = true
        }else if sender.tag == 19{
            var result:Double = 0
            switch operation{
            case 15:
                result = previousNum / numberOnScreen
                break
            case 16:
                result = previousNum * numberOnScreen
                break
            case 17:
                result = previousNum - numberOnScreen
                break
            default:
                result = previousNum + numberOnScreen
            }
            
            resultLabel.text = setResultLabel(number: result)
            isResult = true
        }else{
            resultLabel.text = "0"
            performingMath = false
            isAffirmative = true
            previousNum = 0
            numberOnScreen = 0
            operation = 0
        }
    }
    
    //Giving a string, this method substitute the ','(comma) character by a '.'(dot) and returns a Double as a result.
    func testComma(number:String) -> Double{
        if number.contains(","){
            return Double(number.replacingOccurrences(of: ",", with: "."))!
        }else{
            return Double(number)!
        }
    }
    
    //Giving a double, this method substitute the '.'(dot) character by a ','(comma) and returns a String as a result.
    func testDot(number:Double) -> String {
        if String(number).contains("."){
            return String(number).replacingOccurrences(of: ".", with: ",")
        }else{
            return String(number)
        }
    }
    
    //This method is responsable for setting the ResultLabel text.
    func setResultLabel(number:Double) -> String{
        if floor(number) == number{
            return "\(Int(floor(number)))"
        }else{
            return testDot(number:number)
        }
    }
    
    //This method is responsable for deleting numbers by swiping right in the numbers screen.
    @objc func deleteText(gesture:UIGestureRecognizer){
        let gestureLocation = gesture.location(in: view)
        let resultLabelOrigin = resultLabel.frame.origin
        
        if(gestureLocation.x >= resultLabelOrigin.x &&
           gestureLocation.x <= resultLabelOrigin.x + resultLabel.frame.width &&
            gestureLocation.y >= resultLabelOrigin.y &&
            gestureLocation.y <= resultLabelOrigin.y + resultLabel.frame.height){
            
            if !isResult && resultLabel.text != "0"{
                resultLabel.text?.removeLast()
                if resultLabel.text == ""{
                    resultLabel.text = "0"
                }
            }
        }
    }
}

