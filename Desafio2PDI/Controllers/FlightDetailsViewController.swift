//
//  FlightDetailsViewController.swift
//  Desafio2PDI
//
//  Created by Vitoria Ortega on 16/06/24.
//

import UIKit

class FlightDetailsViewController: UIViewController {
    @IBOutlet weak var fromCity: UILabel!
    @IBOutlet weak var toCity: UILabel!
    @IBOutlet weak var outboundDate: UILabel!
    @IBOutlet weak var inboundDate: UILabel!
    @IBOutlet weak var capacity: UILabel!
    @IBOutlet weak var pilot: UILabel!
    @IBOutlet weak var coPilot: UILabel!
    @IBOutlet weak var passengers: UILabel!
    @IBOutlet weak var flightAttendant: UILabel!
    
    var flight: Flight?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        
    }
    
    func updateUI() {
        guard let flight = flight else { return }
        
        fromCity.text = "\(flight.fromCity)"
        toCity.text = "\(flight.toCity)"
        outboundDate.text = "\(flight.outboundDate)"
        inboundDate.text = "\(flight.inboundDate)"
        capacity.text = "Passageiros | Capacidade: \(flight.capacity)"
        
        let passengersText = flight.passengers.map{ $0.name }.joined(separator: ", ")
        passengers.text = "\(passengersText)"
        
        var pilotText = "Piloto: nao disponivel"
        var coPilotText = "Co-Piloto: nao disponivel"
        var flightAttendantsText = "Comissário: nao disponivel"
        
        var flightAttendants: [String] = []
        
        for crewMember in flight.crew {
            if let pilot = crewMember as? Pilot {
                pilotText = "\(pilot.name) - Piloto"
            } else if let coPilot = crewMember as? coPilot {
                coPilotText = "\(coPilot.name) - Co-Piloto"
            } else if let flightAttendant = crewMember as? FlightAttendant {
                flightAttendants.append(flightAttendant.name)
            }
        }
        if !flightAttendants.isEmpty {
            flightAttendantsText = "Comissários: \(flightAttendants.joined(separator: ", "))"
            
            
        }
        
        pilot.text = pilotText
        coPilot.text = coPilotText
        flightAttendant.text = flightAttendantsText
        
    }
    
}
