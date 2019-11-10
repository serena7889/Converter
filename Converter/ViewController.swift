//
//  ViewController.swift
//  Converter
//
//  Created by Serena Lambert on 10/11/2019.
//  Copyright © 2019 Serena Lambert. All rights reserved.
//

import UIKit

struct Conversion {
    let from: String
    let to: String
    let constant: Double
    
    func convert(from: Double) -> Double {
        return from * constant
    }
}

class ViewController: UIViewController {

    @IBOutlet weak var conversionPicker: UIPickerView!
    @IBOutlet weak var fromTextField: UITextField!
    @IBOutlet weak var resultLbl: UILabel!
    @IBOutlet weak var invalidLbl: UILabel!
    @IBOutlet weak var unitLbl: UILabel!
    
    var selectedConversion = 0
    
    let conversions = [
        Conversion(from: "miles", to: "kilometres", constant: 1.60934),
        Conversion(from: "kilometres", to: "miles", constant: 0.62137),
        Conversion(from: "pounds", to: "kilograms", constant: 0.45359),
        Conversion(from: "kilograms", to: "pounds", constant: 2.20462)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        conversionPicker.dataSource = self
        conversionPicker.delegate = self
        
        resultLbl.text = ""
        unitLbl.text = ""
        invalidLbl.isHidden = true
        
        let calcBtn = UIButton(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 60))
        calcBtn.backgroundColor = #colorLiteral(red: 0.5450980392, green: 0.8470588235, blue: 0.7411764706, alpha: 1)
        calcBtn.setTitle("CALCULATE", for: .normal)
        calcBtn.setTitleColor(#colorLiteral(red: 0.1411764706, green: 0.2117647059, blue: 0.3960784314, alpha: 1), for: .normal)
        calcBtn.addTarget(self, action: #selector(ViewController.convertBtnPressed), for: .touchUpInside)
        
        fromTextField.inputAccessoryView = calcBtn
    }
    
    
    @objc func convertBtnPressed(_ sender: Any) {
        resultLbl.isHidden = false
        if let fromText = fromTextField.text {
            if let fromValue = Double(fromText) {
                if fromValue >= 0 {
                    invalidLbl.isHidden = true
                    let conv = conversions[selectedConversion]
                    let result = conv.convert(from: fromValue)
                    resultLbl.text = String(format: "%.3f", result)
                    unitLbl.text = conv.to
                    view.endEditing(true)
                    return
                }
            }
        }
        invalidLbl.isHidden = false
    }
    


}

extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return conversions.count
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        
        let green = UIColor(red: 139/255, green: 216/255, blue: 189/255, alpha: 1)
        let title = "From \(conversions[row].from) to \(conversions[row].to)"
        return NSAttributedString(string: title, attributes: [NSAttributedString.Key.foregroundColor : green])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedConversion = row
    }
    
    
}


@IBDesignable
class CustomTextField: UITextField {
    
    override func prepareForInterfaceBuilder() {
        setupView()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    func setupView() {
        let green = UIColor(red: 139/255, green: 216/255, blue: 189/255, alpha: 1)
        backgroundColor = UIColor.white.withAlphaComponent(0.2)
        textColor = green
        layer.cornerRadius = 5.0
        clipsToBounds = true
        textAlignment = .center
        borderStyle = .none
        
        if let p = placeholder {
            let place = NSAttributedString(string: p, attributes: [.foregroundColor: green])
            attributedPlaceholder = place
        }
    }
    
}
