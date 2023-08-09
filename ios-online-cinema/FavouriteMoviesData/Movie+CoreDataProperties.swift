//
//  Movie+CoreDataProperties.swift
//  ios-online-cinema
//
//  Created by Sergei Kulagin on 02.08.2023.
//
//

import Foundation
import CoreData


extension Movie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Movie> {
        return NSFetchRequest<Movie>(entityName: "Movie")
    }

    @NSManaged public var id: Int64

}

extension Movie : Identifiable {

}
