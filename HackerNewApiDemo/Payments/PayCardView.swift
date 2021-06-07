//
//  PayCardView.swift
//  SwiftUIAnimations
//
//  Created by Jyothish New on 23/05/21.
//

import SwiftUI

struct PayCardView: View {
    
    let color : Color = .red.opacity(0.7)
    
    var body: some View {
        GeometryReader { gr in
            
            ZStack {
                HStack {
                    Spacer()
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundColor(color)
                        .frame(width: gr.size.width * 0.9, height: gr.size.width * 0.6)
                        .overlay(
                            GeometryReader { gr in
                                ZStack {
                                    VStack {
                                        HStack {
                                            Text("VISA")
                                                .font(.title2)
                                                .fontWeight(.bold)
                                                .foregroundColor(.white)
                                                .padding()
                                                .padding()
                                            Spacer()
                                        }
                                        Spacer()
                                        
                                        VStack(spacing: 0) {
                                            HStack {
                                                Text("12349 9129 2933 33")
                                                    .font(.title)
                                                    .fontWeight(.regular)
                                                    .foregroundColor(.white)
                                                    .padding(.horizontal)
                                                    .padding(.horizontal)
                                                    .padding(.bottom,10)
                                                    
                                                Spacer()
                                            }
                                            .frame(width: gr.size.width)
                                            
                                            HStack {
                                                Text("12/24")
                                                    .font(.subheadline)
                                                    .fontWeight(.light)
                                                    .foregroundColor(.white)
                                                    .padding(.horizontal)
                                                    .padding(.horizontal)
                                                    .padding(.bottom)
                                                    
                                                Spacer()
                                            }
                                            .frame(width: gr.size.width)
                                            
                                        }
                                        .frame(width: gr.size.width)


                                    }
                                    
                                    VStack {
                                        HStack(spacing:0) {
                                            Spacer()
                                            
                                            TriangleShapeStruct()
                                                .foregroundColor(color.opacity(0.4))
                                                .frame(width: 70, height: 70)
                                                .rotationEffect(Angle(degrees: 270))
                                                .offset(x: 70, y: 0)
                                            TriangleShapeStruct()
                                                .foregroundColor(color.opacity(0.4))
                                                .frame(width: 85, height: 85)
                                                .rotationEffect(Angle(degrees: 270))
                                                .offset(x: 40, y: 0)
                                            TriangleShapeStruct()
                                                .foregroundColor(color.opacity(0.4))
                                                .frame(width: 100, height: 100)
                                                .rotationEffect(Angle(degrees: 270))
                                        }
                                        .padding(.top,16)
                                        Spacer()
                                    }
                                    .frame(width: gr.size.width, height: gr.size.height)

                                    
                                }
                                .frame(width: gr.size.width, height: gr.size.height)
                            }
                        )
                    Spacer()
                }
            }
            
        }
    }
}

struct PayCardView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PayCardView()
            PayCardView()
                .previewDevice("iPhone 8")
        }
    }
}
