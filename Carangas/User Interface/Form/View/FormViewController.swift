//
//  FormViewController.swift
//  Carangas
//
//  Copyright © 2020 Eric Brito. All rights reserved.
//

import UIKit

final class FormViewController: UIViewController {
    
    //MARK: - Properties
    var viewModel: FormViewModel?
    weak var coordinator: Coordinator?

    //MARK: - IBOutlets
    @IBOutlet weak var tfBrand: UITextField!
    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var tfPrice: UITextField!
    @IBOutlet weak var scGasType: UISegmentedControl!
    @IBOutlet weak var btAddEdit: UIButton!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    
    //MARK: - Super Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.delegate = self
        setupView()
    }
    
    //MARK: - Methods
    private func setupView() {
        tfBrand.text = viewModel?.brand
        tfName.text = viewModel?.name
        tfPrice.text = viewModel?.price
        scGasType.selectedSegmentIndex = viewModel?.fuelIndex ?? 0
        btAddEdit.setTitle(viewModel?.buttonTitle, for: .normal)
        title = viewModel?.title
    }
    
    private func checkResult(_ result: Result<Void, APIError>, withError message: String) {
        DispatchQueue.main.async {
            switch result {
            case .success:
                self.navigationController?.popViewController(animated: true)
            case .failure(let error):
                Alert.show(title: "Erro", message: "\(message) \(error.errorMessage)", presenter: self)
            }
        }
    }
    
    //MARK: - IBActions
    @IBAction func addEdit(_ sender: UIButton) {
        viewModel?.saveCar(name: tfName.text!, brand: tfBrand.text!, gasIndex: scGasType.selectedSegmentIndex, price: tfPrice.text!)
    }
    
    deinit {
        coordinator?.didFinish(child: nil)
        print("FormViewController já era")
    }
}

//MARK: - FormViewModel Delegate
extension FormViewController: FormViewModelDelegate {
    func onCar(didCreated: Result<Void, APIError>) {
        checkResult(didCreated, withError: "Falha ao criar o carro. Motivo:")
    }
    
    func onCar(didUpdated: Result<Void, APIError>) {
        checkResult(didUpdated, withError: "Falha ao atualizar o carro. Motivo:")
    }
}
