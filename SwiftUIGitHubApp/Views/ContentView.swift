//
//  ContentView.swift
//  SwiftUIGitHubApp
//
//  Created by Nikita Koniukh on 12/05/2020.
//  Copyright © 2020 Nikita Koniukh. All rights reserved.
//


import SwiftUI


struct ContentView: View {

    @ObservedObject var repoViewModel = RepoViewModel()
    
    var body: some View {
        NavigationView{

            if repoViewModel.isLoading {
                Loader()
            } else {
                List(repoViewModel.repos){ model in
                    RepoCell(repoModel: model)
                        .shadow(color: .gray, radius: 4, x: 4, y: 4)
                        .padding(8.0)
                }
                .navigationBarTitle(Text("🔥HOT REPOS🔥 "))
                    /// removing separators from the list
                    .onAppear(perform: {
                        UITableView.appearance().separatorStyle = .none
                    })
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
