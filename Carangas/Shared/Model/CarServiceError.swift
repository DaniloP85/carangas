//
//  CarServiceError.swift
//  Carangas
//
//  Created by Alves Brito, Eric(AWF) on 21/06/22.
//

import Foundation

enum CarServiceError: Error {
	case badURL
	case taskError
	case noResponse
	case invalidResponse(statusCode: Int)
	case noData
	case decodingError
	case unknown
	
	var errorMessage: String {
		switch self {
			case .badURL:
				return "URL inválida"
			case .taskError:
				return "A requisição não pode ser executada"
			case .noResponse:
				return "O servidor não respondeu"
			case .invalidResponse(let statusCode):
				return "Resposta inválida. Código do erro: \(statusCode)"
			case .noData:
				return "Sem dados retornados"
			case .decodingError:
				return "Dados inválidos"
			case .unknown:
				return "Erro desconhecido"
		}
	}
}
