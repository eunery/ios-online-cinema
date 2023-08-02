//
//  Dynamic.swift
//  ios-online-cinema
//
//  Created by Sergei Kulagin on 01.08.2023.
//

import Foundation

class Dynamic<T> {
    
    typealias Listener = (T) -> Void
    var listener = Array<Listener?>()

    var value: T {
        didSet {
            DispatchQueue.main.async {
                self.listener.forEach { (listener) in
                    listener?(self.value)
                }
            }
        }
    }

    init(_ v: T) {
        value = v
    }
    
    func bind(listener: Listener?) {
        self.listener.append(listener)
    }

    func bindAndFire(listener: Listener?) {
        self.listener.append(listener)
        listener?(value)
    }
}
