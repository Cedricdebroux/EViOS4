//
//  AddViewController.swift
//  EViOS4
//
//  Created by Cédric Debroux on 10/10/2022.
//

import UIKit
import CoreData

protocol AddViewDelegate: AnyObject{
    func didAdd()
}

class AddViewController: UIViewController {
    
    var delegate: AddViewDelegate?
    private let context = AppDelegate.shared.persistentContainer.viewContext
    
    
    var dateInput: Date!
    private var savePicker: Date!
    @IBOutlet var cancellButton: UIButton!
    
    @IBOutlet var saveButton: UIButton!
    
    @IBOutlet var nameInputTexField: UITextField!
    
    @IBOutlet var priceInputTextField: UITextField!
    
    
    @IBOutlet var datePicker: UIDatePicker!{
        didSet {
            datePicker.preferredDatePickerStyle = .wheels
            datePicker.datePickerMode = .date
            datePicker.addTarget(self, action: #selector(dateChange), for: .valueChanged)
        }
    }
    
    
    @IBAction func cancelActionButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func saveActionButton(_ sender: Any) {
        let floatValue = Float(priceInputTextField.text!)
        let newExpense = Entity(context: context)
        newExpense.name = nameInputTexField.text
        newExpense.price = floatValue!
        
        commitData()
        
    }
    
    func commitData() {
        do {
            try context.save()
            delegate?.didAdd()
        } catch {
            print("Can't save to Core Data!")
            context.rollback()
        }
        dismiss(animated: true, completion: nil)
    }
    
    
    static let idenditifier = "AddViewController"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    
    
    
    @objc func dateChange(){
      dateInput = datePicker.date
    }

}

