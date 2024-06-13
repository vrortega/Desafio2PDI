//
//  Pilot.swift
//  Desafio2PDI
//
//  Created by Vitoria Ortega on 12/06/24.
//

import Foundation

struct Pilot {
    let name: String
    let experience: Int
    
    init(name: String, experience: Int) {
        self.name = name
        self.experience = experience
    }
    
    func isPilot() -> Bool {
        return experience > 5
    }
}

struct coPilot {
    let name: String
    let experience: Int
    
    init(name: String, experience: Int) {
        self.name = name
        self.experience = experience
    }
}
