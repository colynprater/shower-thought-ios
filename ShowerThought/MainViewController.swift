//
//  MainViewController.swift
//  ShowerThought
//
//  Created by Colyn Prater on 11/7/17.
//  Copyright © 2017 Colyn Prater. All rights reserved.
//

import UIKit

// must conform to the UITableViewDataSource
// and UITableViewDelegate protocol
class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var showerThoughtsArray:[String] = []
    
    @IBOutlet weak var hourglass: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    
    @IBAction func showerThoughtBtnApiCall(_ sender: Any) {
        hourglass.isHidden = false
        
        let showerThoughtUrl = URL(string: "https://shower-thoughts-api.herokuapp.com/shower_thoughts_bundle")
        var request = URLRequest(url: showerThoughtUrl!)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if error == nil {
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: []) as! [String: AnyObject]
                    self.showerThoughtsArray = json["shower_thoughts"] as! [String]
                } catch let error as NSError {
                    print("Failed to get shower thoughts: \(error.localizedDescription)")
                }
            }
        }
        task.resume()
        hourglass.isHidden = true
        self.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return showerThoughtsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "showerThoughtCell") as! ShowerThoughtCell
        
        cell.textLabel?.text = showerThoughtsArray[indexPath.row]
        cell.textLabel?.numberOfLines = 0 // Break text out over multiple lines.
        
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hourglass.isHidden = true
    }
    
}
