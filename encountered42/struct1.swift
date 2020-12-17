// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
struct Welcome: Codable {
    let comment, feedback: String
    let corrector: Corrector
    let correcteds: [Corrector]
    //let team: Team
    //let feedbacks: [Feedback]
}

// MARK: - Corrector
struct Corrector: Codable {
    let id: Int
    let login: String
    let url: String
}

struct Team: Codable {
    let id: Int
    let name: String
    let url: String
    let finalMark, projectID: Int
    let createdAt, updatedAt, status: String
    let terminatingAt: String
    let users: [User]
    let locked, validated, closed: Bool
    let repoURL, repoUUID, lockedAt, closedAt: String
    let projectSessionID: Int
    let projectGitlabPath: String

    enum CodingKeys: String, CodingKey {
        case id, name, url
        case finalMark = "final_mark"
        case projectID = "project_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case status
        case terminatingAt = "terminating_at"
        case users
        case locked = "locked?"
        case validated = "validated?"
        case closed = "closed?"
        case repoURL = "repo_url"
        case repoUUID = "repo_uuid"
        case lockedAt = "locked_at"
        case closedAt = "closed_at"
        case projectSessionID = "project_session_id"
        case projectGitlabPath = "project_gitlab_path"
    }
}

struct User: Codable {
    let id: Int
    let login: String
    let url: String
    let leader: Bool
    let occurrence: Int
    let validated: Bool
    let projectsUserID: Int

    enum CodingKeys: String, CodingKey {
        case id, login, url, leader, occurrence, validated
        case projectsUserID = "projects_user_id"
    }
}
