//
//  Student+CoreDataProperties.swift
//  
//
//  Created by Leonardo Rubio on 24/06/22.
//
//

import Foundation
import CoreData


extension Student {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Student> {
        return NSFetchRequest<Student>(entityName: "Student")
    }

    @NSManaged public var average: Double
    @NSManaged public var math: Double
    @NSManaged public var name: String?
    @NSManaged public var physical: Double
    @NSManaged public var science: Double
    @NSManaged public var spanish: Double
    @NSManaged public var id: Int32

}
