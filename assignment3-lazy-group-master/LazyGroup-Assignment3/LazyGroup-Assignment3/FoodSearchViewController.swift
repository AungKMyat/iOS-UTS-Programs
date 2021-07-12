//
//  FoodSearchViewController.swift
//  LazyGroup-Assignment3
//
//  Created by Aung Kaung Myat on 23/5/21.
//

import UIKit

class FoodSearchViewController: UIViewController,UISearchResultsUpdating{
    
    let searchController = UISearchController(searchResultsController: ResultViewController())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initSearchController()
    }
    //search bar in navigation controller and update the results
    func initSearchController(){
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        let vc = searchController.searchResultsController as! ResultViewController
        guard let text = searchController.searchBar.text else {
            return
        }
        //condition to check searchword not to start without the word
        if text != ""{
            vc.search(keyword: text, completionHandler: {
                [] in
                vc.tableView.reloadData()
            })
        }
        
    }
}


//to show the resutls of search words (since it is in the same storyboard, this calss is written in this vc class
class ResultViewController:UITableViewController{
    
    var searchResults = [[Any]]()//array to save data from api
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "FoodResultTableViewCell", bundle: nil)//create a nib obejct
        tableView.register(nib, forCellReuseIdentifier:"FoodResultTableViewCell")//register cell
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return searchResults.count//number of rows
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FoodResultTableViewCell", for: indexPath) as! FoodResultTableViewCell
        cell.textLabel?.text = (searchResults[indexPath.row][1] as! String)//text from array
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let result = searchResults[indexPath.row]
        //save data from array where the cell is selected
        UserDefaults.standard.setValue(result, forKey: "selectedResult")
        super.presentingViewController?.performSegue(withIdentifier: "FoodDescription", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    // function to search meals using String as a keyword + completion handler
    func search (keyword:String, completionHandler: @escaping ()->()){
        guard let url = URL(string: "https://api.spoonacular.com/recipes/complexSearch?apiKey=391ab40f574d454bb50942ca13975b91&query=\(keyword)&number=50") else {
            return
        }
        //start URLSession
        let task = URLSession.shared.dataTask(with: url)
        {
            (data, response, error) in
            guard let dataResponse = data, error == nil else{
                return
            }
            do {
                let JsonResponse = try JSONSerialization.jsonObject(with: dataResponse, options: [])
                if let readFromJson = JsonResponse as? [String:Any]{
                    DispatchQueue.main.async{
                        self.searchResults.removeAll()
                        
                        for result in readFromJson["results"] as! [[String:Any]]{
                            //add search resutls from api to an array
                            let id = result["id"] as! Int
                            let title = result["title"] as! String
                            let image = result["image"] as! String
                            //append the main array
                            self.searchResults.append([id,title,image])
                            
                        }
                        
                        completionHandler()
                    }
                }
            }
            catch let parsingError {
                print("Error \(parsingError)")
            }
        }
        task.resume()
    }
}






