//
//  NotesView.swift
//  NotesAppInfoEdge
//
//  Created by Mohammed Saqib on 19/07/25.
//

import SwiftUI

struct NotesView: View {
	let response: NotesAPIModel
	
	var body: some View {
		VStack(alignment: .leading, spacing: 20.0) {
			HeaderView()
			
			if let firstInvite = response.invites.profiles.first {
				HighlightedNoteCard(profile: firstInvite)
			}
			
			LikesRow(profiles: response.likes.profiles)
				.padding(.top)
		}
		.padding()
	}
}

struct HeaderView: View {
	var body: some View {
		VStack(alignment:.center, spacing: 4) {
			Text("Notes")
				.font(.title.bold())
			
			Text("Personal messages to you")
				.fontWeight(.medium)
		}
		.frame(maxWidth: .infinity)
	}
}

struct HighlightedNoteCard: View {
	let profile: InviteProfile
	var body: some View {
		VStack(alignment: .leading) {
			AsyncImage(url: URL(string: profile.photos.first?.photo ?? "")) { image in
				image.resizable()
			} placeholder: {
				Color.gray
			}
		}
		.clipShape(.rect(cornerRadius: 15.0))
		.overlay (
			VStack(alignment: .leading) {
				
				Text("\(profile.generalInformation.firstName), \(profile.generalInformation.age)")
					.font(.title2.bold())
					.foregroundStyle(.white)
				
				Text("Tap to review 50+ notes")
					.font(.subheadline)
					.foregroundStyle(.white)
			}
				.padding(), alignment: .bottomLeading
		)
	}
}

struct LikesRow: View {
	let profiles: [LikeProfile]
	
	var body: some View {
		
		VStack(alignment: .leading) {
			
			Text("Interested In You")
				.fontWeight(.bold)
			HStack {
				Text("Premium members can view all their likes at once")
					.font(.subheadline)
					.foregroundColor(.gray)
					.multilineTextAlignment(.leading)
					.lineLimit(nil)
				
				Spacer()
				
				Button("Upgrade") {
					// trigger upgrade
				}
				.fontWeight(.bold)
				.foregroundStyle(.black)
				.padding(.horizontal)
				.padding(.vertical, 12)
				.background(Color.yellow)
				.clipShape(Capsule())
			}
			
			ScrollView(.horizontal, showsIndicators: false) {
				HStack {
					ForEach(profiles, id: \.firstName) { profile in
						VStack {
							AsyncImage(url: URL(string: profile.avatar)) { image in
								image.resizable()
							} placeholder: {
								Color.gray
							}
							.frame(width: 120, height: 180)
							.blur(radius: 10)
							.cornerRadius(12)
							
							Text(profile.firstName)
								.font(.caption.bold())
								.foregroundColor(.white)
						}
					}
				}
			}
		}
	}
}
