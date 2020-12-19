//
//  ContentView.swift
//  PhotoGallery
//
//  Created by Paul Carroll on 12/18/20.
//

import SwiftUI

struct PhotoGalleryView: View {
    @ObservedObject private var viewModel = PhotoGalleryViewModel()
    
    @State private var showingAlert = false
    
    var body: some View {
        List(viewModel.photos) { photo in
            Text(photo.title)
        }
        .onAppear {
            self.viewModel.getPhotos()
        }
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("Error fetching photos"),
                  message: Text("\(viewModel.networkError?.localizedDescription ?? "")"))
        }
        .onReceive(viewModel.$networkError) { output in
            showingAlert = (output != nil)
        }
    }
}

struct PhotoGalleryView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoGalleryView()
    }
}
