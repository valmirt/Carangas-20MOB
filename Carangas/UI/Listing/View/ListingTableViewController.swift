//
//  ListingTableViewController.swift
//  Carangas
//
//  Copyright © 2020 Eric Brito. All rights reserved.
//

import UIKit

class ListingTableViewController: UITableViewController {
    
    //MARK: - Properties
    let viewModel = ListingViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControl?.addTarget(self, action: #selector(loadCars), for: .valueChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.carsDidUpdate = carsDidUpdate
        loadCars()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.destination {
        case let visualizationViewController as VisualizationViewController:
            guard let indexPath = tableView.indexPathForSelectedRow else {return}
            visualizationViewController.viewModel = viewModel.getVisualizationViewModel(for: indexPath)
        case let formViewController as FormViewController:
            formViewController.viewModel = FormViewModel()
        default:
            break
        }
    }
    
    @objc private func loadCars() {
        viewModel.loadCars()
    }
    
    private func carsDidUpdate() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.refreshControl?.endRefreshing()
        }
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CarTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(with: viewModel.cellViewModel(for: indexPath))
        return cell
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completionHandler) in
            self.viewModel.deleteCar(at: indexPath) { (result) in
                switch result {
                case .success:
                    break
                case .failure(let error):
                    DispatchQueue.main.async {
                        Alert.show(title: "Erro", message: error.errorMessage, presenter: self)
                    }
                }
            }
        }
        
        if #available(iOS 13.0, *) {
            deleteAction.image = UIImage(systemName: "trash")
        } else {
            // Fallback on earlier versions
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}
