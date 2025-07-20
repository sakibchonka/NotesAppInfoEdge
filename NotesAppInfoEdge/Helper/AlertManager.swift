//
//  AlertManager.swift
//  NotesAppInfoEdge
//
//  Created by Mohammed Saqib on 20/07/25.
//

import Foundation

class AlertManager: ObservableObject {
	@Published var isPresented: Bool = false
	
	var title: String = ""
	var message: String = ""
	
	func show(title: String, message: String) {
		self.title = title
		self.message = message
		self.isPresented = true
	}
}
