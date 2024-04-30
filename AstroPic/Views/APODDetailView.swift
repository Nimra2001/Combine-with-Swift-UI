//
//  APODDetailView.swift
//  AstroPic
//
//  Created by Nimra Zafar on 30/04/2024.
//

import SwiftUI

struct APODDetailView: View {
    
    init(photoInfo: PhotoInfo, manager: MultiNetworkManager) {
        print("init detail for \(photoInfo.date)")
        self.photoInfo = photoInfo
        self.manager = manager
    }
    
    @ObservedObject var manager: MultiNetworkManager
    let photoInfo: PhotoInfo
    
    var body: some View {
        VStack {
            if photoInfo.image != nil {
                
                Image(uiImage: self.photoInfo.image!)
                    .resizable()
                    .scaledToFit()
//                    .overlay(      NavigationLink(destination: InteractiveImageView(image: photoInfo.image!)) {
//                        Image(systemName: "magnifyingglass.circle.fill")
//                            .font(.title).padding()
//                    }, alignment: .bottomTrailing)
               }else {
                   Rectangle().fill(Color(.gray))
                       .frame( height: 200)
               }
            
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    
                    Text(photoInfo.title!).font(.headline)
                    Text(photoInfo.description!)
                }
            }.padding()
            
        }
        .navigationBarTitle(Text(photoInfo.date), displayMode: .inline)
        .onAppear {
            self.manager.fetchImage(for: self.photoInfo)
        }
    }
}
#Preview {
    APODDetailView(photoInfo: PhotoInfo.createDefault(), manager: MultiNetworkManager())
}
