//
//  CarViewController.swift
//  Carangas
//
//  Created by Alves Brito, Eric(AWF) on 21/06/22.
//

import UIKit

final class CarViewController: UIViewController {
	
	@IBOutlet weak var labelBrand: UILabel!
	@IBOutlet weak var labelGasType: UILabel!
	@IBOutlet weak var labelPrice: UILabel!
	
	var viewModel: CarVisualizationViewModelProtocol?
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		if let viewModel = viewModel {
            title = viewModel.title
            labelBrand.text = viewModel.brand
            labelGasType.text = viewModel.gasType
            labelPrice.text = viewModel.price
		}
	}
    
    // MARK: - IBAction
    @IBAction func edit(_ sender: UIBarButtonItem) {
        viewModel?.edit()
    }
    
    deinit {
        print("CarViewController deinit")
    }

    
}
