//
//  EmployeesListViewController.swift
//  LocalDatabase
//
//  Created by Chandrakant Shingala on 10/02/23.
//

import UIKit

class EmployeesListViewController: UIViewController {

    @IBOutlet weak var employeeTableView: UITableView!
    var arrEmployees: [Employee] = []
    override func viewDidLoad() {
        super.viewDidLoad()

    }

}


extension EmployeesListViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrEmployees.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell()
        let employee = arrEmployees[indexPath.row]
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = ""
        return cell
    }
    
    
}
