//
//  FlightViewController.swift
//  Desafio2PDI
//
//  Created by Vitoria Ortega on 10/06/24.
//

import UIKit

protocol FlightViewControllerDelegate {
    func didAddFlight(flight: Flight)
}

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
    
    var delegate: FlightViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fromCityTf.delegate = self
        toCityTf.delegate = self
    }
    
    @IBAction func takeOff(_ sender: UIButton) {
        guard let fromCity = fromCityTf.text, fromCity.count == 3 else {
            showAlert(message: "Por favor, preencha a cidade de origem em apenas 3 caracteres")
            return
        }

        guard let toCity = toCityTf.text, toCity.count == 3 else {
            showAlert(message: "Por favor, preencha a cidade de destino em apenas 3 caracteres")
            return
        }

        guard let outboundDate = outboundDateTf.text, !outboundDate.isEmpty else {
            showAlert(message: "Por favor, preencha a data de ida")
            return
        }

       let inboundDate = inboundDateTf.text!


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

        delegate?.didAddFlight(flight: flight)

        showAlert(message: "Embarque feito com sucesso")
        resetFields()

        self.navigationController?.popViewController(animated: true)
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

extension FlightViewController: UITextFieldDelegate {
    func textfield(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else {return false}
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        return updatedText.count <= 3
    }
}
