//
//  Student+CoreDataProperties.swift
//  Calificaciones.
//
//  Created by Leonardo Rubio on 16/06/22.
//
//

import Foundation
import CoreData


extension Student {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Student> {
        return NSFetchRequest<Student>(entityName: "Student")
    }

    @NSManaged public var name: String?
    @NSManaged public var spanish: Double
    @NSManaged public var science: Double
    @NSManaged public var math: Double
    @NSManaged public var physical: Double
    @NSManaged public var average: Double

}

extension Student : Identifiable {

}
