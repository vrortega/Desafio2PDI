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
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noPassangersLabel: UILabel!
    @IBOutlet weak var toBoardButton: UIButton! {
        didSet {
            toBoardButton.layer.cornerRadius = 10
        }
    }
    
    var passengers: [Passenger] = []
    weak var delegate: PassengersDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        updateView()
        
        // ao clicar na tela, esconde o teclado
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyBoard))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func hideKeyBoard() {
        view.endEditing(true)
    }
    
    @IBAction func board(_ sender: UIButton) {
        hideKeyBoard()
        guard let name = nameTextField.text, !name.isEmpty else {
            showAlert(message: "Por favor, preencha o nome")
            return
        }
        guard let ageText = ageTextField.text, !ageText.isEmpty, let age = Int(ageText) else {
            showAlert(message: "Por favor, preencha uma idade válida")
            return
        }
        let passenger = Passenger(name: name, age: age)
        if passenger.isAdult() {
            passengers.append(passenger)
            tableView.reloadData()
            nameTextField.text = ""
            ageTextField.text = ""
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
    
    func updateView(){
        if passengers.isEmpty {
            tableView.isHidden = true
            noPassangersLabel.isHidden = false
        } else {
            tableView.isHidden = false
            noPassangersLabel.isHidden = true
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
    // deleta passenger na tableview
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            passengers.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            updateView()
         }
    }
}
