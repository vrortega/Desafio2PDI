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
    @IBOutlet var allPassengers: [UILabel]!
    @IBOutlet weak var pilot: UILabel!
    @IBOutlet weak var coPilot: UILabel!
    @IBOutlet var allFlightAttendants: [UILabel]!
    
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
    }
    
}
