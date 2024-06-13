//
//  CrewViewController.swift
//  Desafio2PDI
//
//  Created by Vitoria Ortega on 10/06/24.
//

import UIKit

protocol CrewDelegate: AnyObject {
    func didAddCrew(crew: [Any])
}

class CrewViewController: UIViewController {
    @IBOutlet weak var CrewTypeSc: UISegmentedControl!
    @IBOutlet weak var nameTf: UITextField!
    @IBOutlet weak var experienceLb: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var experienceStepper: UIStepper!
    @IBOutlet weak var noCrewLb: UILabel!
    
    var experienceYears: Int = 0
    var crewMembers: [Any] = [] {
        didSet {
            if isViewLoaded {
                updateView()
            }
        }
    }
    
    weak var delegate: CrewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
       
        
        
        // configuracao inicial
        initializeComponents()
        
        // adiciona acao para o segmentedcontrol e uistepper
        CrewTypeSc.addTarget(self, action: #selector(segmentChanged(_:)), for: .valueChanged)
        experienceStepper.addTarget(self, action: #selector(stepperChanged(_:)), for: .valueChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateView()
    }
    
    
    
    func initializeComponents() {
        experienceLb.text = "Experiencia: \(experienceYears) anos"
        experienceStepper.isEnabled = true
        experienceLb.isEnabled = true
    }
    
    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            experienceLb.isEnabled = true
            experienceStepper.isEnabled = true
            updateExperienceLabel()
        } else {
            experienceLb.isEnabled = false
            experienceStepper.isEnabled = false
            experienceLb.text = "Experiencia minima nao requerida"
        }
    }
    
    func updateExperienceLabel() {
        if CrewTypeSc.selectedSegmentIndex == 0 {
            experienceLb.text = "Experiencia: \(experienceYears) anos"
        } else {
            experienceLb.text = "Experiencia minima nao requerida"
        }
    }
    
    @IBAction func stepperChanged(_ sender: UIStepper) {
        experienceYears = Int(sender.value)
        updateExperienceLabel()
    }
    
        @IBAction func board(_ sender: UIButton) {
            guard let name = nameTf.text, !name.isEmpty else {
                showAlert(message: "Por favor, preencha o nome")
                return
            }
            if CrewTypeSc.selectedSegmentIndex == 0 {
                let pilot = Pilot(name: name, experience: experienceYears)
                if pilot.isPilot() {
                    crewMembers.append(pilot)
                    print("Piloto \(pilot.name) foi adicionado com \(pilot.experience) anos de experiencia")
                } else {
                    let coPilot = coPilot(name: name, experience: experienceYears)
                    crewMembers.append(coPilot)
                    print("Co-piloto \(coPilot.name) adicionado com \(coPilot.experience) anos de experiencia")
                }
            } else {
                let flightAttendant = FlightAttendant(name: name)
                crewMembers.append(flightAttendant)
                print("Comissario \(name) adicionado")
            }
            
            tableView.reloadData()
            nameTf.text = ""
            experienceStepper.value = 0
            experienceYears = 0
            updateExperienceLabel()
            
            delegate?.didAddCrew(crew: crewMembers)
        
        }
    
    func showAlert(message: String){
        let alert = UIAlertController(title: "Alerta", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func updateView() {
        if crewMembers.isEmpty {
            tableView.isHidden = true
            noCrewLb.isHidden = true
        } else {
            tableView.isHidden = false
            noCrewLb.isHidden = false
        }
    }

    }

extension CrewViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return crewMembers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "crewMembersCell", for: indexPath)
        
        
        if let pilot = crewMembers[indexPath.row] as? Pilot {
            cell.textLabel?.text = "\(pilot.name)"
            cell.detailTextLabel?.text = "Piloto"
        } else if let coPilot = crewMembers[indexPath.row] as? coPilot {
            cell.textLabel?.text = "\(coPilot.name)"
            cell.detailTextLabel?.text = "Co-Piloto"
        } else if let flightAttendant = crewMembers[indexPath.row] as? FlightAttendant {
            cell.textLabel?.text = flightAttendant.name
            cell.detailTextLabel?.text = "Comissário"
        }
        return cell
    }
    
}

extension CrewViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let crewMember = crewMembers[indexPath.row]
        print("\(crewMembers) selecionado")
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            crewMembers.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            updateView()
            delegate?.didAddCrew(crew: crewMembers)
        }
    }
}
