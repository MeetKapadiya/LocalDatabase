//
//  ViewController.swift
//  LocalDatabase
//
//  Created by Chandrakant Shingala on 08/02/23.
//

import UIKit
import FMDB

class ViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var salaryTextField: UITextField!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var updateButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
    var arrEmployees = [Employee]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func saveButtonTapped(_ sender: UIButton) {
        
        if nameTextField.text?.count == 0 || addressTextField.text?.count == 0 || salaryTextField.text?.count == 0 {
            displayAlert()
            return
        }
        
        let query = "insert into emp (name, address, salary) values ('\(nameTextField.text ?? "")','\(addressTextField.text ?? "")','\(salaryTextField.text ?? "")');"
        print(query)
        let databaseObject = FMDatabase(path: AppDelegate.databasePath)
        if databaseObject.open() {
            let result = databaseObject.executeUpdate(query, withArgumentsIn: [])
            if result == true {
                nameTextField.text = ""
                addressTextField.text = ""
                salaryTextField.text = ""
                messageLabel.text = "Data is saved successfully"
                messageLabel.textColor = UIColor.green
            } else {
                messageLabel.text = "Data is not saved successfully"
                messageLabel.textColor = UIColor.red
            }
        }
    }
    @IBAction func searchButtonTapped(_ sender: UIButton) {
        
        let query = "selete * frome emp WHERE name = '\(nameTextField.text ?? "")';"
        let databaseObject = FMDatabase(path: AppDelegate.databasePath)
        if databaseObject.open() {
            let result = databaseObject.executeQuery(query, withArgumentsIn: [])
            print(result)
            arrEmployees = []
            while result?.next() == true {
                let name = result?.string(forColumn: "name") ?? ""
                let salary = result?.string(forColumn: "salary") ?? ""
                let address = result?.string(forColumn: "address") ?? ""
                let employee = Employee(name: name, address: address, salary: salary)
                arrEmployees.append(employee)
                        }
                        print(arrEmployees)
                        
//                        if arrEmployees.count > 0 {
//                            let storyBoard = UIStoryboard  (name: "main", bundle: nil)
//                            let employeesListViewController = storyBoard.instantiateViewController(withIdentifier: "EmployeesListViewController") as! EmployeesListViewController
//                            employeesListViewController.arrEmployees = arrEmployees
//                            navigationController?.pushViewController(employeesListViewController, animated: true)
//
//                        } else {
//                            //displayAlert()
//                        }
        }else {
            print("data not found")
        }
    }
    @IBAction func updateButtonTapped(_ sender: UIButton) {
        
        if nameTextField.text?.count == 0 || nameTextField.text?.count == 0 || nameTextField.text?.count == 0 {
            displayAlert()
            return
        }
        let query = "update emp set address = '\(addressTextField.text ?? "")',' salary = \(salaryTextField.text ?? "")',where name = '\(nameTextField.text ?? "")';"
        print(query)
        let databaseObject = FMDatabase(path: AppDelegate.databasePath)
        if databaseObject.open() {
            let result = databaseObject.executeUpdate(query, withArgumentsIn: [])
            if result == true {
                nameTextField.text = ""
                addressTextField.text = ""
                salaryTextField.text = ""
                messageLabel.text = "Data is updated successfully"
                messageLabel.textColor = UIColor.green
            } else {
                messageLabel.text = "Data is not updated successfully"
                messageLabel.textColor = UIColor.red
            }
        }
    }
    @IBAction func deleteButtonTapped(_ sender: UIButton) {
        
        if nameTextField.text?.count == 0 {
            displayAlert()
            return
        }
        
        let query = "delete from emp where name = '\(nameTextField.text ?? "")';"
        print(query)
        let databaseObject = FMDatabase(path: AppDelegate.databasePath)
        if databaseObject.open() {
            let result = databaseObject.executeUpdate(query, withArgumentsIn: [])
            if result == true {
                nameTextField.text = ""
                addressTextField.text = ""
                salaryTextField.text = ""
                messageLabel.text = "Data is deleted successfully"
                messageLabel.textColor = UIColor.green
            } else {
                messageLabel.text = "Data is not deleted successfully"
                messageLabel.textColor = UIColor.red
            }
        }
    }
    
    private func displayAlert(){
        let alert: UIAlertController = UIAlertController(title: "Error", message: "Please enter missing details", preferredStyle: .alert)
        let okayButton: UIAlertAction = UIAlertAction(title: "Okay", style: .default)
        let cancelButton: UIAlertAction = UIAlertAction(title: "Cancel", style: .destructive)
        alert.addAction(okayButton)
        alert.addAction(cancelButton)
        present(alert, animated: true)
    }
    
}



struct Employee{
    var name: String
    var address: String
    var salary: String
}
