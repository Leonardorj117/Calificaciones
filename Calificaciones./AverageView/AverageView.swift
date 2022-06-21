//
//  AverageView.swift
//  Calificaciones.
//
//  Created by Leonardo Rubio on 15/06/22.
//

import UIKit
import SCLAlertView

class AverageView: UIViewController {
    
    //MARK: - Outlets
    
    //Labels
    @IBOutlet weak var labelGroupAverage:UILabel!
    @IBOutlet weak var labelApproved:UILabel!
    @IBOutlet weak var labelNoApproved:UILabel!
    @IBOutlet weak var labelPorcentageApproved:UILabel!
    @IBOutlet weak var labelPorcentageNoApproved:UILabel!
    @IBOutlet weak var labelGreaterThan:UILabel!
    @IBOutlet weak var labelSmallerThan:UILabel!
    @IBOutlet weak var labelTitle:UILabel!
    @IBOutlet weak var labelTitle2:UILabel!
    @IBOutlet weak var labelTitle3:UILabel!
    
    //View
    @IBOutlet weak var firsView:UIView!
    @IBOutlet weak var secondView:UIView!
    @IBOutlet weak var thirdView:UIView!
    
    //MARK: - Private
    
    private let detail = DetailView()
    private let mainView = ViewController()
    private var arrayStudents = [Student]()
    private var arrayRatings  = [Double]()
    private var arrayAddition = [Double]()
    private var arrayApproved = [Double]()
    private var arrayNoApproved = [Double]()
    private var greaterThan8 = [Double]()
    private var lessThan8 = [Double]()
    private var average:Double = Double()
    private var porcentageApproved:Double = Double()
    private var porcentageNoApproved:Double = Double()
    private var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.labelGroupAverage.customLabel()
        self.labelApproved.customLabel()
        self.labelNoApproved.customLabel()
        self.labelPorcentageApproved.customLabel()
        self.labelPorcentageNoApproved.customLabel()
        self.labelGreaterThan.customLabel()
        self.labelSmallerThan.customLabel()
        self.firsView.addShadow()
        self.secondView.addShadow()
        self.thirdView.addShadow()
        recuperarDatos()
        for element in self.arrayStudents{
            self.arrayRatings.append(element.average)
        }
        self.average = calculateAverage(ary: self.arrayRatings)
        fillLabels()
        
    }
    
    //MARK: - Private Functions
    
    private func recuperarDatos(){
        do{
            try self.arrayStudents = self.context.fetch(Student.fetchRequest())
        }catch{
            SCLAlertView().showError("Error", subTitle: "Error al eliminar el elemento.", closeButtonTitle: "Aceptar", animationStyle: .bottomToTop)
        }
    }
    
    private func calculateAverage(ary:[Double]) -> Double{
        var addition:Double = Double()
        var totalApproved:Double = Double()
        var totalNoApproved:Double = Double()
        for item in ary{
            addition += item
            if item > 6.0 && item <= 10.0{
                self.arrayApproved.append(item)
            }else{
                self.arrayNoApproved.append(item)
            }
            if item >= 8 && item <= 10.0{
                self.greaterThan8.append(item)
            }
            if item <= 7{
                self.lessThan8.append(item)
            }
        }
        let avg = addition / Double(self.arrayRatings.count)
        for element in self.arrayApproved{
            totalApproved += element
        }
        for element in self.arrayNoApproved{
            totalNoApproved += element
        }
        self.porcentageApproved = (totalApproved * 100) / addition
        self.porcentageNoApproved = (totalNoApproved * 100) / addition
        return avg
    }
    private func fillLabels(){
        self.labelGroupAverage.text = " Promedio general : \(String(format: "%.2f", self.average))."
        self.labelApproved.text = " Aprobados : \(self.arrayApproved.count)."
        self.labelNoApproved.text = " No Aprobados : \(self.arrayNoApproved.count)."
        self.labelPorcentageApproved.text = " Aprobados : \(String(format: "%.1f", self.porcentageApproved)) %."
        self.labelPorcentageNoApproved.text = "No aprobados : \(String(format: "%.1f", self.porcentageNoApproved)) %."
        self.labelGreaterThan.text = " Mayor a 8 : \(self.greaterThan8.count)."
        self.labelSmallerThan.text = " Menor a 8 : \(self.lessThan8.count)."
    }
    
}
