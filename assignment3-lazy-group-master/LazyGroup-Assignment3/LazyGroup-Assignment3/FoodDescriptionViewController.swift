//
//  FoodDescriptionViewController.swift
//  LazyGroup-Assignment3
//
//  Created by Junghyun Eom on 22/5/21.
//  Assigned to Aung

import UIKit

class FoodDescriptionViewController: UIViewController {
    
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var calorie: UITextView!
    @IBOutlet weak var foodTitle: UILabel!
    @IBOutlet weak var segmentedControlOutlet: UISegmentedControl!
    
    
    var breakfastName: String = "";
    var breakfastCal: Int = 0
    var lunchName: String = "";
    var lunchCal: Int = 0
    var dinnerName: String = "";
    var dinnerCal: Int = 0
    
    
    var recievedData = ""
    var id = 0
    var foodImage = ""
    var foodName = ""
    var select = [Any]()
    var userName: String = ""
    var foodcalorieStr: String = ""
    var foodCalorieInt: Int = 0
    var meal = [[String]]()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        if let selectedResult = UserDefaults.standard.value(forKey: "selectedResult") as? [Any] {
            self.select = selectedResult
        }
        id = select[0] as! Int
        foodName = select[1] as! String
        foodImage = select[2] as! String
        loadData(id: id)
        

        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        loadData(id: id)
        if segue.identifier == "goToMainPage"{
            let vc = segue.destination as! MainViewController
            switch segmentedControlOutlet.selectedSegmentIndex {
            case 0:
                
                breakfastName = foodTitle.text!
                breakfastCal = foodCalorieInt

                
                UserDefaults.standard.set(breakfastName, forKey: "breakfast")
                UserDefaults.standard.set(breakfastCal, forKey: "breakfastCal")
                vc.breakfastName = breakfastName
                vc.breakfastCal = breakfastCal
                
                

            case 1:
                lunchName = foodTitle.text!
                lunchCal = foodCalorieInt
                
                UserDefaults.standard.set(lunchName, forKey: "lunch")
                UserDefaults.standard.set(lunchCal, forKey: "lunchCal")
                vc.lunchName = lunchName
                vc.lunchCal = lunchCal
            case 2:
   
                dinnerName = foodTitle.text!
                dinnerCal = foodCalorieInt
                UserDefaults.standard.set(dinnerName, forKey: "dinner")
                UserDefaults.standard.set(dinnerCal, forKey: "dinnerCal")

                vc.dinnerName = dinnerName
                vc.dinnerCal = dinnerCal
            default:
                break
            }

        }
    }
    
    
    func loadData(id : Int){
        guard let url = URL(string: "https://api.spoonacular.com/recipes/\(id)/nutritionWidget.json?apiKey=391ab40f574d454bb50942ca13975b91") else{
            return
            
        }
        let task = URLSession.shared.dataTask(with: url)
        {
            (data, response, error) in
            guard let dataResponse = data, error == nil else{
                return
            }
            do{
                let JSONResponse = try JSONSerialization.jsonObject(with: dataResponse, options: [])
                if let readFromJson = JSONResponse as? [String:Any]{
                    //processing URL to imagedata
                    let URLImage = URL(string: self.foodImage)
                    let imageData = try! Data(contentsOf: URLImage!)
                    DispatchQueue.main.async {
                        //assigning each component with their respective texts and data
                        self.calorie.text = "Calorie:\t\t\((readFromJson["calories"] as! String))\nCarbs:\t\t\((readFromJson["calories"] as! String))\nFat:\t\t\t\((readFromJson["fat"] as! String))\nProtein:\t\t\((readFromJson["protein"] as! String))"
                        self.foodTitle.text = self.foodName
                        self.image.image = UIImage(data: imageData)
                        UserDefaults.standard.set(self.foodTitle.text, forKey: "foodName")
                        self.foodcalorieStr = readFromJson["calories"] as! String
                        let str = String(self.foodcalorieStr.removeLast())
                        self.foodCalorieInt = Int(self.foodcalorieStr)!
                        self.meal.append([self.foodName,self.foodcalorieStr])
                        UserDefaults.standard.setValue(self.meal, forKey: "meal")
                        
                        

                    }
                }
            }
            catch let parsingError {
                print (parsingError)
            }
        }
        task.resume()
    }
    
}
