//
//  VisualizationViewController.swift
//  Carangas
//
//  Copyright © 2020 Eric Brito. All rights reserved.
//

import UIKit

typealias FormPresenterCoordinator = Coordinator & FormPresenter

final class VisualizationViewController: UIViewController {
    
    //MARK: - Properties
    var viewModel: VisualizationViewModel?
    weak var coordinator: FormPresenterCoordinator?
    
    //MARK: - IBOutlets
    @IBOutlet weak var lbBrand: UILabel!
    @IBOutlet weak var lbGasType: UILabel!
    @IBOutlet weak var lbPrice: UILabel!
    
    //MARK:  - Super Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        title = viewModel?.title
        lbBrand.text = viewModel?.brand
        lbGasType.text = viewModel?.fuelType
        lbPrice.text = viewModel?.price
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? FormViewController {
            vc.viewModel = viewModel?.getFormViewModel()
        }
    }
    
    deinit {
        coordinator?.didFinish(child: nil)
        print("VisualizationViewController já era")
    }
    //MARK: - IBAction
    @IBAction func updateCar(_ sender: UIBarButtonItem) {
        guard let viewModel = viewModel else {return}
        coordinator?.showForm(with: viewModel.getFormViewModel())
    }
}
