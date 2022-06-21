//
//  RegisterView.swift
//  Calificaciones.
//
//  Created by Leonardo Rubio on 15/06/22.
//

import UIKit
import CoreData
import SCLAlertView

class RegisterView: UIViewController {
    
    //MARK: - Outlets
    
    //TextFields.
    @IBOutlet weak var fieldName:UITextField!
    @IBOutlet weak var fieldSpanish:UITextField!
    @IBOutlet weak var fieldScience:UITextField!
    @IBOutlet weak var fieldMath:UITextField!
    @IBOutlet weak var fieldPhysical:UITextField!
    
    //Labels.
    @IBOutlet weak var labelSuperior:UILabel!
    @IBOutlet weak var labelErrorName:UILabel!
    @IBOutlet weak var labelErrorSpanish:UILabel!
    @IBOutlet weak var labelErrorScience:UILabel!
    @IBOutlet weak var labelErrorMath:UILabel!
    @IBOutlet weak var labelErrorPhysical:UILabel!
    @IBOutlet weak var labelAverage:UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    //Buttons.
    @IBOutlet weak var buttonAverage:UIButton!
    @IBOutlet weak var buttonRegister:UIButton!
    //Views.
    @IBOutlet weak var viewBackGround:UIView!
    @IBOutlet weak var viewFond:UIView!
    
    //MARK: - Private
    
    private let mainView = ViewController()
    private let context  = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private var name:String     = String()
    private var spanish:Double  = Double()
    private var science:Double  = Double()
    private var math:Double     = Double()
    private var physical:Double = Double()
    private var average:Double  = Double()
    public  var student:Student!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.buttonAverage.customButton()
        self.buttonRegister.customButton()
        self.buttonAverage.isEnabled = false
        self.buttonRegister.isEnabled = false
        self.labelAverage.customLabel()
        self.labelSuperior.customLabel()
        self.viewBackGround.addShadow()
        self.viewFond.addGradient()
        self.titleLabel.customLabel()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardUp), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDown), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    //MARK: - Actions
    
    //TextFields
    @IBAction func actionFieldName(_ sender: Any) {
        validateFieldName(TextField: self.fieldName, Label: self.labelErrorName)
    }
    @IBAction func actionFieldSpanish(_ sender: Any) {
        validateFieldRating(TextField: self.fieldSpanish, Label: self.labelErrorSpanish)
    }
    @IBAction func actionFieldScience(_ sender: Any) {
        validateFieldRating(TextField: self.fieldScience, Label: self.labelErrorScience)
    }
    @IBAction func actionFieldMath(_ sender: Any) {
        validateFieldRating(TextField: self.fieldMath, Label: self.labelErrorMath)
    }
    @IBAction func actionFieldPhysical(_ sender: Any) {
        validateFieldRating(TextField: self.fieldPhysical, Label: self.labelErrorPhysical)
    }
    
    //Buttons
    @IBAction func averageAction(_ sender:UIButton){
        
        if let name = self.fieldName.text{
            self.name = name
        }
        if let spanish = self.fieldSpanish.text{
            self.spanish = Double(spanish) ?? 0.0
        }
        if let science = self.fieldScience.text{
            self.science = Double(science) ?? 0.0
        }
        if let math = self.fieldMath.text{
            self.math = Double(math) ?? 0.0
        }
        if let pyshical = self.fieldPhysical.text{
            self.physical = Double(pyshical) ?? 0.0
        }
        
        self.average = (self.spanish + self.science + self.math + self.physical) / 4
        self.labelAverage.text = "Promedio : \(String(format: "%.2f", average))"
    }
    
    @IBAction func registerAction(_ sender:UIButton){
        
        if self.labelAverage.text != ""{
            do{
                let currentStudent = Student(context: self.context)
                currentStudent.name = self.name
                currentStudent.spanish = self.spanish
                currentStudent.science = self.science
                currentStudent.math = self.math
                currentStudent.physical = self.physical
                currentStudent.average = self.average
                try context.save()
                SCLAlertView().showSuccess("Registrado", subTitle: "Estudiante registrado.", closeButtonTitle: "Aceptar", animationStyle: .bottomToTop)
            }catch{
                SCLAlertView().showError("Error", subTitle: "Error al guardar los datos.", closeButtonTitle: "Aceptar", animationStyle: .bottomToTop)
            }
        }else{
            SCLAlertView().showInfo("Cuidado", subTitle: "Para continuar tienes que promediar.", animationStyle: .bottomToTop)
        }
        
        
        
    }
    
    //MARK: - Private Methods.
    
    private func validateFieldRating(TextField:UITextField,Label:UILabel){
        let isDouble = isDouble(text: TextField.text!)
        let rating = Double(TextField.text ?? "0.0")
        if TextField.text == ""{
            Label.text = "Ingresa un valor."
            Label.textColor = .red
            TextField.layer.borderColor = UIColor.red.cgColor
            TextField.layer.borderWidth = 1.0
        }else if !isDouble{
            Label.text = "No puedes ingresar caracteres."
            Label.textColor = .red
            TextField.layer.borderColor = UIColor.red.cgColor
            TextField.layer.borderWidth = 1.0
        }else if rating ?? 0.0 < 0.0 || rating ?? 0.0 > 10.0{
            Label.text = "Ingresa un valor entre 0 y 10"
            Label.textColor = .red
            TextField.layer.borderColor = UIColor.red.cgColor
            TextField.layer.borderWidth = 1.0
        }else{
            Label.text = ""
            TextField.layer.borderColor = UIColor.blue.cgColor
            TextField.layer.borderWidth = 1.0
        }
        
        self.availableButtos()
    }
    
    private func validateFieldName(TextField:UITextField,Label:UILabel){
        
        if !validateFieldName(enteredString: self.fieldName.text ?? "") {
            Label.text = "No puedes ingresar números o caracteres especiales."
            Label.textColor = .red
            TextField.layer.borderColor = UIColor.red.cgColor
            TextField.layer.borderWidth = 1.0
        }else if TextField.text! == ""{
            Label.text = "Ingresa un valor."
            Label.textColor = .red
            TextField.layer.borderColor = UIColor.red.cgColor
            TextField.layer.borderWidth = 1.0
        }else{
            Label.text = ""
            TextField.layer.borderColor = UIColor.systemIndigo.cgColor
            TextField.layer.borderWidth = 1.0
        }
        self.availableButtos()
    }
     
    func validateFieldName(enteredString:String) -> Bool {
        
        let validationFormat = "[a-zA-Z\\s]+"
        let fieldPredicate = NSPredicate(format:"SELF MATCHES %@", validationFormat)
        return fieldPredicate.evaluate(with: enteredString)
    }
    
    
    func availableButtos() {
        if validateAllIputs() {
            buttonAverage.isEnabled = true
            buttonRegister.isEnabled = true
            buttonAverage.alpha = 1.0
            buttonRegister.alpha = 1.0
        } else {
            buttonAverage.isEnabled = false
            buttonRegister.isEnabled = false
            buttonAverage.alpha = 0.5
            buttonRegister.alpha = 0.5
        }
    }
    
    func validateAllIputs() -> Bool{
        var isOk = false
        if fieldName.text != "" && fieldSpanish.text != "" &&  fieldScience.text != "" && fieldMath.text != "" && fieldPhysical.text != "" {
            isOk = true
        }
        return isOk
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @objc private func keyboardUp(){
        if self.view.frame.origin.y == 0{
            self.view.frame.origin.y = -100
        }
    }
    
    @objc private func keyboardDown(){
        if self.view.frame.origin.y != 0{
            self.view.frame.origin.y = 0
        }
    }
    
    private func isDouble(text:String)->Bool{
        if Double(text) != nil{
            return true
        }else{
            return false
        }
    }
}

