//
//  TeamWire.swift
//  OverWatchLeague
//
//  Created by LAVitor Pires on 02/10/20.
//

import Foundation

struct TeamWire: Codable {

    var name: String
    var abbreviatedName: String
    var location: String
    var logo: Logo

}

struct Logo: Codable {
    let main: LogoType
}

struct LogoType: Codable {
    let svg: String
    let png: String?
}
