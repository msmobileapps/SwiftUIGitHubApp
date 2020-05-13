//
//  RepoCell.swift
//  SwiftUIGitHubApp
//
//  Created by Nikita Koniukh on 13/05/2020.
//  Copyright © 2020 Nikita Koniukh. All rights reserved.
//

import SwiftUI

struct RepoCell: View {
    @State var repoModel: Repo
    static var imagePlaceHolder = UIImage(named: "image_placeholder")
    
    var body: some View {
        
        VStack(alignment: .center, spacing: 0.0){
            Text(repoModel.name)
                .font(.headline)
                .foregroundColor(Color.gitHubText)
                .padding()
            Text(repoModel.description)
                .font(.subheadline)
                .fontWeight(.medium)
                .foregroundColor(Color.gitHubText)
                .padding([.leading, .bottom, .trailing])
            Image(uiImage: repoModel.image ?? RepoCell.imagePlaceHolder! )
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(.bottom)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 180)

            HStack(alignment: .center) {

                Group {
                    Image("updates")
                        .resizable()
                        .frame(width: 25, height: 25, alignment: .center)

                    Text(String(repoModel.numberOfForks))
                        .font(.system(size: 17))
                        .fontWeight(.regular)
                        .foregroundColor(Color.gitHubText)
                        .multilineTextAlignment(.leading)
                }

                Divider()
                    .frame(width: 3)
                    .background(Color.gitHubText)

                Group {
                    Image("code")
                        .resizable()
                        .frame(width: 25, height: 25, alignment: .center)

                    Text(repoModel.language)
                        .font(.system(size: 17))
                        .fontWeight(.regular)
                        .foregroundColor(Color.gitHubText)
                        .multilineTextAlignment(.leading)
                        .frame(minWidth: 0, maxWidth: 50)
                }

                Divider()
                    .frame(width: 3)
                    .background(Color.gitHubText)

                Group {
                    Image("conference")
                        .resizable()
                        .frame(width: 25, height: 25, alignment: .center)

                    Text(String(repoModel.contributers))
                        .font(.system(size: 17))
                        .fontWeight(.regular)
                        .foregroundColor(Color.gitHubText)
                        .multilineTextAlignment(.leading)
                        .frame(minWidth: 0, maxWidth: 60)
                }

            }
            .padding()
            .frame(height: 40.0)
        }
        .padding()
            
        .background(Color.white)
        .cornerRadius(10)
        .clipped()
    }
}

struct RepoCell_Previews: PreviewProvider {
    static var previews: some View {
        Text("Hello Nikita!")
    }
}
