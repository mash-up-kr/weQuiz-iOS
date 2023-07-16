//
//  PageView.swift
//  HomeUI
//
//  Created by 최원석 on 2023/07/14.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import SwiftUI

struct TestFlipView: View {
    @State var isFaceUp = false
    @State var imageIndex = 0
    @State var dirIndex = 0
    
    var body: some View {
        VStack {
            Text("Flip card on each Axis")
                .font(.title)
                .fontWeight(.bold)
            
            HStack(spacing: 40) {
                VStack {
                    CardView(isFaceUp: isFaceUp, imageName: "trash", axis: (0,1,0))
                        .animation(.linear(duration: 0.3))
                        .frame(width: 100, height: 100)
                    Text("x-axis")
                    
                    Spacer().frame(height: 40)
                    
                    Button("flip card") {
                        isFaceUp.toggle()
                    }
                    
                    Spacer()
                }
            }
        }
    }
}


struct CardView: View {
    var isFaceUp: Bool
    var imageName = "trash"
    var axis: (CGFloat,CGFloat,CGFloat) = (0.0,1.0,0.0)
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(red: 0.97, green: 0.85, blue: 0.55))
                .shadow(radius: 5)
            Image(imageName)
                .resizable()
                .scaledToFit()
                .clipped()
                .cornerRadius(15.0)
                .padding(10)
            VStack {
                Spacer()
                HStack {
                    Text(imageName.capitalized)
                        .font(.caption)
                        .foregroundColor(Color(red: 0.09, green: 0, blue: 0.30))
                        .padding(5)
                        .padding(.horizontal, 10)
                        .background(Color(red: 0.97, green: 0.85, blue: 0.55)).opacity(0.5)
                        .cornerRadius(10)
                }
            }
            .padding()
        }
//        .cardFilp(isFaceUp: isFaceUp, axis: axis)
    }
}

struct PageView_Previews: PreviewProvider {
    static var previews: some View {
        TestFlipView()
    }
}
