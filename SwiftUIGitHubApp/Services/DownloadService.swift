//
//  RepoService.swift
//  SwiftUIGitHubApp
//
//  Created by Nikita Koniukh on 12/05/2020.
//  Copyright © 2020 Nikita Koniukh. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage

class DownloadService {

    static let instance = DownloadService()
    typealias dictionary = Dictionary<String, Any>

    func downloadTrendingRepoDictArray(completion: @escaping (_ reposDictArray: [dictionary]) -> ()) {
        var trendingReposArray = [dictionary]()
        AF.request(TRENDING_REPO_URL).responseJSON { (response) in
            switch response.result {
            case .success(let value):
                guard let json = value as? dictionary,
                    let repoDictionaryArray = json["items"] as? [dictionary]
                    else { return }

                for dict in repoDictionaryArray {

                        let name = dict["name"] as? String
                        let description = dict["description"] as? String
                        let numberOfForks = dict["forks_count"] as? Int
                        let language = dict["language"] as? String
                        let repoUrl = dict["html_url"] as? String
                        let contributorsUrl = dict["contributors_url"] as? String
                        let ownerDict = dict["owner"] as? dictionary
                        let avatarUrl = ownerDict?["avatar_url"] as? String

                    let repoDictioanary: dictionary = ["name": name ?? "", "description": description ?? "", "forks_count": numberOfForks ?? 0, "language": language ?? "", "html_url": repoUrl ?? "", "contributors_url": contributorsUrl ?? "", "avatar_url": avatarUrl ?? ""]
                    trendingReposArray.append(repoDictioanary)
                }

            case .failure(let error):
                print(error.localizedDescription)

            }
            completion(trendingReposArray)
        }
    }

    func downloadTrendingRepos(completion: @escaping ([Repo]) -> ()) {
        var reposArray = [Repo]()
        downloadTrendingRepoDictArray { (trendingRepoDictArray) in
            for dict in trendingRepoDictArray {
                self.downloadTrendingRepo(fromDict: dict, completion: { (repo) in
                    reposArray.append(repo)
                    completion(reposArray)
                })
            }

        }
    }



    func downloadTrendingRepo(fromDict dict: dictionary, completion: @escaping (Repo) -> ()) {
        let avatarUrl = dict["avatar_url"] as? String ?? ""
        let name = dict["name"] as? String ?? ""
        let description = dict["description"] as? String ?? ""
        let numberOfForks = dict["forks_count"] as? Int ?? 0
        let language = dict["language"] as? String ?? ""
        let repoUrl = dict["html_url"] as? String ?? ""
        let contributorsUrl = dict["contributors_url"] as? String ?? ""

        self.downloadContributorsData(for: contributorsUrl) { (contributions) in
            self.downloadImage(for: avatarUrl) { (image) in
                let repo = Repo( image: image, name: name, description: description, numberOfForks: numberOfForks, language: language, contributers: contributions, repoUrl: repoUrl)
                completion(repo)
            }

        }
    }

    func downloadImage(for avatarUrl: String, completion: @escaping(UIImage) -> ()){
        
        AF.request(avatarUrl).responseImage { (imageResponse) in
            switch imageResponse.result {
            case .success(let image):
                completion(image)
            case .failure(let error):
                print(error)
            }
        }
    }

    func downloadContributorsData(for contributorsUrl: String, completion: @escaping (_ contributors: Int) -> ()) {
        AF.request(contributorsUrl).responseJSON { (response) in
            switch response.result {
            case .success(let value):
                guard let json = value as? dictionary else { return }
                if !json.isEmpty {
                    let contributions = json.count
                    completion(contributions)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

}
