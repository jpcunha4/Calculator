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
        if performingMath{
            resultLabel.text = String(sender.tag - 1)
            performingMath = false
        }else{
            resultLabel.text = "\(resultLabel.text! + String(sender.tag - 1))"
        }
        
        numberOnScreen = Double(resultLabel.text!)!
    }
    
    @IBAction func Buttons(_ sender: UIButton) {
        if resultLabel.text != "" && sender.tag != 12 && sender.tag != 19{
            previousNum = Double(resultLabel.text!)!
            operation = sender.tag
            performingMath = true
            
            switch operation{
            case 15:
                resultLabel.text = "/"
                break
            case 16:
                resultLabel.text = "x"
                break
            case 17:
                resultLabel.text = "-"
                break
            default:
                resultLabel.text = "+"
            }
        }else if sender.tag == 19{
            switch operation{
            case 15:
                resultLabel.text = "\(previousNum / numberOnScreen)"
                break
            case 16:
                resultLabel.text = "\(previousNum * numberOnScreen)"
                break
            case 17:
                resultLabel.text = "\(previousNum - numberOnScreen)"
                break
            default:
                resultLabel.text = "\(previousNum + numberOnScreen)"
            }
        }else{
            resultLabel.text = ""
            performingMath = false
            previousNum = 0
            numberOnScreen = 0
            operation = 0
        }
    }
    
}

