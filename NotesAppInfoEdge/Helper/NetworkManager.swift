//
//  NetworkManager.swift
//  NotesAppInfoEdge
//
//  Created by Mohammed Saqib on 18/07/25.
//

import Foundation
import Combine

enum NotesAPI {
	case phoneNumber(number: String)
	case otp(number: String, otp: String)
	case notes(authToken: String)
	
	var url: URL? {
		URL(string: NetworkConstants.baseURL + path)
	}
	
	var path: String {
		switch self {
		case .phoneNumber: return NetworkConstants.phoneNumberEndPoint
		case .otp: return NetworkConstants.otpEndPoint
		case .notes: return NetworkConstants.notesAPI
		}
	}
	
	var method: String {
		switch self {
		case .notes: return "GET"
		default: return "POST"
		}
	}
	
	var headers: [String: String] {
		switch self {
		case .notes(let token):
			return ["Authorization" : token]
		default:
			return ["Content-Type" : "application/json"]
		}
	}
	
	var body: Data? {
		switch self {
		case .phoneNumber(let number):
			return try? JSONSerialization.data(withJSONObject: ["number": number])
		case .otp(let number, let otp):
			return try? JSONSerialization.data(withJSONObject: ["number": number, "otp": otp])
		case .notes:
			return nil
		}
	}
}

class NetworkManager {
	
	static let shared = NetworkManager()
	private init() {}
	
	func callAPI<T: Decodable>(_ api: NotesAPI, responseType: T.Type) -> AnyPublisher<T, Error> {
		guard let url = api.url else {
			return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
		}
		
		var request = URLRequest(url: url)
		request.httpMethod = api.method
		request.allHTTPHeaderFields = api.headers
		request.httpBody = api.body
		
		return URLSession.shared.dataTaskPublisher(for: request)
			.tryMap { data, response in
				guard let httpResponse = response as? HTTPURLResponse, 200...300 ~=  httpResponse.statusCode else {
					throw URLError(.badServerResponse)
				}
				return data
			}
			.decode(type: T.self, decoder: JSONDecoder())
			.receive(on: DispatchQueue.main)
			.eraseToAnyPublisher()
	}
	
	func createNotesRequest(authToken: String) -> URLRequest? {
		guard let url = URL(string: NetworkConstants.baseURL + NetworkConstants.notesAPI) else {
			return nil
		}
		
		var request = URLRequest(url: url)
		request.httpMethod = "GET"
		request.setValue(authToken, forHTTPHeaderField: "Authorization")
		
		return request
	}

}
