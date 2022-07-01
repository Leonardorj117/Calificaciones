//
//  ViewController.swift
//  Calificaciones.
//
//  Created by Leonardo Rubio on 15/06/22.
//

import UIKit
import CoreData
import SCLAlertView

class ViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var tableView:UITableView!
    @IBOutlet weak var buttonToRegister:UIButton!
    @IBOutlet weak var buttonDetail:UIButton!
    @IBOutlet weak var viewFond:UIView!
    @IBOutlet weak var viewTable:UIView!
    
    //MARK: - Private
    private var arrayOfRatings = [Student]()
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(UINib(nibName: "CustomCell", bundle: nil), forCellReuseIdentifier: "cell")
        self.buttonToRegister.customButton()
        self.buttonDetail.customButton()
        self.viewTable.addShadow()
        self.viewFond.addGradient2()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        recuperarDatos()
    }
    
    //MARK: - Button Actions
    @IBAction func actionRegister(_ sender:UIButton){
        let vc = RegisterView()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func actionDetail(_ sender:UIButton){
        let vc = AverageView()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK: - Public Functions
    private func recuperarDatos(){
        do{
            try self.arrayOfRatings = self.context.fetch(Student.fetchRequest())
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }catch{
            SCLAlertView().showError("Error", subTitle: "Error al recuperar datos.", closeButtonTitle: "Aceptar", animationStyle: .bottomToTop)
        }
    }
    
}

//MARK: - UITableViewDataSource
extension ViewController:UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayOfRatings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath) as? CustomCell else {
            return UITableViewCell()
        }
        let student = self.arrayOfRatings[indexPath.row]
        if !self.arrayOfRatings.isEmpty{cell.fillCell(student: student)}
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
}

//MARK: - UITableViewDelegate
extension ViewController:UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailView()
        let student = self.arrayOfRatings[indexPath.row]
        vc.student = student
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let delete = UIContextualAction(style: .destructive, title: "Eliminar.") {  (contextualAction, view, boolValue) in
            let studentToDelete = self.arrayOfRatings[indexPath.row]
            do{
                self.context.delete(studentToDelete)
                try  self.context.save()
            }catch{
                SCLAlertView().showError("Error", subTitle: "Error al eliminar el elemento.", closeButtonTitle: "Aceptar", animationStyle: .bottomToTop)
            }
            self.recuperarDatos()
        }
        let swipeActions = UISwipeActionsConfiguration(actions: [delete])
        return swipeActions
    }
}


