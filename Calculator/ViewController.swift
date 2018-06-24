//
//  ViewController.swift
//  Calculator
//
//  Created by Joao Paulo Cunha Ávila on 23/06/18.
//  Copyright © 2018 Joao Paulo Cunha Ávila. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var numberOnScreen:Double = 0
    var previousNum:Double = 0
    var performingMath = false;
    var operation = 0
    var isAffirmative:Bool = true
    @IBOutlet weak var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func Numbers(_ sender: UIButton) {
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
    
    @IBAction func Buttons(_ sender: UIButton) {
        if sender.tag != 12 && sender.tag != 19{
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
            
            if String(result).contains("."){
                resultLabel.text = String(result).replacingOccurrences(of: ".", with: ",")
            }else{
                resultLabel.text = String(result)
            }
        }else{
            resultLabel.text = "0"
            performingMath = false
            isAffirmative = true
            previousNum = 0
            numberOnScreen = 0
            operation = 0
        }
    }
    
    func testComma(number:String) -> Double{
        if number.contains(","){
            return Double(number.replacingOccurrences(of: ",", with: "."))!
        }else{
            return Double(number)!
        }
    }
}

