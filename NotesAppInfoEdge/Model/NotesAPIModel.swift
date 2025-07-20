//
//  NotesAPIModel.swift
//  NotesAppInfoEdge
//
//  Created by Mohammed Saqib on 19/07/25.
//

struct NotesAPIModel: Decodable {
	let invites: Invites
	let likes: Likes
}

struct Invites: Decodable {
	let profiles: [InviteProfile]
}

struct Likes: Decodable {
	let profiles: [LikeProfile]
	let canSeeProfile: Bool
	
	enum CodingKeys: String, CodingKey {
		case profiles
		case canSeeProfile = "can_see_profile"
	}
}

struct InviteProfile: Decodable {
	let generalInformation: GeneralInformation
	let photos: [Photo]
	
	enum CodingKeys: String, CodingKey {
		case generalInformation = "general_information"
		case photos
	}
}

struct GeneralInformation: Decodable {
	let firstName: String
	let age: Int
	
	enum CodingKeys: String, CodingKey {
		case firstName = "first_name"
		case age
	}
}

struct Photo: Decodable {
	let photo: String
}

struct LikeProfile: Decodable {
	let firstName: String
	let avatar: String
	
	enum CodingKeys: String, CodingKey {
		case firstName = "first_name"
		case avatar
	}
}
