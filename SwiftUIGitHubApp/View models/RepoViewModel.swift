//
//  RepoViewModel.swift
//  SwiftUIGitHubApp
//
//  Created by Nikita Koniukh on 17/05/2020.
//  Copyright © 2020 Nikita Koniukh. All rights reserved.
//

import Combine

final class RepoViewModel: ObservableObject {

    init() {
        fetchRepo()
    }

    @Published var isLoading = true
    
    @Published var repos = [Repo]() {
        didSet {
            didChange.send(self)
        }
    }

    func fetchRepo() {
        DownloadService().downloadTrendingRepos { (reposResult) in
            self.repos = reposResult
            self.isLoading = false
        }
    }
    
    let didChange = PassthroughSubject<RepoViewModel, Never>()
}
