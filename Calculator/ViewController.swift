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
        }
        
        resultLabel.text = "\(resultLabel.text! + String(sender.tag - 1))"
        numberOnScreen = Double(resultLabel.text!)!
    }
    
    @IBAction func Buttons(_ sender: UIButton) {
        if resultLabel.text != "" && sender.tag != 11 && sender.tag != 16{
            previousNum = Double(resultLabel.text!)!
            operation = sender.tag
            
            if operation == 12{
                resultLabel.text = "/"
            }else if operation == 13{
                resultLabel.text = "x"
            }else if operation == 14{
                resultLabel.text = "-"
            }else{
                resultLabel.text = "+"
            }
            
            performingMath = true
        }else if sender.tag == 16{
            if operation == 12{
                resultLabel.text = "\(previousNum / numberOnScreen)"
            }else if operation == 13{
                resultLabel.text = "\(previousNum * numberOnScreen)"
            }else if operation == 14{
                resultLabel.text = "\(previousNum - numberOnScreen)"
            }else{
                resultLabel.text = "\(previousNum + numberOnScreen)"
            }
        }else if sender.tag == 11{
            resultLabel.text = ""
            performingMath = false
            previousNum = 0
            numberOnScreen = 0
            operation = 0
        }
    }
    
}

