//
//  EmployeeTableVC.swift
//  EmployeeRoster
//
//  Created by ronny abraham on 12/19/17.
//  Copyright © 2017 ronny abraham. All rights reserved.
//

import UIKit

class EmployeeDetailTableVC: UITableViewController, UITextFieldDelegate {

    struct PropertyKeys {
        static let unwindToListIndentifier = "UnwindToListSegue"
    }
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var dobLabel: UILabel!
    @IBOutlet weak var employeeTypeLabel: UILabel!
    
    var employee: Employee?
    
    var isEditingBirthday: Bool = false {
        didSet {
            
            // following methods esure that table view calls
            // it's delegate methods whenever isEditingBirthday changes
            tableView.beginUpdates()
            tableView.endUpdates()
        }
    }
    
    var datePickerIndexPath = IndexPath(row: 2, section: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateView()
    }
    
    func updateView() {
        if let employee = employee {
            navigationItem.title = employee.name
            nameTextField.text = employee.name
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            dobLabel.text = dateFormatter.string(from: employee.dateOfBirth)
            dobLabel.textColor = .black
            employeeTypeLabel.text = employee.employeeType.description()
            employeeTypeLabel.textColor = .black
        } else {
            navigationItem.title = "New Employee"
        }
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == datePickerIndexPath.row {
            if isEditingBirthday {
                return 216.0
            }
            return 0.0
        }
        return 44.0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        // if date picker row was selected, then switch off
        if indexPath.row == datePickerIndexPath.row - 1 {
            isEditingBirthday = !isEditingBirthday
        }
        
    }
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        if let name = nameTextField.text {
            employee = Employee(name: name, dateOfBirth: Date(), employeeType: .exempt)
            performSegue(withIdentifier: PropertyKeys.unwindToListIndentifier, sender: self)
        }
    }

    @IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) {
        employee = nil
        performSegue(withIdentifier: PropertyKeys.unwindToListIndentifier, sender: self)
    }
    
    // MARK: - Text Field Delegate
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false
    }
}
