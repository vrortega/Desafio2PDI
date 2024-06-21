//
//  FlightDetailsViewController.swift
//  Desafio2PDI
//
//  Created by Vitoria Ortega on 16/06/24.
//

import UIKit

class FlightDetailsViewController: UIViewController {
    @IBOutlet weak var fromCityLabel: UILabel!
    @IBOutlet weak var toCityLabel: UILabel!
    @IBOutlet weak var outboundDateLabel: UILabel!
    @IBOutlet weak var inboundDateLabel: UILabel!
    @IBOutlet weak var capacityLabel: UILabel!
    @IBOutlet weak var pilotLabel: UILabel!
    @IBOutlet weak var coPilotLabel: UILabel!
    @IBOutlet weak var passengersLabel: UILabel!
    @IBOutlet weak var flightAttendantLabel: UILabel!
    @IBOutlet weak var detailsDestinationView: UIView! {
        didSet {
            detailsDestinationView.layer.cornerRadius = 10
        }
    }
    @IBOutlet weak var detailsPassengersView: UIView! {
        didSet {
            detailsPassengersView.layer.cornerRadius = 10
        }
    }
    @IBOutlet weak var crewView: UIView! {
        didSet {
            crewView.layer.cornerRadius = 10
        }
    }
    
    var flight: Flight?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    func updateUI() {
        guard let flight = flight else { return }
        
        fromCityLabel.text = "\(flight.fromCity)"
        toCityLabel.text = "\(flight.toCity)"
        outboundDateLabel.text = "Ida:\(flight.outboundDate)"
        inboundDateLabel.text = "Volta: \(flight.inboundDate)"
        capacityLabel.text = "Passageiros | Capacidade: \(flight.capacity)"
        
        let passengersText = flight.passengers.map { $0.name }.joined(separator: "\n")
        passengersLabel.text = passengersText
        
        var pilotText = "Piloto: nao disponivel"
        var coPilotText = "Co-Piloto: nao disponivel"
        
        for crewMember in flight.crew {
            if let pilot = crewMember as? Pilot {
                pilotText = "\(pilot.name) - Piloto"
            } else if let coPilot = crewMember as? coPilot {
                coPilotText = "\(coPilot.name) - Co-Piloto"
            }
            
            let flightAttendantsText = flight.crew
                .compactMap { $0 as? FlightAttendant }
                .map { "\( $0.name ) - Comissário"}
                .joined(separator: "\n")
            
            pilotLabel.text = pilotText
            coPilotLabel.text = coPilotText
            flightAttendantLabel.text = flightAttendantsText
        }
    }
}
