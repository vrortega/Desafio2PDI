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
    
    var flightPassengers: [Passenger] = [] {
        didSet {
            numberOfPassengersLb.text = "\(flightPassengers.count) passageiros(s) adicionados(s)"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        numberOfPassengersLb.text = "Nenhum passageiro adicionado"

    }
    
    @IBAction func takeOff(_ sender: UIButton) {
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPassengers", let passengersVC = segue.destination as? PassengersViewController {
            passengersVC.delegate = self
            // passa os passageiros atuais para a próxima tela
            passengersVC.passengers = flightPassengers
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("Passageiros ao retornar: \(flightPassengers)")
    }
    
}

extension FlightViewController: PassengersDelegate {
    func didAddPassengers(_ passengers: [Passenger]) {
        self.flightPassengers = passengers
        print ("Passageiros: \(flightPassengers)")
    }
}
