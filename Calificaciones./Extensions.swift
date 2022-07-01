//
//  Extensions.swift
//  Calificaciones.
//
//  Created by Leonardo Rubio on 19/06/22.
//

import Foundation
import UIKit

//MARK: - UIButton

extension UIButton{
    func customButton(){
        self.layer.shadowColor = UIColor(named: "CustomPurple")?.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 6.0)
        self.layer.shadowRadius = 3
        self.layer.shadowOpacity = 0.5
        self.layer.masksToBounds = false
        self.layer.cornerRadius = self.frame.height / 2
        self.backgroundColor = UIColor.white
        self.layer.borderColor = UIColor.systemIndigo.cgColor
        self.layer.borderWidth = 1
    }
}

//MARK: - UILabel

extension UILabel{
    func customLabel(){
        self.layer.cornerRadius = self.frame.size.height / 5
        self.layer.masksToBounds = true
    }
}

//MARK: - UIView

extension UIView {
    func addShadow() {
        self.layer.shadowColor = UIColor(named: "CustomPurple")?.cgColor
        self.layer.shadowOffset = .zero
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 10
        self.layer.cornerRadius = self.frame.size.height / 50
    }
    func addGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.colors = [UIColor.systemIndigo.cgColor,UIColor(named: "CustomPurple")?.cgColor as Any]
        self.layer.addSublayer(gradientLayer)
    }
    func addGradient2() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.colors = [UIColor(named: "CustomPurple")?.cgColor as Any,UIColor.systemIndigo.cgColor]
        self.layer.addSublayer(gradientLayer)
    }
}

//MARK: - UITextField

extension UITextField{
    
    func validateFieldRating(Label:UILabel) -> Bool{
        let isDouble = isDouble(text: self.text!)
        let rating = Double(self.text ?? "0.0")
        if self.text == ""{
            Label.text = "Ingresa un valor."
            Label.textColor = .red
            self.layer.borderColor = UIColor.red.cgColor
            self.layer.borderWidth = 1.0
        }else if !isDouble{
            Label.text = "No puedes ingresar caracteres."
            Label.textColor = .red
            self.layer.borderColor = UIColor.red.cgColor
            self.layer.borderWidth = 1.0
        }else if rating ?? 0.0 < 0.0 || rating ?? 0.0 > 10.0{
            Label.text = "Ingresa un valor entre 0 y 10"
            Label.textColor = .red
            self.layer.borderColor = UIColor.red.cgColor
            self.layer.borderWidth = 1.0
        }else{
            Label.text = ""
            self.layer.borderColor = UIColor.blue.cgColor
            self.layer.borderWidth = 1.0
            return true
        }
        return false
    }
    private func isDouble(text:String)->Bool{
        if Double(text) != nil{
            return true
        }else{
            return false
        }
    }
    
    func validateFieldName(Label:UILabel) -> Bool{
        
        if !fieldName(string: self.text ?? "") {
            Label.text = "Ingresa más de 2 caracteres, sin caracteres especiales."
            Label.textColor = .red
            self.layer.borderColor = UIColor.red.cgColor
            self.layer.borderWidth = 1.0
        }else if self.text! == ""{
            Label.text = "Ingresa un valor."
            Label.textColor = .red
            self.layer.borderColor = UIColor.red.cgColor
            self.layer.borderWidth = 1.0
        }else{
            Label.text = ""
            self.layer.borderColor = UIColor.systemIndigo.cgColor
            self.layer.borderWidth = 1.0
            return true
        }
        return false
        
    }
    
    fileprivate func fieldName(string:String) -> Bool {
        let validationFormat = "[a-zA-Z\\s]{2,30}+"
        let fieldPredicate = NSPredicate(format:"SELF MATCHES %@", validationFormat)
        return fieldPredicate.evaluate(with: string)
    }
    
    func validateFieldID(label:UILabel) -> Bool{
        if !fieldID(string: self.text ?? ""){
            label.text = "ingresa solo 3 números sin caracteres especiales."
            label.textColor = .red
            self.layer.borderColor = UIColor.red.cgColor
            self.layer.borderWidth = 1.0
        }else if self.text! == ""{
            label.text = "Ingresa un valor."
            label.textColor = .red
            self.layer.borderColor = UIColor.red.cgColor
            self.layer.borderWidth = 1.0
        }else{
            label.text = ""
            self.layer.borderColor = UIColor.systemIndigo.cgColor
            self.layer.borderWidth = 1.0
            return true
        }
        return false
    }
    
    fileprivate func fieldID(string:String) -> Bool{
        let validateFormat = "^\\d{3}$"
        let fieldPredicate = NSPredicate(format:"SELF MATCHES %@", validateFormat)
        return fieldPredicate.evaluate(with: string)
    }
    
    
}
