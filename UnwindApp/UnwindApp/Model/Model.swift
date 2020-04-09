//
//  Model.swift
//  UnwindApp
//
//  Created by Arthur Bastos Fanck on 06/04/20.
//  Copyright © 2020 Annderson Packeiser Oreto. All rights reserved.
//

import Foundation

struct Patient: Identifiable {
    let id: Int
    let name: String
    let email: String
    let phoneNumber: String
    let imageData: Data
}

let patient0 = Patient(id: 0, name: "Vitor", email: "vitor@gmail.com", phoneNumber: "51989878789", imageData: Data())
let patient1 = Patient(id: 1, name: "Arthur", email: "arthur@gmail.com", phoneNumber: "51989878789", imageData: Data())
let patient2 = Patient(id: 2, name: "Carlos", email: "carlos@gmail.com", phoneNumber: "51989878789", imageData: Data())
let fakePatients = [patient0, patient1, patient2]

struct Feeling: Identifiable {
    let id: Int
    let imageName: String
    let description: String
}

let fakeFeeling = Feeling(id: 0, imageName: "image", description: "Muito Feliz")

struct Emotion: Identifiable {
    let id: Int
    let imageName: String
    let description: String
}

let emotion0 = Emotion(id: 0, imageName: "image", description: "Alegre")
let emotion1 = Emotion(id: 1, imageName: "image", description: "Amoroso")
let emotion2 = Emotion(id: 2, imageName: "image", description: "Feliz")
let fakeEmotions = [emotion0, emotion1, emotion2]
