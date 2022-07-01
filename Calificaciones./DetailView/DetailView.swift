//
//  DetailView.swift
//  Calificaciones.
//
//  Created by Leonardo Rubio on 15/06/22.
//

import UIKit

class DetailView: UIViewController {
    
    //MARK: - Outlets
    
    //Labels.
    @IBOutlet weak var labelID:UILabel!
    @IBOutlet weak var labelName:UILabel!
    @IBOutlet weak var labelSpanishScore:UILabel!
    @IBOutlet weak var labelSciencehScore:UILabel!
    @IBOutlet weak var labelMathScore:UILabel!
    @IBOutlet weak var labelPhysicalScore:UILabel!
    @IBOutlet weak var labelAverage:UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    //Views.
    @IBOutlet weak var viewFond:UIView!
    @IBOutlet weak var stackViewFond:UIView!
    
    public var student:Student!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.labelID.customLabel()
        self.labelName.customLabel()
        self.labelSpanishScore.customLabel()
        self.labelSciencehScore.customLabel()
        self.labelMathScore.customLabel()
        self.labelPhysicalScore.customLabel()
        self.labelAverage.customLabel()
        self.stackViewFond.addShadow()
        self.viewFond.addGradient()
        self.titleLabel.customLabel()
        
        fillLabels(student: self.student)
    }
    
    //MARK: - Methods
    
    private func fillLabels(student:Student){
        self.labelID.text = "\(student.id)"
        self.labelName.text = " " + student.name!
        self.labelSpanishScore.text = " \(student.spanish)"
        self.labelSciencehScore.text = " \(student.science)"
        self.labelMathScore.text = " \(student.math)"
        self.labelPhysicalScore.text = " \(student.physical)"
        self.labelAverage.text = " \(String(format: "%.1f", student.average))"
    }
    
}

