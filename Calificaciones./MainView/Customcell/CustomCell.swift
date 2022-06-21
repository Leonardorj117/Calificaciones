//
//  CustomCell.swift
//  Calificaciones.
//
//  Created by Leonardo Rubio on 15/06/22.
//

import UIKit

class CustomCell: UITableViewCell {

    @IBOutlet weak var labelName:UILabel!
    @IBOutlet weak var labelAverage:UILabel!
    
    func fillCell(student:Student){
        self.labelName.text = student.name
        self.labelAverage.text = "Promedio: \(String(format: "%.1f", student.average))"
    }
}
