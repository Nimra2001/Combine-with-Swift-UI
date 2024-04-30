//
//  APODListView.swift
//  AstroPic
//
//  Created by Nimra Zafar on 29/04/2024.
//

import SwiftUI

struct APODListView: View {
    @ObservedObject var manager = MultiNetworkManager()
    var body: some View {
        NavigationView{
            List{
                ForEach(manager.infos) { info in
                    NavigationLink(destination: APODDetailView(photoInfo: info, manager: manager)){
                        APODRow(photoInfo: info)
                    }
                    .onAppear
                    {
                        //if we have 5 last data
                        if let index = self.manager.infos.firstIndex(where: {
                            ($0.id == info.id)}), index > self.manager.infos.count - 1 && self.manager.daysFromToday == self.manager.infos.count - 1 {
                            self.manager.getMoreData(for: 1)
                        }
                    }
                }
                
                //            APODRow(photoInfo: PhotoInfo())
                //                .background(Color.gray)
                //                .onAppear{
                //                    self.manager.getMoreData(for: 1)
                //                }
                //                Rectangle()
                //                    .fill(Color.gray).opacity(0.3)
                //                    .frame(height: 50)
                //                    .onAppear{
                //                        print("in on appear")
                //                        if self.manager.infos.count > 10 {
                //                            self.manager.getMoreData(for: 10)
                //                        }
                //                    }
                ForEach(0..<15){ _ in
                    Rectangle()
                        .fill(Color.gray).opacity(0.3)
                        .frame(height: 50)
                }
            }.navigationTitle("Picture of the Day")
        }
    }
}

#Preview {
    APODListView()
}
