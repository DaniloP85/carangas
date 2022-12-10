//
//  CarsListingViewModel.swift
//  Carangas
//
//  Created by pos on 11/10/22.
//

import Foundation

final class CarsListingViewModel {
    private var cars: [Car] = []
    private let service: CarServiceProtocol
    private weak var coordinator: CarsListingCoordinator?
    
    init(service: CarServiceProtocol = CarService(), coordinator: CarsListingCoordinator) {
        self.coordinator = coordinator
        self.service = service
    }
    
    var numberOfRows: Int {
        cars.count
    }
    
    func loadCars(onComplete: @escaping (Result<Void, CarServiceError>) -> Void) {
        service.loadCars { [weak self] result in
            switch result {
            case .success(let cars):
                self?.cars = cars
                onComplete(.success(()))
            case .failure(let apiError):
                onComplete(.failure(apiError))
            }
        }
    }
    
    func cellViewModelFor(_ indexPath: IndexPath) -> VehicleCellProtocol {
        let car = cars[indexPath.row]
        let viewModel = CarCellViewModel(car: car)
        return viewModel
    }
    
    func deleteCar(at indexPath: IndexPath, onComplete: @escaping (Result<Void, CarServiceError>) -> Void) {
        let car = cars[indexPath.row]
        service.deleteCar(car) { [weak self] result in
            switch result {
            case .success:
                self?.cars.remove(at: indexPath.row)
                onComplete(.success(()))
            case .failure(let apiError):
                onComplete(.failure(apiError))
            }
        }
    }
    
    func showCarAt(_ indexPath: IndexPath) {
        let car = cars[indexPath.row]
        coordinator?.showCar(car)
    }
    
    func showCarCreation() {
        coordinator?.showCarCreation()
    }
}
