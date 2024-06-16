//
//  ViewController.swift
//  Desafio2PDI
//
//  Created by Vitoria Ortega on 10/06/24.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var noFlight: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var flights: [Flight] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        updateNoFlightLabel()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "FlightCell")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowFlight", let flightVC = segue.destination as? FlightViewController {
            flightVC.delegate = self
        }
    }
    
    func updateNoFlightLabel(){
        noFlight.isHidden = !flights.isEmpty
        tableView.isHidden = flights.isEmpty
    }
}


extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return flights.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FlightCell", for: indexPath)
        let flight = flights[indexPath.row]        
        cell.textLabel?.text = "\(flight.fromCity) - \(flight.toCity)"
        cell.detailTextLabel?.text = "Ida: \(flight.inboundDate) - Volta: \(flight.outboundDate) | \(flight.capacity) passageiro(s)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            flights.remove(at: indexPath.row)
            updateNoFlightLabel()
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}

extension ViewController: UITableViewDelegate {
    
    
}

extension ViewController: FlightViewControllerDelegate {
    func didAddFlight(flight: Flight) {
        flights.append(flight)
        tableView.reloadData()
        updateNoFlightLabel()
    }
}
