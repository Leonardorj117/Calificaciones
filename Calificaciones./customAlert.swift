//
//  Alert.swift
//  Calificaciones.
//
//  Created by Leonardo Rubio on 18/06/22.
//

import Foundation
import UIKit

class AlertView:UIView{
    //MARK: - Outlets.
    
    @IBOutlet var parentView:UIView!
    @IBOutlet weak var alertView:UIView!
    @IBOutlet weak var imageView:UIImageView!
    @IBOutlet weak var title:UILabel!
    @IBOutlet weak var message:UILabel!
    @IBOutlet weak var button:UIButton!
    
    //MARK: - Private
    
    static let shared = AlertView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        Bundle.main.loadNibNamed("customAlert", owner: self, options: nil)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Button Action
    
    @IBAction func actionButton(_sender:UIButton){
        parentView.removeFromSuperview()
    }
    
    //MARK: - Private Methods
    
    private func commonInit(){
        self.imageView.layer.cornerRadius = 30
        self.imageView.layer.borderColor = UIColor.white.cgColor
        self.imageView.layer.borderWidth = 2
        
        self.alertView.layer.cornerRadius = 10
        self.button.layer.cornerRadius = self.button.bounds.height / 2
        self.button.clipsToBounds = true
        
        self.parentView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        self.parentView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
    }
    
    enum AlertType{
        case succes
        case failure
    }
    
    func showAlert(title:String,message:String,alertType:AlertType){
        self.title.text = title
        self.message.text = message
        
        switch alertType{
        case .succes:
            self.imageView.image = UIImage(named: "icons8-done")
            self.button.backgroundColor = UIColor.green
            
            
        case .failure:
            self.imageView.image = UIImage(named: "icons8-cancel")
            self.button.backgroundColor = UIColor.red
        }
        UIApplication.shared.windows.first { $0.isKeyWindow }?.addSubview(parentView)
    }
}
