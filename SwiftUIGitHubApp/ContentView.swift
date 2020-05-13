//
//  ContentView.swift
//  SwiftUIGitHubApp
//
//  Created by Nikita Koniukh on 12/05/2020.
//  Copyright © 2020 Nikita Koniukh. All rights reserved.
//


import SwiftUI


struct ContentView: View {

    @State var reposArray = [Repo]()

    var body: some View {
        NavigationView{
            List(reposArray, id: \.name){ model in
                RepoCell(repoModel: model)
                    .shadow(color: .gray, radius: 4, x: 4, y: 4)
                    .padding(8.0)
            }
            .navigationBarTitle(Text("🔥HOT REPOS🔥 "))
            .onAppear(perform: loadData)
                /// removing separators from the list
            .onAppear(perform: {
                UITableView.appearance().separatorStyle = .none
            })
        }
    }

    func loadData() {
        DownloadService.instance.downloadTrendingRepos { (result) in
            DispatchQueue.main.async {
                self.reposArray = result
            }

        } 
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
