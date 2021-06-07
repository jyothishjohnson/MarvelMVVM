//
//  PayHome.swift
//  SwiftUIAnimations
//
//  Created by Jyothish New on 22/05/21.
//

import SwiftUI

struct PayHome: View {
    
    @State private var currentTabSelection : Int = 1

    var body: some View {
        ZStack {
            VStack {
                PaymentHeaderView()
                
                
                PayCardView()
                    .frame(height: 250)
                        
                
                PaymentFriendsListView()

                
                PayRecentExpensesView()
                
                Spacer()

            }
            
//            PayHomeTabView(currentTabSelection: $currentTabSelection)
        }
    }
}

struct PayHome_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PayHome()
            PayHome()
                .previewDevice("iPhone 8")
        }
    }
}

struct PaymentFriendsListView: View {
    var body: some View {
        HStack{
            ScrollView(.horizontal, showsIndicators: false){
                HStack {
                    VStack {
                        Image(systemName: "plus")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .foregroundColor(.white)
                    }
                    .frame(width: 72, height: 72)
                    .background(Color(.sRGB, red: 0.2521404922, green: 0.1859147549, blue: 0.276812464, opacity: 1))
                    .cornerRadius(14)
                    
                    ForEach((1...7), id: \.self) { val in
                        Image("\(val)")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 52, height: 52)
                            .padding(10)
                            .cornerRadius(14)
                            .overlay(
                                RoundedRectangle(cornerRadius: 14)
                                    .stroke(lineWidth: 1)
                                    .foregroundColor(.gray.opacity(0.5))
                            )
                            .padding(2)
                    }
                }
            }
        }
        .frame(height: 72)
        .padding(.leading)
    }
}

struct PaymentHeaderView: View {
    var body: some View {
        HStack{
            VStack(alignment: .leading) {
                
                Text("Morning")
                    .font(.caption)
                    .fontWeight(.light)
                Text("Susan")
                    .font(.title)
                    .fontWeight(.regular)
                
            }
            Spacer()
            
            Circle()
                .foregroundColor(.offWhite)
                .frame(width: 72, height: 72)
                .overlay(
                    Image("8")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 48, height: 48)
                )
            
        }
        .frame(height: 72)
        .padding(.horizontal)
    }
}

struct PayHomeTabView: View {
    
    @Binding var currentTabSelection : Int
    var body: some View {
        VStack {
            Spacer()
            
            HStack {
                Spacer()
                Image(systemName: currentTabSelection == 1 ? "square.grid.2x2.fill" : "square.grid.2x2")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .padding()
                    .foregroundColor(Color(.sRGB, red: 0.2521404922, green: 0.1859147549, blue: 0.276812464, opacity: currentTabSelection == 1 ? 1 : 0.4))
                    .animation(.easeIn)
                    .onTapGesture {
                        currentTabSelection = 1
                    }
                
                Spacer()
                Image(systemName: currentTabSelection == 2 ? "clock.fill" : "clock")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .padding()
                    .foregroundColor(Color(.sRGB, red: 0.2521404922, green: 0.1859147549, blue: 0.276812464, opacity: currentTabSelection == 2 ? 1 : 0.4))
                    .animation(.easeIn)
                    .onTapGesture {
                        currentTabSelection = 2
                    }
                
                Spacer()
                Image(systemName: currentTabSelection == 3 ? "checkmark.square.fill" : "checkmark.square")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .padding()
                    .foregroundColor(Color(.sRGB, red: 0.2521404922, green: 0.1859147549, blue: 0.276812464, opacity: currentTabSelection == 3 ? 1 : 0.4))
                    .animation(.easeIn)
                    .onTapGesture {
                        currentTabSelection = 3
                    }
                
                Spacer()
                Image(systemName: currentTabSelection == 4 ? "gearshape.fill" : "gearshape")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .padding()
                    .foregroundColor(Color(.sRGB, red: 0.2521404922, green: 0.1859147549, blue: 0.276812464, opacity: currentTabSelection == 4 ? 1 : 0.4))
                    .animation(.easeIn)
                    .onTapGesture {
                        currentTabSelection = 4
                    }
                Spacer()
                
            }
            
            .background(Color.white)
            .frame(height: 60)
        }
    }
}
