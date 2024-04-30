//
//  PicofTodayView.swift
//  AstroPic
//
//  Created by Nimra Zafar on 24/04/2024.
//

import Foundation
import SwiftUI

struct PicofTodayView: View{
    
    @ObservedObject var manager = NetworkManager()
    @State private var showSwitchData: Bool = false
    var body: some View{
        
        VStack(alignment: .center, spacing: 15){
            
            Button(action:{
                self.showSwitchData.toggle()
            }) {
                Image(systemName: "calendar")
                Text("Switch Day")
            }.padding(.trailing)
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .trailing)
                .popover(isPresented: $showSwitchData){
                    SelectDateView(manager: self.manager)
                }
            
            if manager.image != nil {
                Image(uiImage: self.manager.image!)
                    .resizable()
                    .scaledToFit()
            }else{
                Rectangle().fill(Color(.gray))
                    .frame( height: 200)
            }
            
            ScrollView{
                VStack(alignment: .leading, spacing: 15){
                    Text(manager.photoInfo.date ?? "NO Date").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    Text(manager.photoInfo.title ?? "No Title").font(.headline)
                    Text(manager.photoInfo.description ?? "No Description")        
                }
            }
            
            
        }.padding()
    }
}

#Preview {
    let view = PicofTodayView()
    view.manager.photoInfo = PhotoInfo.createDefault()
    view.manager.image  = UIImage(named: "preview_image")!
    return view
}
