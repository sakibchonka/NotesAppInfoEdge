//
//  OTPScreen.swift
//  NotesAppInfoEdge
//
//  Created by Mohammed Saqib on 18/07/25.
//

import SwiftUI

struct OTPScreen: View {
	
	@StateObject var otpVM: OTPViewModel
	@ObservedObject var phoneNumVM: PhoneNumberViewModel
	
	@Environment(\.dismiss) private var dismiss
	
	var body: some View {
		VStack(alignment: .leading, spacing: 8.0) {
			
			HStack {
				Text(phoneNumVM.phoneNumber)
					.font(.body)
					.fontWeight(.medium)
				
				Button {
					dismiss()
				} label: {
					Image(systemName: "pencil")
						.frame(width: 14.0, height: 14.0)
						.foregroundStyle(.black)
						.fontWeight(.heavy)
				}
			}
			
			
			Text("Enter The \nOTP")
				.font(.largeTitle.bold().weight(.heavy))
			
			TextField("", text: $otpVM.otp)
				.fontWeight(.bold)
				.padding()
				.frame(width: 78, height: 36)
				.background(RoundedRectangle(cornerRadius: 8.0).stroke(Color.gray))
				.keyboardType(.phonePad)
			
			
			HStack(alignment:.center, spacing: 8.0) {
				Button {
					otpVM.verifyOTP()
				} label: {
					Text("Continue")
						.fontWeight(.bold)
						.foregroundStyle(.black)
						.frame(maxWidth: 96)
						.padding()
						.background(Color.yellow)
						.clipShape(Capsule())
				}
				.padding([.top, .bottom], 12.0)
				
				Text("00:\(String(format: "%02d", otpVM.timeRemaining))")
					.fontWeight(.bold)
			}
		}
		.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
		.padding(.top, 80)
		.padding(.leading, 30)
		.onAppear {
			otpVM.startTimer()
		}
		.onDisappear {
			otpVM.stopTimer()
		}
		.navigationDestination(isPresented: $otpVM.shouldNavigateToNotes) {
			if let response = otpVM.notesResponse {
				NotesScreen(response: response)
			}
		}
		.navigationBarBackButtonHidden(true)
	}
}
