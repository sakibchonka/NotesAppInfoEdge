//
//  OTPViewModel.swift
//  NotesAppInfoEdge
//
//  Created by Mohammed Saqib on 18/07/25.
//

import Foundation
import Combine

class OTPViewModel: ObservableObject {
	
	let phoneNumberWithCountryCode: String
	
	@Published var otp: String = ""
	@Published var timeRemaining: Int = 59
	@Published var errorMessage: String?
	
	@Published var notesResponse: NotesAPIModel?
	@Published var shouldNavigateToNotes = false
	
	private var timer: Timer?
	
	init(phoneNumberWithCountryCode: String) {
		self.phoneNumberWithCountryCode = phoneNumberWithCountryCode
	}
	
	func verifyOTP() {
		NetworkManager.shared.callAPI(.otp(number: phoneNumberWithCountryCode, otp: otp), responseType: AuthResponse.self)
			.sink { result in
				if case .failure(let error) = result {
					print("OTP Error: \(error)")
				}
			} receiveValue: { response in
				if let token = response.token {
					UserDefaults.standard.set(token, forKey: "authToken")
					self.fetchNotes(with: token)
				} else {
					print("Auth token was nil")
				}
			}
			.store(in: &cancellables)

	}
	
	private func fetchNotes(with token: String) {
		guard let request = NetworkManager.shared.createNotesRequest(authToken: token) else { return }
		
		URLSession.shared.dataTask(with: request) { data, response, error in
			DispatchQueue.main.async {
				if let error = error {
					self.errorMessage = error.localizedDescription
					return
				}
				
				guard let data = data else {
					self.errorMessage = "No data received"
					return
				}
				
				do {
					let decoded = try JSONDecoder().decode(NotesAPIModel.self, from: data)
					self.notesResponse = decoded
					self.shouldNavigateToNotes = true
				} catch {
					self.errorMessage = "Decoding error: \(error)"
				}
			}
		}.resume()
	}
	
	func startTimer() {
		timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
			guard let self = self else { return }
			if self.timeRemaining > 0 {
				self.timeRemaining -= 1
			} else {
				self.timer?.invalidate()
			}
		}
	}
	
	func stopTimer() {
		timer?.invalidate()
		timer = nil
	}
	
	private var cancellables = Set<AnyCancellable>()
	
}
