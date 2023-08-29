//
//  Movie+CoreDataClass.swift
//  ios-online-cinema
//
//  Created by Sergei Kulagin on 28.08.2023.
//
//

import Foundation
import CoreData

@objc(Movie)
public class Movie: NSManagedObject {
    
    @NSManaged public var id: Int
    @NSManaged public var poster: String
    @NSManaged public var genres: String
    @NSManaged public var vote: String
    @NSManaged public var releaseDate: String
    @NSManaged public var title: String
    @NSManaged public var overview: String
}
