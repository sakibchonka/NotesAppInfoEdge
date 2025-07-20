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
	@Environment(\.colorScheme) private var colorScheme
	
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
						.foregroundStyle(colorScheme == .dark ? .white : .black)
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
						.font(.subheadline)
						.fontWeight(.semibold)
						.foregroundStyle(.black)
						.padding(.horizontal, 20)
						.padding(.vertical, 8)
						.background(Color.yellow)
						.clipShape(Capsule())
				}
				.padding([.top, .bottom], 12.0)
				
				VStack {
					
					Text("00:\(String(format: "%02d", otpVM.timeRemaining))")
						.fontWeight(.bold)
						.foregroundStyle(otpVM.isTimeEnded ? Color.red : Color.primary)
					
					if otpVM.isTimeEnded {
						Button("Resend") {
							otpVM.resetTimer()
							otpVM.startTimer()
						}
						.fontWeight(.semibold)
						.foregroundColor(.blue)
					}
				}
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
		.alert(otpVM.errorMessage, isPresented: $otpVM.isError) {
			Button("Ok", role: .cancel) {}
		}
	}
}
