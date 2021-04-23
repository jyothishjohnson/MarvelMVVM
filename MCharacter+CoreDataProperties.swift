//
//  MCharacter+CoreDataProperties.swift
//  
//
//  Created by jyothish.johnson on 23/04/21.
//
//

import Foundation
import CoreData


extension MCharacter {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MCharacter> {
        return NSFetchRequest<MCharacter>(entityName: "MCharacter")
    }

    @NSManaged public var id: Int64
    @NSManaged public var name: String?
    @NSManaged public var imageURL: String?

}
