//
//  PassengersViewController.swift
//  Desafio2PDI
//
//  Created by Vitoria Ortega on 10/06/24.
//

import UIKit

class PassengersViewController: UIViewController {

    @IBOutlet weak var nameTf: UITextField!
    @IBOutlet weak var ageTf: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func board(_ sender: UIButton) {
            print("Botao embarcar pressionado")
        
        // validacao do nome
        guard let name = nameTf.text, !name.isEmpty else {
            showAlert(message: "Por favor, preencha o nome")
            return
        }
        // validacao da idade
        guard let ageText = ageTf.text, !ageText.isEmpty, let age = Int(ageText) else {
            showAlert(message: "Por favor, preencha uma idade válida")
            return
        }
        // logica para permitir embarque do passageiro
        let passenger = Passenger(name: name, age: age)
        if passenger.isAdult() {
            print("\(passenger.name) pode embarcar")
            showAlert(message: "\(passenger.name) pode embarcar")
        } else {
            showAlert(message: "\(passenger.name) nao pode embarcar porque é menor de idade")
        }
    }
    // montagem do alerta
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Alerta", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
