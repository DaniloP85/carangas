//
//  CarViewControllerTests.swift
//  CarangasTests
//
//  Created by Usuário Convidado on 10/12/22.
//

import XCTest
@testable import Carangas

class CarViewControllerTests: XCTestCase {
    func test_viewWillAppear_whenUsingaViewModel_shouldUpdateViewWithDataFromViewModel(){
        // Given
        let sut = makeSUT()
        sut.loadView()
        
        // When
        sut.beginAppearanceTransition(true, animated: false)
        sut.endAppearanceTransition()
        
        //Then
        XCTAssertEqual(sut.title, "Carro de teste")
        XCTAssertEqual(sut.labelBrand.text, "Marca: Ferrari")
        XCTAssertEqual(sut.labelPrice.text, "Preço: R$ 250.000,00")
    }
    
    // MARK: - Helpers
    
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
