//
//  HomeScreen.swift
//  NotesAppInfoEdge
//
//  Created by Mohammed Saqib on 19/07/25.
//

import SwiftUI

struct NotesScreen: View {
	let response: NotesAPIModel
	
	@State private var selectedTab = 1
	
	var body: some View {
		TabView(selection: $selectedTab) {
			PlaceholderView(title: "discover").tabItem {
				Image(systemName: "square.grid.2x2")
					.font(.subheadline)
				Text("Discover")
			}
			.tag(0)
			
			NotesView(response: response).tabItem {
				Image(systemName: "envelope")
					.font(.subheadline)
				Text("Notes")
			}
			.tag(1)
			
			PlaceholderView(title: "matches").tabItem {
				Image(systemName: "message")
					.font(.subheadline)
				Text("Matches")
			}
			.tag(2)
			
			PlaceholderView(title: "profile").tabItem {
				Image(systemName: "person")
					.font(.subheadline)
				Text("Profile")
			}
			.tag(3)
		}
		.navigationBarBackButtonHidden(true)
	}
}

