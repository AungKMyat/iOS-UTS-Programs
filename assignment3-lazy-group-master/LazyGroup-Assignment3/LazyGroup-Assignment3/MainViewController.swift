//
//  MainViewController.swift
//  LazyGroup-Assignment3
//
//  Created by Junghyun Eom on 22/5/21.
//  Assigned feature a, and d to Rina Yoo

import UIKit

class MainViewController: UIViewController {
    

    
    var calorieGoal = 0
    var userName: String = ""
    var breakfastName: String = "";
    var breakfastCal: Int = 0
    var lunchName: String = "";
    var lunchCal: Int = 0
    var dinnerName: String = "";
    var dinnerCal: Int = 0
    var minusCal: Int = 0
    
    var calIdentify: Int = 0
    
    @IBOutlet weak var breakFastFoodLabel: UILabel!
    @IBOutlet weak var breakFastCalLabel: UILabel!
    @IBOutlet weak var lunchFoodLabel: UILabel!
    @IBOutlet weak var lunchCalLabel: UILabel!
    @IBOutlet weak var dinnerFoodLabel: UILabel!
    @IBOutlet weak var dinnerCalLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var calorieGoalLabel: UILabel!
    @IBOutlet weak var deleteBreakfastButton: UIButton!
    
    @IBOutlet weak var deleteLunchButton: UIButton!
    @IBOutlet weak var deleteDinnerButton: UIButton!
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        userName = UserDefaults.standard.string(forKey: "DB")!
        userNameLabel.text = userName
        calIdentify = UserDefaults.standard.integer(forKey: "calorieDB")
          
        if (calIdentify == 0){
            calorieGoalLabel.text = String(0)
        } else {
            calorieGoal = UserDefaults.standard.integer(forKey: "calorieDB")
            calorieGoalLabel.text = String(calorieGoal)
            minusCalorie()
        }
        
        showFood()
    }

    func minusCalorie() {
        calorieGoal = UserDefaults.standard.integer(forKey: "calorieDB")
        breakfastCal = UserDefaults.standard.integer(forKey: "breakfastCal")
        lunchCal = UserDefaults.standard.integer(forKey: "lunchCal")
        dinnerCal = UserDefaults.standard.integer(forKey: "dinnerCal")
        
        minusCal = calorieGoal - breakfastCal - lunchCal - dinnerCal
        
        calorieGoalLabel.text = String(minusCal)
    }
    
    
    func showFood() {
        if (breakfastName.isEmpty && breakfastCal == 0 && lunchName.isEmpty && lunchCal == 0 && dinnerName.isEmpty && dinnerCal == 0){
            breakFastFoodLabel.text = " "
            breakFastCalLabel.text = " "
            lunchFoodLabel.text = " "
            lunchCalLabel.text = " "
            dinnerFoodLabel.text = " "
            dinnerCalLabel.text = " "
        } else if (lunchName.isEmpty && lunchCal == 0 && dinnerName.isEmpty && dinnerCal == 0){
            breakfastName = UserDefaults.standard.string(forKey: "breakfast")!
            breakFastFoodLabel.text = breakfastName
            breakfastCal = UserDefaults.standard.integer(forKey: "breakfastCal")
            breakFastCalLabel.text = String(breakfastCal)
            lunchFoodLabel.text = " "
            lunchCalLabel.text = " "
            dinnerFoodLabel.text = " "
            dinnerCalLabel.text = " "
        }else if (breakfastName.isEmpty && breakfastCal == 0 && dinnerName.isEmpty && dinnerCal == 0){
            breakFastFoodLabel.text = " "
            breakFastCalLabel.text = " "
            lunchName = UserDefaults.standard.string(forKey: "lunch")!
            lunchFoodLabel.text = lunchName
            lunchCal = UserDefaults.standard.integer(forKey: "lunchCal")
            lunchCalLabel.text = String(lunchCal)
            dinnerFoodLabel.text = " "
            dinnerCalLabel.text = " "
        }else if (breakfastName.isEmpty && breakfastCal == 0 && lunchName.isEmpty && lunchCal == 0){
            breakFastFoodLabel.text = " "
            breakFastCalLabel.text = " "
            lunchFoodLabel.text = " "
            lunchCalLabel.text = " "
            dinnerName = UserDefaults.standard.string(forKey: "dinner")!
            dinnerFoodLabel.text = dinnerName
            dinnerCal = UserDefaults.standard.integer(forKey: "dinnerCal")
            dinnerCalLabel.text = String(dinnerCal)
        }else if (dinnerName.isEmpty && dinnerCal == 0){
            breakfastName = UserDefaults.standard.string(forKey: "breakfast")!
            breakFastFoodLabel.text = breakfastName
            breakfastCal = UserDefaults.standard.integer(forKey: "breakfastCal")
            breakFastCalLabel.text = String(breakfastCal)


            lunchName = UserDefaults.standard.string(forKey: "lunch")!
            lunchFoodLabel.text = lunchName
            lunchCal = UserDefaults.standard.integer(forKey: "lunchCal")
            lunchCalLabel.text = String(lunchCal)
            dinnerFoodLabel.text = " "
            dinnerCalLabel.text = " "
        }else {

            breakfastName = UserDefaults.standard.string(forKey: "breakfast")!
            breakFastFoodLabel.text = breakfastName
            breakfastCal = UserDefaults.standard.integer(forKey: "breakfastCal")
            breakFastCalLabel.text = String(breakfastCal)


            lunchName = UserDefaults.standard.string(forKey: "lunch")!
            lunchFoodLabel.text = lunchName
            lunchCal = UserDefaults.standard.integer(forKey: "lunchCal")
            lunchCalLabel.text = String(lunchCal)

            
            dinnerName = UserDefaults.standard.string(forKey: "dinner")!
            dinnerFoodLabel.text = dinnerName
            dinnerCal = UserDefaults.standard.integer(forKey: "dinnerCal")
            dinnerCalLabel.text = String(dinnerCal)
        
        }
        
    }
    
    @IBAction func deleteBreakfast(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: "breakfast")
        UserDefaults.standard.removeObject(forKey: "breakfastCal")
        breakFastFoodLabel.text = " "
        breakFastCalLabel.text = " "
    }
    
    @IBAction func deleteLunch(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: "lunch")
        UserDefaults.standard.removeObject(forKey: "lunchCal")
        lunchFoodLabel.text = " "
        lunchCalLabel.text = " "
    }
    
    
    @IBAction func deleteDinner(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: "dinner")
        UserDefaults.standard.removeObject(forKey: "dinnerCal")
        dinnerFoodLabel.text = " "
        dinnerCalLabel.text = " "
    }

    @IBAction func resetUserTesting(_ sender: Any)
    {
        UserDefaults.standard.removeObject(forKey: "DB")
        UserDefaults.standard.removeObject(forKey: "dinner")
        UserDefaults.standard.removeObject(forKey: "dinnerCal")
        dinnerFoodLabel.text = " "
        dinnerCalLabel.text = " "
        UserDefaults.standard.removeObject(forKey: "lunch")
        UserDefaults.standard.removeObject(forKey: "lunchCal")
        lunchFoodLabel.text = " "
        lunchCalLabel.text = " "
        UserDefaults.standard.removeObject(forKey: "breakfast")
        UserDefaults.standard.removeObject(forKey: "breakfastCal")
        breakFastFoodLabel.text = " "
        breakFastCalLabel.text = " "
        UserDefaults.standard.removeObject(forKey: "calorieDB")
        calorieGoalLabel.text = String(0)
        
        let vc = storyboard?.instantiateViewController(identifier: "ViewController") as! ViewController
        self.navigationController?.pushViewController(vc, animated: true)
        vc.navigationItem.setHidesBackButton(true, animated: true)
    
    }


}
