//
//  ContentView.swift
//  NotesAppInfoEdge
//
//  Created by Mohammed Saqib on 18/07/25.
//

import SwiftUI

struct ContentView: View {
//	@StateObject var otpVM = OTPViewModel(phoneNumberWithCountryCode: "+919876543212")
    
	var body: some View {
		PhoneNumberScreen()
		
//		NavigationStack {
//			VStack {
//				Button {
//					otpVM.otp = "1234"
//					otpVM.verifyOTP()
//				} label: {
//					Text("Test")
//				}
//			}
//			.navigationDestination(isPresented: $otpVM.shouldNavigateToNotes) {
//				if let response = otpVM.notesResponse {
//					NotesScreen(response: response)
//				}
//			}
//		}
		

    }
}

#Preview {
    ContentView()
}
