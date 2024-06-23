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
    
    @IBOutlet weak var fromCityTextField: UITextField!
    @IBOutlet weak var toCityTextField: UITextField!
    @IBOutlet weak var capacityLabel: UILabel!
    @IBOutlet weak var capacityStepper: UIStepper!
    @IBOutlet weak var outboundDatePicker: UIDatePicker!
    @IBOutlet weak var inboundDatePicker: UIDatePicker!
    @IBOutlet weak var inboundSwitch: UISwitch!
    @IBOutlet weak var numberOfPassengersLabel: UILabel!
    @IBOutlet weak var numberOfCrewLabel: UILabel!
    @IBOutlet weak var takeOffButton: UIButton! {
        didSet {
            takeOffButton.layer.cornerRadius = 10
        }
    }
    @IBOutlet weak var passengersView: UIView! {
        didSet {
            passengersView.layer.cornerRadius = 10
        }
    }
    @IBOutlet weak var crewView: UIView! {
        didSet {
            crewView.layer.cornerRadius = 10
        }
    }
    
    var flights: [Flight] = []
    
    var flightPassengers: [Passenger] = [] {
        didSet {
            numberOfPassengersLabel.text = "\(flightPassengers.count) passageiros(s) adicionados(s)"
        }
    }
    
    var flightCrew: [Any] = [] {
        didSet {
            numberOfCrewLabel.text = "\(flightCrew.count) tripulante(s) adicionado(s)"
        }
    }
    
    var delegate: FlightViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fromCityTextField.delegate = self
        toCityTextField.delegate = self
        
        capacityStepper.addTarget(self, action: #selector(stepperValueChanged(_:)), for: .valueChanged)
        
        inboundSwitch.addTarget(self, action: #selector(inboundSwitchChanged(_:)), for: .valueChanged)
        inboundSwitch.isOn = false
        updateInboundDatePicker()
        
        let passengersTapGesture = UITapGestureRecognizer(target: self, action: #selector(passengersViewTapped))
        passengersView.addGestureRecognizer(passengersTapGesture)
        
        
        let crewTapGesture = UITapGestureRecognizer(target: self, action: #selector(crewViewTapped))
        crewView.addGestureRecognizer(crewTapGesture)
    }
    
    @objc func stepperValueChanged(_ sender: UIStepper) {
        updateCapacityLabel()
    }
    
    func updateCapacityLabel() {
        capacityLabel.text = "Capacidade de \(Int(capacityStepper.value)) pessoas"
    }
    
    @objc func inboundSwitchChanged(_ sender: UISwitch) {
        updateInboundDatePicker()
    }
    
    func updateInboundDatePicker() {
        inboundDatePicker.isEnabled = !inboundSwitch.isOn
    }
    
    @objc func passengersViewTapped() {
        performSegue(withIdentifier: "showPassengers", sender: self)
    }
    
    @objc func crewViewTapped() {
        performSegue(withIdentifier: "showCrew", sender: self)
    }
    
    @IBAction func takeOff(_ sender: UIButton) {
        guard let fromCity = fromCityTextField.text, fromCity.count == 3 else {
            showAlert(message: "Por favor, preencha a cidade de origem em apenas 3 caracteres")
            return
        }
        
        guard let toCity = toCityTextField.text, toCity.count == 3 else {
            showAlert(message: "Por favor, preencha a cidade de destino em apenas 3 caracteres")
            return
        }
        
        let outboundDate = formatDate(date: outboundDatePicker.date)
        let inboundDate = inboundSwitch.isOn ? "" : formatDate(date: inboundDatePicker.date)
        
        
        let capacity = Int(capacityStepper.value)
        
        
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
        // MARK: popViewController só funciona se showAlert desativado
        //showAlert(message: "Embarque feito com sucesso")
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
    }
    
    func resetFields(){
        fromCityTextField.text = ""
        toCityTextField.text = ""
        capacityStepper.value = 0
        updateCapacityLabel()
        flightPassengers.removeAll()
        flightCrew.removeAll()
    }
    
    func formatDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.string(from: date)
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
    }
}


extension FlightViewController: CrewDelegate {
    func didAddCrew(crew: [Any]) {
        self.flightCrew = crew
    }
}

extension FlightViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else {return false}
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        return updatedText.count <= 3
    }
}
