//
//  APODRow.swift
//  AstroPic
//
//  Created by Nimra Zafar on 30/04/2024.
//

import SwiftUI

struct APODRow: View {
    
    let photoInfo: PhotoInfo
    var body: some View {
        VStack(alignment: .leading){
            Text(photoInfo.date).bold()
            Text(photoInfo.title ?? "Nil")
        }
    }
}

#Preview {
    APODRow(photoInfo: PhotoInfo.createDefault()).previewLayout(.fixed(width: 400, height: 100))
}
