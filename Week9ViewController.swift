//
//  ViewController.swift
//  Week 9
//
//  Created by Thomas Hinrichs on 06/03/2020.
//  Copyright © 2020 Thomas Hinrichs. All rights reserved.
//

import UIKit
import Firebase

class Week9ViewController: UITableViewController {

    var headTextField = UITextField()
    var bodytextField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        CloudStorage.startListener(tableView: tableView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CloudStorage.getSize()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        
        cell?.textLabel?.text = CloudStorage.getNoteAt(index: indexPath.row).head
        
        return cell!
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: "Add new item to list", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add item", style: .default){ (action) in
            CloudStorage.addNote(index: 0, head: self.headTextField.text!, body: self.bodytextField.text!)
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new head"
            self.headTextField = alertTextField
        }
        
        alert.addTextField {(alertTextField) in
            alertTextField.placeholder = "Create new body"
            self.bodytextField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let destination = segue.destination as? DetailViewPage {
            destination.rowNumber = tableView.indexPathForSelectedRow!.row
        }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected row number \(indexPath.row)")
        performSegue(withIdentifier: "showDetail", sender: self)
    }
    
}
