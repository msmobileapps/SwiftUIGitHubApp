//
//  Loader.swift
//  SwiftUIGitHubApp
//
//  Created by Nikita Koniukh on 17/05/2020.
//  Copyright © 2020 Nikita Koniukh. All rights reserved.
//

import SwiftUI


struct Loader: View {
       @State var animationAmount: CGFloat = 1

    var body: some View {
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
    }
}
