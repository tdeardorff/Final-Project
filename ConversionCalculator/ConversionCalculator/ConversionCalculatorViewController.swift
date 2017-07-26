//
//  ConversionCalculatorViewController.swift
//  ConversionCalculatorViewController
//
//  Created by Trever Deardorff on 7/25/17.
//  Copyright © 2017 Trever Deardorff. All rights reserved.
//

import UIKit

class ConversionCalculatorViewController: UIViewController {
    
    var convert : ConversionType = ConversionType.FtoC
    
    var prevNums: String = ""
    var enteredNumber: Double = 0.0
    var convertedNumber: Double = 0.0
    
    @IBOutlet weak var convertedTextField: UITextField!
    
    @IBOutlet weak var enteredTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        setTextField(convert: convert.rawValue)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setTextField(convert: String)
    {
        if convert.contains("FtoC") {
            enteredTextField.text = " °F"
            convertedTextField.text = " °C"
        }
        
        if convert.contains("CtoF") {
            enteredTextField.text = " °C"
            convertedTextField.text = " °F"
        }
        
        if convert.contains("MitoKm") {
            enteredTextField.text = " mi"
            convertedTextField.text = " km"
        }
        
        if convert.contains("KmtoMi") {
            enteredTextField.text = " km"
            convertedTextField.text = " mi"
        }
        
        //reset variables if convert type changed
        prevNums = ""
        enteredNumber = 0.0
        convertedNumber = 0.0
    }
    
    
    @IBAction func numbers(_ sender: UIButton) {
        
        switch sender.tag {
            
        //check for '.' button tag of 10
        case 10:
            //if number string already has a decimal, prevent multiple decimals in the string
            if prevNums.contains(".") {
                return
            }
                
            //if the decimal is the first button pushed in the string, add a 0 before it
            else if prevNums.isEmpty {
                prevNums = "0" + "."
            }
                
            //otherwise just append a decimal point to number
            else {
                prevNums.append(".")
            }
            
        //checks for clear button tag of 11
        case 11:
            //clear text fields back to empty with correct units of conversion type
            setTextField(convert: convert.rawValue)
            
            //reset variables
            prevNums = ""
            enteredNumber = 0.0
            convertedNumber = 0.0

            
        //check for +/- button tag of 12
        case 12:
            //number string is empty, do nothing
            if prevNums.isEmpty{
                return
            }
                
            //if number string does not contain a negative sign already, add one to beginning
            else if (!prevNums.hasPrefix("-")){
                prevNums = "-" + prevNums
            }
                
            //remove negative sign from beginning of number
            else {
                prevNums.remove(at: prevNums.startIndex)
            }
            
        case 0:
            //if 0 is pushed and number string already starts with 0, do nothing
            if prevNums.hasPrefix("0") {
                return
            }
                
            //if 0 is pushed and the number string doesnt start with 0, add to the string
            else {
                prevNums.append(String(sender.tag))
            }

            
        default:
            //if number string starts with a 0 and a decimal, append the new number to the end of the string
            if prevNums.hasPrefix("0") && prevNums.contains(".") {
                prevNums.append(String(sender.tag))
            }
            
            //if number string starts with a 0 but has no decimal, replace the zero with the new number
            else if prevNums.hasPrefix("0") {
                prevNums = String(sender.tag)
            }
                
            //otherwise just start appending numbers
            else {
                prevNums.append(String(sender.tag))
            }
        }
        
        switch convert.rawValue {
        case "FtoC":
            enteredTextField.text = prevNums + " °F"
            if let enteredNumber = Double(prevNums)
            {
                convertedNumber = doConversion(enteredNum: enteredNumber, type: convert)
                convertedTextField.text = String(convertedNumber) + " °C"
            }
            
        case "CtoF":
            enteredTextField.text = prevNums + " °C"
            if let enteredNumber = Double(prevNums)
            {
                convertedNumber = doConversion(enteredNum: enteredNumber, type: convert)
                convertedTextField.text = String(convertedNumber) + " °F"
            }
            
        case "MitoKm":
            enteredTextField.text = prevNums + " mi"
            if let enteredNumber = Double(prevNums)
            {
                convertedNumber = doConversion(enteredNum: enteredNumber, type: convert)
                convertedTextField.text = String(convertedNumber) + " km"
            }
            
        case "KmtoMi":
            enteredTextField.text = prevNums + " km"
            if let enteredNumber = Double(prevNums)
            {
                convertedNumber = doConversion(enteredNum: enteredNumber, type: convert)
                convertedTextField.text = String(convertedNumber) + " mi"
            }

        default:
            return
        }
    }
    
    
    func doConversion(enteredNum: Double, type: ConversionType) -> Double
    {
        var convertedNum: Double = 0.0
        
        switch type.rawValue {
        case "FtoC":
            convertedNum = (enteredNum - 32) * (5/9)
            return convertedNum
            
        case "CtoF":
            convertedNum = (enteredNum * (9/5)) + 32
            return convertedNum
            
        case "MitoKm":
            convertedNum = (enteredNum * 1.60934)
            return convertedNum
            
        case "KmtoMi":
            convertedNum = (enteredNum / 1.60934)
            return convertedNum
        
        default:
            return convertedNum
        }
    }

    @IBAction func chooseConversion(_ sender: Any) {
        let alert = UIAlertController(title: "Conversion", message: "Choose conversion type", preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "Fahrenheit to Celcius", style: UIAlertActionStyle.default, handler: {
            (alertAction) -> Void in
            self.convert = ConversionType.FtoC
            self.setTextField(convert: self.convert.rawValue)
        }))
        
        alert.addAction(UIAlertAction(title: "Celcius to Fahrenheit", style: UIAlertActionStyle.default, handler: {
            (alertAction) -> Void in
            self.convert = ConversionType.CtoF
            self.setTextField(convert: self.convert.rawValue)
        }))
        
        alert.addAction(UIAlertAction(title: "Miles to Kilometers", style: UIAlertActionStyle.default, handler: {
            (alertAction) -> Void in
            self.convert = ConversionType.MitoKm
            self.setTextField(convert: self.convert.rawValue)
        }))
        
        alert.addAction(UIAlertAction(title: "Kilometers to Miles", style: UIAlertActionStyle.default, handler: {
            (alertAction) -> Void in
            self.convert = ConversionType.KmtoMi
            self.setTextField(convert: self.convert.rawValue)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
}
