//
//  PhoneNumberScreen.swift
//  NotesAppInfoEdge
//
//  Created by Mohammed Saqib on 18/07/25.
//

import SwiftUI

struct PhoneNumberScreen: View {
	
	@StateObject private var phoneNumVM = PhoneNumberViewModel()
	@StateObject var alertManager = AlertManager()
	
	@State private var showOTPScreen = false
	
	var body: some View {
		NavigationStack {
			VStack(alignment: .leading, spacing: 8.0) {
				Text("Get OTP")
					.font(.title2)
				VStack(alignment: .leading, spacing: -8) {
					Text("Enter Your")
					Text("Phone Number")
				}
				.font(.largeTitle.weight(.heavy))
				
				HStack(spacing: 8.0) {
					
					TextField("+91", text: $phoneNumVM.countryCode)
						.padding()
						.frame(width: 64, height: 36)
						.background(RoundedRectangle(cornerRadius: 8.0).stroke(Color.gray))
						.keyboardType(.phonePad)
					
					TextField("Enter Phone", text: $phoneNumVM.phoneNumber)
						.padding()
						.frame(width: 147, height: 36)
						.background(RoundedRectangle(cornerRadius: 8.0).stroke(Color.gray))
						.keyboardType(.phonePad)
				}
				
				Button {
					
					guard phoneNumVM.isValidPhoneNumber else {
						alertManager.show(title: "Invalid Phone Number", message: "Please enter a 10-digit number")
						return
					}
					phoneNumVM.sendPhoneNumber { success in
						if success {
							showOTPScreen = true
						} else {
							alertManager.show(title: "Error Registering PhoneNumber", message: "Please try after some time")
						}
					}
				} label: {
					Text("Continue")
						.font(.subheadline)
						.fontWeight(.semibold)
						.foregroundStyle(.black)
						.padding(.horizontal, 20)
						.padding(.vertical, 8)
						.background(Color.yellow)
						.clipShape(Capsule())
				}
				.padding(.top, 12.0)
			}
			.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
			.padding(.top, 80)
			.padding(.leading, 30)
			.navigationDestination(isPresented: $showOTPScreen) {
				OTPScreen(otpVM: OTPViewModel(phoneNumberWithCountryCode: phoneNumVM.countryCode + phoneNumVM.phoneNumber), phoneNumVM: phoneNumVM)
			}
			.alert(alertManager.title, isPresented: $alertManager.isPresented) {
				Button("Ok", role: .cancel) {}
			} message: {
				Text(alertManager.message)
			}
		}
		
	}
}
