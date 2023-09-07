//
//  FavouriteMovieMO.swift
//  ios-online-cinema
//
//  Created by Sergei Kulagin on 28.08.2023.
//
//

import Foundation
import CoreData

@objc(FavouriteMovieMO)
public class FavouriteMovieMO: NSManagedObject {
    
    public static let identifier = "FavouriteMovieMO"
    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavouriteMovieMO> {
        return NSFetchRequest<FavouriteMovieMO>(entityName: "FavouriteMovieMO")
    }
    
    @NSManaged public var id: Int
    @NSManaged public var poster: String
    @NSManaged public var genres: String
    @NSManaged public var vote: String
    @NSManaged public var releaseDate: String
    @NSManaged public var title: String
    @NSManaged public var overview: String
}
