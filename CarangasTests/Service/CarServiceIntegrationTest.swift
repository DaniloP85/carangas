//
//  CarServiceIntegrationTest.swift
//  CarangasTests
//
//  Created by Usuário Convidado on 10/12/22.
//

import XCTest
@testable import Carangas

class CarServiceIntegrationTest: XCTestCase {
    
    func test_loadCArs_shouldReturnSuccess(){
        
        let sut = makeSUT()
        
        let expectation = expectation(description: "Success service !!!")
        
        sut.loadCars { result in
            switch result {
            case .failure:
                XCTFail("O Serviço falou")
            case .success:
                print("Passou !!!")
                break
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 3.0)
    }
    
    private func makeSUT() -> CarService{
        CarService()
    }
}
