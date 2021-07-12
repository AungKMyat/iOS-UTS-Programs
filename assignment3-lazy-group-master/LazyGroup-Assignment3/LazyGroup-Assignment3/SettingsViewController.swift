//
//  SettingsViewController.swift
//  LazyGroup-Assignment3
//
//  Created by Junghyun Eom on 22/5/21.
//  Assigned to Rina Yoo

import UIKit

class SettingsViewController: UIViewController {
    
    var calorieGoal = 0
    @IBOutlet weak var calorieGoalTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "goToMain"{
//            let VC = segue.destination as! MainViewController
//            VC.calorieGoal = Int(calorieGoalTextField.text!) ?? 0
//        }
//    }
    
    @IBAction func submit(_ sender: Any) {
        calorieGoal = Int(calorieGoalTextField.text!) ?? 0
        UserDefaults.standard.set(calorieGoal, forKey: "calorieDB")
        
        let vc = storyboard?.instantiateViewController(identifier: "MainViewController") as! MainViewController
        self.navigationController?.pushViewController(vc, animated: true)
        vc.navigationItem.setHidesBackButton(true, animated: true)
    }
    
}
