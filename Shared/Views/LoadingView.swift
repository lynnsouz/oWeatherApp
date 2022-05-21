//
//  LoadingView.swift
//  OWeatherApp (iOS)
//
//  Created by Lyn on 20/05/22.
//

import SwiftUI

struct LoadingView: View {
    
    var body: some View {
        Spacer()
        ProgressView("Loading...")
            .progressViewStyle(CircularProgressViewStyle(tint: .white))
            .foregroundColor(.white)
            .font(.system(size: 32, weight: .medium, design: .default))
            .padding()
        Spacer()
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
