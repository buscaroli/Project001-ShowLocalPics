//
//  ViewController.swift
//  Project001-ShowLocalPics
//
//  Created by Matteo on 15/07/2021.
//
// Based on a tutorial from Paul Hudson
//
// Pictures from Unspash, credits to:
// Bharati Kannan, Judi Neumeyer, Joy Christian, Karsten Winegeart,
// Alvan Nee, Hendo Wang, Alexander Naglestad

import UIKit

class ViewController: UITableViewController {

    var pictures = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Show Local Pics"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath! // '!' safe as the main bundle always has a path
        let items = try! fm.contentsOfDirectory(atPath: path) // '!' safe as pics are part of the project
        
        for item in items {
            if item.hasPrefix("puppies") {
                pictures.append(item)
            }
        }
    }

    // the TableView needs to know how many rows to display: one per picture
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text = pictures[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.selectedImage = pictures[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

