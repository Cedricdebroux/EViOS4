//
//  ViewController.swift
//  EViOS4
//
//  Created by Cédric Debroux on 10/10/2022.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    private let context = AppDelegate.shared.persistentContainer.viewContext
    
    
    var listExpense: [Entity] = [Entity]() {
        didSet {
            listExpenseTableView.reloadData()
        }
    }
    
    @IBOutlet var addButton: UIButton!
    
    @IBOutlet var listExpenseTableView: UITableView!{
        didSet {
            listExpenseTableView.delegate = self
            listExpenseTableView.dataSource = self
            listExpenseTableView.register(UINib(nibName: "CustomTableViewCell", bundle: .main), forCellReuseIdentifier: CustomTableViewCell.identifier)
        }
    }
    
    @IBAction func toAddPageButton(_ sender: Any) {
        let addViewController = storyboard?.instantiateViewController(identifier: AddViewController.idenditifier) as? AddViewController
        addViewController?.delegate = self
        addViewController?.modalPresentationStyle = .automatic
        present(addViewController!, animated: true, completion: nil)
        
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    override func viewDidAppear(_ animated: Bool) {
        loadFromCoreData()
      
        
    }

    
    
    func loadFromCoreData(){
        let request = Entity.fetchRequest()
        
        let orderByDate = NSSortDescriptor(key: "date", ascending: true)
        
        request.sortDescriptors = [orderByDate]
        do {
            listExpense = try context.fetch(request)
        } catch {
            print("Can't fetch from Core Data !")
        }
    }
    
    

}

extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        listExpense.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath) as? CustomTableViewCell
        else {
            fatalError("unable to dequeue CustomTableViewCell")
        }
        cell.setupCell(expense: listExpense[indexPath.row])
        return cell
    }
    
    
}

extension ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        context.delete(listExpense[indexPath.row])
        loadFromCoreData()
    }
}

extension ViewController: AddViewDelegate{
    func didAdd() {
        loadFromCoreData()
    }
    
    
}

