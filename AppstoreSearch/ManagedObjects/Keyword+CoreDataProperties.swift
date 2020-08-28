//
//  Keyword+CoreDataProperties.swift
//  
//
//  Created by Eido Goya on 2020/08/28.
//
//

import Foundation
import CoreData


extension Keyword {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Keyword> {
        return NSFetchRequest<Keyword>(entityName: "Keyword")
    }

    @NSManaged public var title: String?
    @NSManaged public var timeStamp: Date?
    @NSManaged public var score: Int16

}
