//
//  MainImageView.swift
//  SwiftUIGitHubApp
//
//  Created by Nikita Koniukh on 13/05/2020.
//  Copyright © 2020 Nikita Koniukh. All rights reserved.
//

import SwiftUI

struct MainImageView: View {
    
    static var imagePlaceHolder = UIImage(named: "image_placeholder")
    @State var repoModel: Repo?
    
    var image: UIImage?
    
    var body: some View {

        Image(uiImage: repoModel?.image ?? MainImageView.imagePlaceHolder! )
            .resizable()
            .scaledToFit()
            .frame(width: 100, height: 100)
    }


    

}

struct MainImageView_Previews: PreviewProvider {
    static var previews: some View {
        //MainImageView(repoModel: nil)
        Text("He")
    }
}
