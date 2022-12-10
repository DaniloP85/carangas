//
//  CarFormViewModel.swift
//  Carangas
//
//  Created by pos on 11/10/22.
//

import Foundation

//protocol CarFormViewModelDelegate: AnyObject {
//    func onCarCreated(result: Result<Void, CarServiceError>) -> Void
//    func onCarUpdated(result: Result<Void, CarServiceError>) -> Void
//}

final class CarFormViewModel {
    
    private var car: Car
    private let service = CarService()
    private var isEditing: Bool {
        car._id != nil
    }
    
    //MVMM Injetando closures
    var onCarCreated: ((Result<Void, CarServiceError>) -> Void)?
    var onCarUpdated: ((Result<Void, CarServiceError>) -> Void)?
    
    //MVMM usando Delegation (MVP)
//    weak var delegate: CarFormViewModelDelegate?
    
    var title: String {
        isEditing ? "Atualização" : "Cadastro"
    }
    
    var brand: String { car.brand }
    var name: String { car.name }
    var price: String { "\(car.price)" }
    var gasType: Int { car.gasType }
    
    var buttonTitle: String {
        isEditing ? "Atualizar carro" : "Cadastrar carro"
    }
    
    private weak var coordinator: CarFormCoordinator?
    
    init(car: Car? = nil, coordinator: CarFormCoordinator) {
        self.car = car ?? Car()
        self.coordinator = coordinator
    }
    
    func save(name: String, brand: String, price: String, gasTypeIndex: Int) {
        car.name = name
        car.brand = brand
        car.price = Int(price) ?? 0
        car.gasType = gasTypeIndex
        
        if isEditing {
            service.updateCar(car) { [weak self] result in
                self?.onCarUpdated?(result)
//                self?.delegate?.onCarUpdated(result: result)
            }
        } else {
            service.createCar(car) { [weak self] result in
                self?.onCarCreated?(result)
//                self?.delegate?.onCarCreated(result: result)
            }
        }
    }
    
    func back() {
        coordinator?.back()
    }
    
    deinit {
        print("CarFormViewModel deinit")
        coordinator?.childDidFinish(nil)
    }
    
}
