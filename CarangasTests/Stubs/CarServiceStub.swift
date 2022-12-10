//
//  CarServiceStub.swift
//  CarangasTests
//
//  Created by Usuário Convidado on 10/12/22.
//

import Foundation
@testable import Carangas

final class CarServiceStub: CarServiceProtocol{
    func deleteCar(_ car: Car, onComplete: @escaping (Result<Void, CarServiceError>) -> Void) {
        
    }
    
    func loadCars(onComplete: @escaping (Result<[Car], CarServiceError>) -> Void) {
        let car1 = Car()
        
        car1.brand = "Ford"
        car1.name = "Ka"
        car1.gasType = 2
        car1.price = 50000
        car1._id = UUID().uuidString
        
        let car2 = Car()
        car2.brand = "Chevrolet"
        car2.name = "Coverte"
        car2.gasType = 1
        car2.price = 3550000
        car2._id = UUID().uuidString
        
        let cars:[Car] = [car1, car2]
        onComplete(.success(cars))
    }
}
