//
//  PlaceholderView.swift
//  NotesAppInfoEdge
//
//  Created by Mohammed Saqib on 19/07/25.
//

import SwiftUI

struct PlaceholderView: View {
	let title: String
	var body: some View {
		VStack {
			Image(systemName: "hourglass")
				.font(.largeTitle)
				.padding(.bottom)
			Text(title)
				.font(.title2)
				.foregroundColor(.gray)
		}
	}
}
