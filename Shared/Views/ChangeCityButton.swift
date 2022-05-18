//
//  ChangeCityButton.swift
//  OWeatherApp (iOS)
//
//

import SwiftUI

struct ChangeCityButton: View {
    
    private let gradient = [Color.red, Color.blue]
    
    var body: some View {
        Button(action: {
            print("tapped!")
        }) {
            HStack {
                Image(systemName: "pencil.circle.fill")
                Text("Change city")
            }
        }
        .font(.system(size: 16, weight:.bold, design: .rounded))
        .frame(height: 16)
        .foregroundColor(.white)
        .padding(.horizontal)
        .padding(8)
        .background(LinearGradient(gradient: Gradient(colors: gradient),
                                   startPoint: .leading,
                                   endPoint: .trailing))
        .cornerRadius(32)
        .shadow(color:.black, radius: 4)
    }
    
}


struct ChangeCityButton_Previews: PreviewProvider {
    static var previews: some View {
        ChangeCityButton()
    }
}

