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
    @State var isActivityShow = true
    @State var animationAmount: CGFloat = 1

    var body: some View {
        NavigationView{

            if isActivityShow {

                Button("Loading..."){
                }
                .padding(40)
                .background(Color.red)
                .foregroundColor(Color.white)
                .clipShape(Circle())
                .overlay(
                    Circle()
                        .stroke(Color.red)
                        .scaleEffect(animationAmount)
                        .opacity(Double(2 - animationAmount))
                        .animation(
                            Animation.easeInOut(duration:2)
                                .repeatForever(autoreverses: false)
                    )
                )
                    .onAppear {
                        self.animationAmount = 2
                }

                //                ActivityIndicator()
                //                    .frame(width: 100, height: 100)
                //                    .foregroundColor(Color.gitHubCoral)
            } else {
                List(reposArray, id: \.name){ model in
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
        .onAppear(perform: loadData)
    }


    func loadData() {
        DownloadService.instance.downloadTrendingRepos { (result) in
            DispatchQueue.main.async {
                self.isActivityShow = false
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

struct ActivityIndicator: View {

    @State var isAnimating: Bool = false

    var body: some View {
        GeometryReader { (geometry: GeometryProxy) in
            ForEach(0..<5) { index in
                Group {
                    Circle()
                        .frame(width: geometry.size.width / 5, height: geometry.size.height / 5)
                        .scaleEffect(!self.isAnimating ? 1 - CGFloat(index) / 5 : 0.2 + CGFloat(index) / 5)
                        .offset(y: geometry.size.width / 10 - geometry.size.height / 2)
                }.frame(width: geometry.size.width, height: geometry.size.height)
                    .rotationEffect(!self.isAnimating ? .degrees(0) : .degrees(360))
                    .animation(Animation
                        .timingCurve(0.5, 0.15 + Double(index) / 5, 0.25, 1, duration: 1.5)
                        .repeatForever(autoreverses: false))
            }
        }
        .aspectRatio(1, contentMode: .fit)
        .onAppear {
            self.isAnimating = true
        }
    }
}
