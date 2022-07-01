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
    @IBOutlet weak var fieldID:UITextField!
    
    //Labels.
    @IBOutlet weak var labelSuperior:UILabel!
    @IBOutlet weak var labelErrorName:UILabel!
    @IBOutlet weak var labelErrorSpanish:UILabel!
    @IBOutlet weak var labelErrorScience:UILabel!
    @IBOutlet weak var labelErrorMath:UILabel!
    @IBOutlet weak var labelErrorPhysical:UILabel!
    @IBOutlet weak var labelErrorID:UILabel!
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
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private var name:String = String()
    private var spanish:Double = Double()
    private var science:Double = Double()
    private var math:Double = Double()
    private var physical:Double = Double()
    private var average:Double = Double()
    private var id:Int32 = Int32()
    private var statusOkName:Bool = false
    private var statusOkSpanish:Bool = false
    private var statusOkScience:Bool = false
    private var statusOkMath:Bool = false
    private var statusOkPhysical:Bool = false
    private var statusOkId:Bool = false
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
    @IBAction func actionFieldID(_ sender: Any) {
        self.statusOkId = self.fieldID.validateFieldID(label: self.labelErrorID)
        self.availableButtos()
    }
    
    @IBAction func actionFieldName(_ sender: Any) {
        self.statusOkName = self.fieldName.validateFieldName(Label: self.labelErrorName)
        self.availableButtos()
    }
    @IBAction func actionFieldSpanish(_ sender: Any) {
        self.statusOkSpanish = self.fieldSpanish.validateFieldRating(Label: self.labelErrorSpanish)
        self.availableButtos()
    }
    @IBAction func actionFieldScience(_ sender: Any) {
        self.statusOkScience = self.fieldScience.validateFieldRating(Label: self.labelErrorScience)
        self.availableButtos()
    }
    @IBAction func actionFieldMath(_ sender: Any) {
        self.statusOkMath = self.fieldMath.validateFieldRating(Label: self.labelErrorMath)
        self.availableButtos()
    }
    @IBAction func actionFieldPhysical(_ sender: Any) {
        self.statusOkPhysical = self.fieldPhysical.validateFieldRating(Label: self.labelErrorPhysical)
        self.availableButtos()
    }
    
    //Buttons
    @IBAction func averageAction(_ sender:UIButton){
        
        if let id = self.fieldID.text{
            self.id = Int32(id) ?? 0
        }
        
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
            checkRecord(with: self.id, name: self.name)
        }else{
            SCLAlertView().showError("Error", subTitle: "Completa los campos corrctamente para poder continuar.", closeButtonTitle: "Ok", animationStyle: .rightToLeft)
        }
    }
    
    //MARK: - Private Methods.
    
    fileprivate func saveStudent(){
        if self.labelAverage.text != ""{
            do{
                let currentStudent = Student(context: self.context)
                currentStudent.name = self.name
                currentStudent.spanish = self.spanish
                currentStudent.science = self.science
                currentStudent.math = self.math
                currentStudent.physical = self.physical
                currentStudent.average = self.average
                currentStudent.id = self.id
                try context.save()
                SCLAlertView().showSuccess("Registrado", subTitle: "Estudiante registrado.", closeButtonTitle: "Aceptar", animationStyle: .bottomToTop)
                cleanView()
            }catch{
                SCLAlertView().showError("Error", subTitle: "Error al guardar los datos.", closeButtonTitle: "Aceptar", animationStyle: .bottomToTop)
            }
        }else{
            SCLAlertView().showInfo("Cuidado", subTitle: "Para continuar tienes que promediar.", animationStyle: .bottomToTop)
        }
    }
    func checkRecord(with id : Int32, name : String) {
        do {
            let request : NSFetchRequest<Student> = Student.fetchRequest()
            request.predicate = NSPredicate(format: "id == %d  OR name == %@", id, name)
            let numberOfRecords = try context.count(for: request)
            
            if numberOfRecords == 0 {
                saveStudent()
            }else{
                SCLAlertView().showInfo("Registro existente", subTitle: "El id o nombre ya fueron registrados. Por favor ingresa valores nuevos.", closeButtonTitle: "aceptar",animationStyle: .bottomToTop)
            }
        } catch {
            print("Error saving context \(error)")
        }
    }
    
    fileprivate func availableButtos() {
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
    
    fileprivate func validateAllInputs() -> Bool{
        var isOk = false
        if fieldName.text != "" && fieldSpanish.text != "" &&  fieldScience.text != "" && fieldMath.text != "" && fieldPhysical.text != ""  && fieldID.text != ""{
            isOk = true
        }
        return isOk
    }
    
    fileprivate func cleanView(){
        self.fieldID.text = ""
        self.fieldName.text = ""
        self.fieldSpanish.text = ""
        self.fieldScience.text = ""
        self.fieldMath.text = ""
        self.fieldPhysical.text = ""
        self.labelAverage.text = ""
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
}



