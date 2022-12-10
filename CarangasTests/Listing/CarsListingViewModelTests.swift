//
//  CarsListingViewModelTests.swift
//  CarangasTests
//
//  Created by Usuário Convidado on 10/12/22.
//

import XCTest
@testable import Carangas

class CarsListingViewModelTests: XCTestCase {
    

        func test_numberOfRows_shouldReturnNumberOfCars() {
            //Given
            let sut = makeSUT()
         
            sut.loadCars { _ in }
            
            //When
            let result = sut.numberOfRows
            
            //Then
            XCTAssertEqual(result, 2, "O numero de carros não foi o esperado")
        }
    
        func test_cesllViewModelFor_shouldReturnCarCellViewModelforCarAtIndexPath(){
            // Given
            let sut = makeSUT()
            sut.loadCars { _ in }
            let indexPath = IndexPath(row: 0, section: 0)
            
            // When
            let cellViewModel = sut.cellViewModelFor(indexPath)
            
            // Then
            XCTAssertTrue(cellViewModel is CarCellViewModel)
            XCTAssertEqual(cellViewModel.name, "Ka")
            XCTAssertEqual(cellViewModel.brand, "Ford")
        }
        
        // MARK: -> Helpers
        func makeSUT() -> CarsListingViewModel {
            let navigationController = UINavigationController()
            let coordinator = CarsListingCoordinator(navigationController: navigationController)
            let service = CarServiceStub()
            let sut = CarsListingViewModel(service: service, coordinator: coordinator)
            return sut
        }

//    override func setUpWithError() throws {
//        // Put setup code here. This method is called before the invocation of each test method in the class.
//    }
//
//    override func tearDownWithError() throws {
//        // Put teardown code here. This method is called after the invocation of each test method in the class.
//    }
//
//    func testExample() throws {
//        // This is an example of a functional test case.
//        // Use XCTAssert and related functions to verify your tests produce the correct results.
//        // Any test you write for XCTest can be annotated as throws and async.
//        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
//        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
//    }
//
//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }

}
