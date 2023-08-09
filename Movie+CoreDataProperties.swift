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

    @NSManaged public var id: Int16
//    @NSManaged public var adult: Bool
//    @NSManaged public var backdrop_path: String?
//    @NSManaged public var title: String?
//    @NSManaged public var original_language: String?
//    @NSManaged public var overview: String?
//    @NSManaged public var poster_path: String?
//    @NSManaged public var media_type: String?
//    @NSManaged public var popularity: Double
//    @NSManaged public var release_date: String?
//    @NSManaged public var video: Bool
//    @NSManaged public var vote_average: Double
//    @NSManaged public var vote_count: Int16

}

extension Movie : Identifiable {

}
