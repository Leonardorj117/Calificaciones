//
//  Extensions.swift
//  Calificaciones.
//
//  Created by Leonardo Rubio on 19/06/22.
//

import Foundation
import UIKit

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

extension UILabel{
    func customLabel(){
        self.layer.cornerRadius = self.frame.size.height / 5
        self.layer.masksToBounds = true
    }
}

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
