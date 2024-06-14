//
//  Flight.swift
//  Desafio2PDI
//
//  Created by Vitoria Ortega on 13/06/24.
//

import Foundation

struct Flight {
    let fromCity: String
    let toCity: String
    let outboundDate: String
    let inboundDate: String
    let capacity: Int
    let passengers: [Passenger]
    let crew: [Any]
}
