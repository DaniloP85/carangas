//
//  CarsTableViewController.swift
//  Carangas
//
//  Created by Alves Brito, Eric(AWF) on 21/06/22.
//

import UIKit

final class CarsTableViewController: UITableViewController {
	
	// MARK: - Properties
	private let label: UILabel = {
		let label = UILabel(frame: .zero)
		label.text = "Sem carros cadastrados"
		label.textAlignment = .center
		label.font = UIFont.italicSystemFont(ofSize: 16.0)
		return label
	}()
    var viewModel: CarsListingViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.accessibilityIdentifier = "carsListTable"
    }
	
	// MARK: - Super Methods
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		loadCars()
	}
	
	private func loadCars() {
        viewModel?.loadCars { [weak self] result in
            switch result {
            case .success:
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let apiError):
                print(apiError.errorMessage)
            }
        }
	}
    
    // MARK: - IBActions
    @IBAction func createCar(_ sender: UIBarButtonItem) {
        viewModel?.showCarCreation()
    }
    
	// MARK: - Table view data source
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = viewModel?.numberOfRows ?? 0
		tableView.backgroundView = count == 0 ? label : nil
		return count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CarTableViewCell,
              let cellViewModel = viewModel?.cellViewModelFor(indexPath) else {
            return UITableViewCell()
        }
        
        cell.configure(with: cellViewModel)
		return cell
	}
	
	override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
		if editingStyle == .delete {
            viewModel?.deleteCar(at: indexPath) { [weak self] result in
                switch result {
                case .success:
                    DispatchQueue.main.async {
                        self?.tableView.deleteRows(at: [indexPath], with: .automatic)
                    }
                case .failure(let apiError):
                    print(apiError.errorMessage)
                }
            }
		}
	}
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.showCarAt(indexPath)
    }
}
