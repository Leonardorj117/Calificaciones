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
    private var statusOkName:Bool     = false
    private var statusOkSpanish:Bool  = false
    private var statusOkScience:Bool  = false
    private var statusOkMath:Bool     = false
    private var statusOkPhysical:Bool = false
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
        self.statusOkName = validateFieldName(TextField: self.fieldName, Label: self.labelErrorName)
        self.availableButtos()
    }
    @IBAction func actionFieldSpanish(_ sender: Any) {
        self.statusOkSpanish = validateFieldRating(TextField: self.fieldSpanish, Label: self.labelErrorSpanish)
        self.availableButtos()
    }
    @IBAction func actionFieldScience(_ sender: Any) {
        self.statusOkScience = validateFieldRating(TextField: self.fieldScience, Label: self.labelErrorScience)
        self.availableButtos()
    }
    @IBAction func actionFieldMath(_ sender: Any) {
        self.statusOkMath = validateFieldRating(TextField: self.fieldMath, Label: self.labelErrorMath)
        self.availableButtos()
    }
    @IBAction func actionFieldPhysical(_ sender: Any) {
        self.statusOkPhysical = validateFieldRating(TextField: self.fieldPhysical, Label: self.labelErrorPhysical)
        self.availableButtos()
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
        
        if statusOkName,statusOkSpanish,statusOkScience,statusOkMath,statusOkPhysical{
            self.average = (self.spanish + self.science + self.math + self.physical) / 4
            self.labelAverage.text = "Promedio : \(String(format: "%.2f", average))"
        }else{
            SCLAlertView().showError("Error", subTitle: "Completa los campos corrctamente para poder continuar.", closeButtonTitle: "Ok", animationStyle: .rightToLeft)
        }
    }
    
    @IBAction func registerAction(_ sender:UIButton){
        if statusOkName,statusOkSpanish,statusOkScience,statusOkMath,statusOkPhysical{
            saveStudent()
        }else{
            SCLAlertView().showError("Error", subTitle: "Completa los campos corrctamente para poder continuar.", closeButtonTitle: "Ok", animationStyle: .rightToLeft)
        }
    }
    
    //MARK: - Private Methods.
    
    private func validateFieldRating(TextField:UITextField,Label:UILabel) -> Bool{
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
            return true
        }
        return false
    }
    
    private func validateFieldName(TextField:UITextField,Label:UILabel) -> Bool{
        
        if !validateFieldName(enteredString: self.fieldName.text ?? "") {
            Label.text = "Ingresa más de 2 caracteres, sin caracteres especiales."
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
            return true
        }
        return false
        
    }
    
    private func saveStudent(){
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
                self.fieldName.text = ""
                self.fieldSpanish.text = ""
                self.fieldScience.text = ""
                self.fieldMath.text = ""
                self.fieldPhysical.text = ""
                self.labelAverage.text = ""
            }catch{
                SCLAlertView().showError("Error", subTitle: "Error al guardar los datos.", closeButtonTitle: "Aceptar", animationStyle: .bottomToTop)
            }
        }else{
            SCLAlertView().showInfo("Cuidado", subTitle: "Para continuar tienes que promediar.", animationStyle: .bottomToTop)
        }
    }
    
    func validateFieldName(enteredString:String) -> Bool {
        let validationFormat = "[a-zA-Z\\s]{2,25}+"
        let fieldPredicate = NSPredicate(format:"SELF MATCHES %@", validationFormat)
        return fieldPredicate.evaluate(with: enteredString)
    }
    
    
    func availableButtos() {
        if validateAllInputs() {
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
    
    func validateAllInputs() -> Bool{
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
            self.view.frame.origin.y = -90
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

