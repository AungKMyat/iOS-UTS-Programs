//
//  RegiViewController.swift
//  LazyGroup-Assignment3
//
//  Created by Junghyun Eom on 22/5/21.
//

import UIKit

class RegiViewController: UIViewController {

    @IBOutlet weak var userNameLabel: UITextField!
    var userName: String = "";
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        
    }
    
    @IBAction func submit(_ sender: Any)
    {
        userName = userNameLabel.text!
        UserDefaults.standard.set(userName, forKey: "DB")
        
        
        
        let vc = storyboard?.instantiateViewController(identifier: "MainViewController") as! MainViewController
        self.navigationController?.pushViewController(vc, animated: true)
        vc.navigationItem.setHidesBackButton(true, animated: true)
    }
    
    
    
    



}
