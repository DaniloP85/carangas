//
//  Car.swift
//  Carangas
//
//  Created by Alves Brito, Eric(AWF) on 21/06/22.
//

import Foundation

final class Car: Codable {
	var _id: String?
	var brand: String = ""
	var gasType: Int = 0
	var name: String = ""
	var price: Int = 0
	
	var fuel: String {
		switch gasType {
		case 0:
			return "Flex"
		case 1:
			return "Álcool"
		default:
			return "Gasolina"
		}
	}
}
