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
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noPassangersLb: UILabel!
    
    var passengers: [Passenger] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        updateView()
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
            passengers.append(passenger)
            tableView.reloadData()
            updateView()
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
    
    
    func updateView(){
        if passengers.isEmpty {
            tableView.isHidden = true
            noPassangersLb.isHidden = false
        } else {
            tableView.isHidden = false
            noPassangersLb.isHidden = true
        }
    }
}

extension PassengersViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return passengers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let passenger = passengers[indexPath.row]
        cell.textLabel?.text = passenger.name
        cell.detailTextLabel?.text = "Idade \(passenger.age)"
        return cell
    }
    
    // Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let passenger = passengers[indexPath.row]
        print("\(passenger.name) selecionado")
    }
}
