//
//  CarFormCoodinator.swift
//  Carangas
//
//  Created by pos on 29/10/22.
//

import UIKit

final class CarFormCoordinator: Coordinator {
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    var parentCoordinator: Coordinator?
    private var car: Car?
    
    init(navigationController: UINavigationController, car: Car? = nil) {
        self.navigationController = navigationController
        self.car = car
    }
    
    func start() {
        let viewController = CarFormViewController.instantiateFromStoryboard(.form)
        viewController.viewModel = CarFormViewModel(car: car, coordinator: self)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func back() {
        navigationController.popViewController(animated: true)
    }
    
    deinit {
        print("CarFormCoordinator deinit")
    }
}
