//
//  PassengersViewController.swift
//  Desafio2PDI
//
//  Created by Vitoria Ortega on 10/06/24.
//

import UIKit

protocol PassengersDelegate: AnyObject {
    func didAddPassengers(_ passengers: [Passenger])
}

class PassengersViewController: UIViewController {
    
    @IBOutlet weak var nameTf: UITextField!
    @IBOutlet weak var ageTf: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noPassangersLb: UILabel!
    
    var passengers: [Passenger] = []
    weak var delegate: PassengersDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        updateView()
    }
    
    @IBAction func board(_ sender: UIButton) {
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
            nameTf.text = ""
            ageTf.text = ""
            updateView()
        } else {
            showAlert(message: "\(passenger.name) nao pode embarcar porque é menor de idade")
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        delegate?.didAddPassengers(passengers)
    }
    
    // montagem do alerta
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Alerta", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    // se a lista de passageiros estiver vazia mostra label, se nao a tableview de passengers
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

extension PassengersViewController: UITableViewDataSource {
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
    
}


extension PassengersViewController: UITableViewDelegate {
    
    // Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let passenger = passengers[indexPath.row]
        print("\(passenger.name) selecionado")
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            passengers.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            updateView()
            delegate?.didAddPassengers(passengers)
        }
    }
}
