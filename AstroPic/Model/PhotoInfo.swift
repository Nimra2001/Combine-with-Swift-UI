//
//  PhotoInfo.swift
//  AstroPic
//
//  Created by Nimra Zafar on 24/04/2024.
//

import Foundation
import SwiftUI

struct PhotoInfo: Codable, Identifiable {
    var title: String?
    var description: String?
    var url: URL?
    var copyRight: String?
    var date: String
    
    let id = UUID()
    
    var image: UIImage? = nil
    
    var formattedDate: Date{
        let dateFormatter = API.createFormatter()
        return dateFormatter.date(from: self.date) ?? Date()
    }
    enum CodingKeys: String, CodingKey {
        
        case title = "title"
        case description = "explanation"
        case url = "url"
        case copyRight = "copyright"
        case date = "date"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decodeIfPresent(String.self, forKey: .title)
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
        self.url = try container.decodeIfPresent(URL.self, forKey: .url)
        self.copyRight = try container.decodeIfPresent(String.self, forKey: .copyRight)
        self.date = try container.decodeIfPresent(String.self, forKey: .date)!
    }
    
    init(){
        self.description = ""
        self.title = ""
        self.date = ""
    }
    
    
    static func createDefault() -> PhotoInfo {
        var photoInfo = PhotoInfo()
        photoInfo.title = "ddsfdsf"
        photoInfo.description = "erqwr"
        photoInfo.date = "33224223224"
        return photoInfo
    }
}


