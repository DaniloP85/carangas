//
//  CarFormViewController.swift
//  Carangas
//
//  Created by Alves Brito, Eric(AWF) on 21/06/22.
//

import UIKit

final class CarFormViewController: UIViewController {
    
    
    
    
    @IBOutlet weak var textFieldBrand: UITextField!
    @IBOutlet weak var textFieldName: UITextField!
    @IBOutlet weak var textFieldPrice: UITextField!
    @IBOutlet weak var segmentedControlGasType: UISegmentedControl!
    @IBOutlet weak var buttonSave: UIButton!
    
    var viewModel: CarFormViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel()
        setupUI()
    }
    
    private func setupViewModel() {
        //MVMM Injetando closures
        viewModel?.onCarCreated = onCarCreated
        viewModel?.onCarUpdated = onCarUpdated
        
        //MVP
        //        viewModel?.delegate = self
    }
    
    private func setupUI() {
        title = viewModel?.title
        textFieldBrand.text = viewModel?.brand
        textFieldName.text = viewModel?.name
        textFieldPrice.text = viewModel?.price
        segmentedControlGasType.selectedSegmentIndex = viewModel?.gasType ?? 0
        buttonSave.setTitle(viewModel?.buttonTitle, for: .normal)
    }
    
    @IBAction func save(_ sender: UIButton) {
        viewModel?.save(name: textFieldName.text!,
                        brand: textFieldBrand.text!,
                        price: textFieldPrice.text!,
                        gasTypeIndex: segmentedControlGasType.selectedSegmentIndex)
    }
    
    lazy var onCarCreated: (Result<Void, CarServiceError>) -> () = {[weak self] in
        print("ViewModel chamou o método onCarCreated")
        self?.showResult($0)
    }
    
    lazy var onCarUpdated: (Result<Void, CarServiceError>) -> () = {[weak self] in
        print("ViewModel chamou o método onCarUpdated")
        self?.showResult($0)
    }
    
//    func onCarCreated(result: Result<Void, CarServiceError>) {
//        print("ViewModel chamou o método onCarCreated")
//        showResult(result)
//    }
//
//    func onCarUpdated(result: Result<Void, CarServiceError>) {
//        print("ViewModel chamou o método onCarUpdated")
//        showResult(result)
//    }
    
    private func showResult(_ result: Result<Void, CarServiceError>) {
        switch result {
        case .success:
            DispatchQueue.main.async {
                self.viewModel?.back()
            }
        case .failure(let apiError):
            print(apiError.errorMessage)
        }
    }
    
    deinit {
        print("CarFormViewController deinit")
    }
}

//extension CarFormViewController: CarFormViewModelDelegate {
//    
//}
