//
//  Repo.swift
//  SwiftUIGitHubApp
//
//  Created by Nikita Koniukh on 12/05/2020.
//  Copyright © 2020 Nikita Koniukh. All rights reserved.
//

import SwiftUI

class Repo: ObservableObject {

    let image: UIImage?
    let name: String
    let description: String
    let numberOfForks: Int
    let language: String
    let contributers: Int
    let repoUrl: String

    init(image: UIImage, name: String, description: String, numberOfForks: Int, language: String, contributers: Int, repoUrl: String) {
        self.image = image
        self.name = name
        self.description = description
        self.numberOfForks = numberOfForks
        self.language = language
        self.contributers = contributers
        self.repoUrl = repoUrl
    }
}


