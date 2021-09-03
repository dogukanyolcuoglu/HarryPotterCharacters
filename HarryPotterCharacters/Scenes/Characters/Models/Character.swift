//
//  Character.swift
//  HarryPotterCharacters
//
//  Created by Dogukan Yolcuoglu on 27.07.2021.
//

import Foundation

struct Character : Codable {
    
    let name : String
    let species : String
    let image : String
    let gender : String
    let dateOfBirth : String
    let wand : Wand
}

struct Wand : Codable {
    let wood : String
    let core : String
}
