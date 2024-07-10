//
//  PhotoDetailView.swift
//  FlickerApp
//
//  Created by Naveen Reddy on 09/07/24.
//

import SwiftUI

struct PhotoDetailView: View {
    let photo: Photo
    @Binding var isDetailViewPresented: Bool
    
    var body: some View {
        VStack {
            CustomAsyncImage(url: photo.imageURL)
                .cornerRadius(Corners.xl)
                .padding()
            Text("Title" + ": " + photo.title)
                .font(.title)
                .foregroundColor(Colors.accent)
                .multilineTextAlignment(.leading)
                .padding()
            
            Text("Secret" + ": " + photo.secret)
                .font(.title)
                .foregroundColor(Colors.accent)
                .padding()
            Spacer()
        }
        .navigationTitle("Photo Detail")
    }
}

struct PhotoDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoDetailView(photo: Photo(id: "", title: "", farm: 1, server: "", secret: ""), isDetailViewPresented: .constant(false))
    }
}


