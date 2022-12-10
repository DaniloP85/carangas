//
//  CarangasSnapshotTests.swift
//  CarangasSnapshotTests
//
//  Created by Usuário Convidado on 10/12/22.
//

import XCTest
import iOSSnapshotTestCase
@testable import Carangas

class CarangasSnapshotTests: FBSnapshotTestCase {
    
    func test() {
        let sut = makeSUT()
        
        recordMode = false
        
        FBSnapshotVerifyViewController(sut)
    }
    
    
    private func makeSUT () -> CarViewController {
        let sut = CarViewController.instantiateFromStoryboard(.visualization)
        let car = Car()
        car.name = "Carro de teste"
        car.brand = "Ferrari"
        car.price = 250000
        let coordinator = CarVisualizationCoordinator(navigationController: UINavigationController(), car: car)
        let viewModel = CarVisualizationViewModel(car: car, coordinator: coordinator)
        sut.viewModel = viewModel
        
        return sut
    }
}
