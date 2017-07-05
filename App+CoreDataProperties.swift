//
//  App+CoreDataProperties.swift
//  
//
//  Created by Michael Nienaber on 7/1/17.
//
//

import Foundation
import CoreData


extension App {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<App> {
        return NSFetchRequest<App>(entityName: "App")
    }

    @NSManaged public var rating: Double
    @NSManaged public var appName: String?
    @NSManaged public var devName: String?
    @NSManaged public var image: NSData?
    @NSManaged public var price: String?
    @NSManaged public var descriptionText: String?
    @NSManaged public var fileSize: Double
}
