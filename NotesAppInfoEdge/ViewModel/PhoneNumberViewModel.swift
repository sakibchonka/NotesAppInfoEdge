//
//  PhoneNumberViewModel.swift
//  NotesAppInfoEdge
//
//  Created by Mohammed Saqib on 18/07/25.
//

import Foundation
import Combine

class PhoneNumberViewModel: ObservableObject {
	@Published var countryCode: String = "+91"
	@Published var phoneNumber: String = ""
	
	var isValidPhoneNumber: Bool {
		phoneNumber.count == 10 && phoneNumber.allSatisfy { $0.isNumber }
	}
	
	func sendPhoneNumber(completion: @escaping (Bool) -> Void) {
		NetworkManager.shared.callAPI(.phoneNumber(number: phoneNumber), responseType: PhoneNumberModel.self)
			.sink { result in
				if case let .failure(error) = result {
					print("Error: ", error)
					completion(false)
				}
			} receiveValue: { response in
				completion(true)
			}
			.store(in: &cancellables)
	}
	
	private var cancellables = Set<AnyCancellable>()
}
