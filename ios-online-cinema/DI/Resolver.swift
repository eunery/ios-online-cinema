//
//  Resolver.swift
//  ios-online-cinema
//
//  Created by Sergei Kulagin on 29.09.2023.
//

import Foundation
import Resolver

extension Resolver: ResolverRegistering {
    public static func registerAllServices() {
        register { CoreDataManager() }
            .scope(.application)
        register { NetworkWorker() }
            .implements(NetworkWorkerProtocol.self)
        register { APIService() }
            .implements(APIServiceProtocol.self)
        register { APIRepository() }
            .implements(APIRepositoryProtocol.self)
    }
}
