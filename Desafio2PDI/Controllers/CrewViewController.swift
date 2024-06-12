//
//  CrewViewController.swift
//  Desafio2PDI
//
//  Created by Vitoria Ortega on 10/06/24.
//

import UIKit

class CrewViewController: UIViewController {
    @IBOutlet weak var CrewTypeSc: UISegmentedControl!
    @IBOutlet weak var nameTf: UITextField!
    @IBOutlet weak var experienceLb: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var experienceStepper: UIStepper!
    

    var experienceYears: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // configuracao inicial 
        initializeComponents()
        
        // adiciona acao para o segmentedcontrol e uistepper
        CrewTypeSc.addTarget(self, action: #selector(segmentChanged(_:)), for: .valueChanged)
        experienceStepper.addTarget(self, action: #selector(stepperChanged(_:)), for: .valueChanged)
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
        }

    }

