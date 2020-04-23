//
//  Model.swift
//  UnwindApp
//
//  Created by Arthur Bastos Fanck on 06/04/20.
//  Copyright © 2020 Annderson Packeiser Oreto. All rights reserved.
//

import Foundation

struct Patient: Identifiable {
    let id = UUID()
    let name: String
    let email: String
    let phoneNumber: String
    let imageName: String = "default"
}

let patient0 = Patient(name: "Vitor", email: "vitor@gmail.com", phoneNumber: "51989878789")
let patient1 = Patient(name: "Arthur", email: "arthur@gmail.com", phoneNumber: "51989878789")
let patient2 = Patient(name: "Carlos", email: "carlos@gmail.com", phoneNumber: "51989878789")
let patient3 = Patient(name: "Marcus", email: "marcus@gmail.com", phoneNumber: "51989878789")
let patient4 = Patient(name: "Daniela", email: "daniela@gmail.com", phoneNumber: "51989878789")
let patient5 = Patient(name: "Annderson", email: "chumiga@gmail.com", phoneNumber: "51989878789")
let fakePatients = [patient0, patient1, patient2, patient3, patient4, patient5]

struct Feeling: Identifiable, Hashable {
    let id: Int
    let imageName: String
    let description: String
    let color: CustomColor
}

let fakeFeeling = Feeling(id: 0, imageName: "Image", description: "Muito Feliz", color: .feelingBorder)

struct Emotion: Identifiable, Hashable {
    let id = UUID()
    let imageName:String = "Image"
    let name: String
}

let emotion0 = Emotion(name: "Alegre")
let emotion1 = Emotion(name: "Amoroso")
let emotion2 = Emotion(name: "Feliz")
let fakeEmotions = [emotion0, emotion1, emotion2]


struct UserReport {
    let id = UUID()
    let feeling: Feeling
    let emotions: [Emotion]
    let situation: String
    let thought: String
    let action: String
    let date: Date
}

let report0 = UserReport(feeling: fakeFeeling, emotions: fakeEmotions, situation: "Situation", thought: "Thought", action: "Action", date: Date())
let report1 = UserReport(feeling: fakeFeeling, emotions: fakeEmotions, situation: "Situation", thought: "Thought", action: "Action", date: Date())
let report2 = UserReport(feeling: fakeFeeling, emotions: fakeEmotions, situation: "Situation", thought: "Thought", action: "Action", date: Date())
let report3 = UserReport(feeling: fakeFeeling, emotions: fakeEmotions, situation: "Situation", thought: "Thought", action: "Action", date: Date())
var fakeReports: [Feelings] = []
var profileName: String = ""
