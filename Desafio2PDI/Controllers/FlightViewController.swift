//
//  FlightViewController.swift
//  Desafio2PDI
//
//  Created by Vitoria Ortega on 10/06/24.
//

import UIKit

class FlightViewController: UIViewController {

    @IBOutlet weak var fromCityTf: UITextField!
    @IBOutlet weak var toCityTf: UITextField!
    @IBOutlet weak var outboundDateTf: UITextField!
    @IBOutlet weak var inboundDateTf: UITextField!
    @IBOutlet weak var capacityTf: UITextField!
    @IBOutlet weak var numberOfPassengersLb: UILabel!
    @IBOutlet weak var numberOfCrewLb: UILabel!
    
    var flightPassengers: [Passenger] = [] {
        didSet {
            numberOfPassengersLb.text = "\(flightPassengers.count) passageiros(s) adicionados(s)"
        }
    }
    
    var flightCrew: [Any] = [] {
        didSet {
            numberOfCrewLb.text = "\(flightCrew.count) tripulante(s) adicionado(s)"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func takeOff(_ sender: UIButton) {
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPassengers", let passengersVC = segue.destination as? PassengersViewController {
            passengersVC.delegate = self
            passengersVC.passengers = flightPassengers
        }
        if segue.identifier == "showCrew", let crewVC = segue.destination as? CrewViewController {
            crewVC.delegate = self
            crewVC.crewMembers = flightCrew
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("Passageiros ao retornar: \(flightPassengers)")
        print("Tripulantes ao retornar: \(flightCrew)")
    }
    
}

extension FlightViewController: PassengersDelegate {
    func didAddPassengers(_ passengers: [Passenger]) {
        self.flightPassengers = passengers
        print ("Passageiros: \(flightPassengers)")
    }
}


extension FlightViewController: CrewDelegate {
    func didAddCrew(crew: [Any]) {
        self.flightCrew = crew
       
    }
}
