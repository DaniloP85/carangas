//
//  CarVisualizationViewModel.swift
//  Carangas
//
//  Created by pos on 11/10/22.
//

import Foundation

protocol CarVisualizationViewModelProtocol {
    var title: String { get }
    var brand: String { get }
    var gasType: String { get }
    var price: String { get }
    func edit()
}

final class CarVisualizationViewModel: CarVisualizationViewModelProtocol {
    
    private var car: Car
    private let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "pt_BR")
        return formatter
    }()
    
    var title: String { car.name }
    var brand: String { "Marca: \(car.brand)" }
    var gasType: String { "Combustível: \(car.fuel)" }
    
    var price: String {
        let price = numberFormatter.string(from: NSNumber(value: car.price)) ?? "R$ \(car.price),00"
        return "Preço: \(price)"
    }
    
    weak var coordinator: CarVisualizationCoordinator?
    
    init(car: Car, coordinator: CarVisualizationCoordinator) {
        self.car = car
        self.coordinator = coordinator
    }
    
    func edit() {
        coordinator?.editCar(car)
    }
    
    deinit {
        print("CarVisualizationViewModel deinit")
        coordinator?.childDidFinish(nil)
    }
}
