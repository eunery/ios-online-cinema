//
//  ProximaNovaFont.swift
//  ios-online-cinema
//
//  Created by Sergei Kulagin on 05.08.2023.
//

import Foundation
import UIKit

struct ProximaNovaFont {
    enum FontType: String {
        case regular = "ProximaNova-Regular"
        case light = "ProximaNova-Light"
        case bold = "ProximaNova-Bold"
        case boldItalic = "ProximaNova-BoldIt"
        case extraBold = "ProximaNova-ExtraBold"
        case black = "ProximaNova-Black"
        case blackItalic = "ProximaNova-BlackIt"
    }
    static func font(type: FontType, size: CGFloat) -> UIFont {
        return UIFont(name: type.rawValue, size: size)!
    }
}
