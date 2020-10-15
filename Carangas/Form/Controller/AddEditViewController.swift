//
//  AddEditViewController.swift
//  Carangas
//
//  Copyright © 2020 Eric Brito. All rights reserved.
//

import UIKit

class AddEditViewController: UIViewController {
    
    var car: Car?

    @IBOutlet weak var tfBrand: UITextField!
    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var tfPrice: UITextField!
    @IBOutlet weak var scGasType: UISegmentedControl!
    @IBOutlet weak var btAddEdit: UIButton!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if car != nil {
            tfName.text = car?.name
            tfPrice.text = "\(car?.price ?? 0)"
            scGasType.selectedSegmentIndex = car?.gasType ?? 0
            btAddEdit.setTitle("Update", for: .normal)
        }
    }
    
    @IBAction func addEdit(_ sender: UIButton) {
        if car == nil {
            car = Car()
        }
        
        car?.brand = tfBrand.text!
        car?.name = tfName.text!
        car?.gasType = scGasType.selectedSegmentIndex
        car?.price = Int(tfPrice.text!) ?? 0
        
        if car?._id == nil {
            CarAPI().createCar(car!) { [weak self] (_) in
                self?.goBack()
            }
        } else {
            CarAPI().updateCar(car!) { [weak self] (_) in
                self?.goBack()
            }
        }
    }
    
    private func goBack() {
        DispatchQueue.main.async {
            self.navigationController?.popViewController(animated: true)
        }
    }
}
