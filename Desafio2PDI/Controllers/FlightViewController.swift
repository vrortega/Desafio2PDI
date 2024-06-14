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
    
    var flights: [Flight] = []
    
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
        guard let fromCity = fromCityTf.text, !fromCity.isEmpty else {
            showAlert(message: "Por favor, preencha a cidade de origem")
            return
        }
        
        guard let toCity = toCityTf.text, !toCity.isEmpty else {
            showAlert(message: "Por favor, preencha a cidade de destino")
            return
        }
        
        guard let outboundDate = outboundDateTf.text, !outboundDate.isEmpty else {
            showAlert(message: "Por favor, preencha a data de ida")
            return
        }
        
        guard let inboundDate = inboundDateTf.text, !inboundDate.isEmpty else {
            showAlert(message: "Por favor, preencha a data de volta")
            return
        }
        
        guard let capacityText = capacityTf.text, !capacityText.isEmpty, let capacity = Int(capacityText) else {
            showAlert(message: "Por favor, preencha a capacidade do voo")
            return
        }
    
        var pilotCount = 0
        var coPilotCount = 0
        var flightAttendantCount = 0
        
        for crewMember in flightCrew {
            if crewMember is Pilot {
                pilotCount += 1
            } else if crewMember is coPilot {
                coPilotCount += 1
            } else if crewMember is FlightAttendant {
                flightAttendantCount += 1
            }
        }
        
        if pilotCount != 1 {
            showAlert(message: "É necessário ter exatamente 1 piloto")
            return
        }
        
        if coPilotCount != 1 {
            showAlert(message: "É necessário ter exatamente 1 co-piloto")
            return
        }
        
        if flightAttendantCount > 3 {
            showAlert(message: "O voo só pode ter 3 comissários")
            return
        }
        
        
        let totalPeople = flightPassengers.count + flightCrew.count
        if totalPeople > capacity {
            showAlert(message: "A capacidade do voo foi excedida")
            return
        }
        
        
        let flight = Flight(fromCity: fromCity, toCity: toCity, outboundDate: outboundDate, inboundDate: inboundDate, capacity: capacity, passengers: flightPassengers, crew: flightCrew)
        flights.append(flight)
        
        showAlert(message: "Embarque feito com sucesso")
        resetFields()
        
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
    
    func resetFields(){
        fromCityTf.text = ""
        toCityTf.text = ""
        outboundDateTf.text = ""
        inboundDateTf.text = ""
        capacityTf.text = ""
        flightPassengers.removeAll()
        flightCrew.removeAll()
        
    }
    
    func showAlert(message: String){
        let alert = UIAlertController(title: "Alerta", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
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

