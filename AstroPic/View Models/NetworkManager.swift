//
//  NetworkManager.swift
//  AstroPic
//
//  Created by Nimra Zafar on 24/04/2024.
//

import Foundation
import Combine
import SwiftUI


class NetworkManager: ObservableObject{
    
    @Published var date: Date = Date()
    
    
    @Published var photoInfo = PhotoInfo()
    @Published var image: UIImage? = nil
    
    private var subscriptions = Set<AnyCancellable>()
    
    init() {
//        //create URL
//        let url =  URL(string: Constants.baseUrl)
//        let fullUrl = url?.withQuery(["api_key" : Constants.key])!
//        print(fullUrl!.absoluteString)
//        
        $date.removeDuplicates()
            .sink{(value) in
                self.image = nil
            }.store(in: &subscriptions)
        
        
        $date.removeDuplicates()
            .map{
                API.createURL(for:$0)
            }.flatMap { (url) in
                API.createPublisher(url: url)
//                URLSession.shared.dataTaskPublisher(for: url)
//                    .map(\.data)
//                    .decode(type: PhotoInfo.self, decoder: JSONDecoder())
//                    .catch {
//                        (error) in
//                        //A publisher that emits an output to each subscriber just once, and then finishes.
//                        Just(PhotoInfo())
//                    }
            }
            .receive(on: RunLoop.main)
            .assign(to: \.photoInfo , on:  self)
            .store(in: &subscriptions)
        
        $photoInfo.filter { $0.url != nil }
            .map {
                photoInfo -> URL in
                return photoInfo.url!
            }.flatMap{(url) in
                URLSession.shared.dataTaskPublisher(for: url)
                    .map(\.data)
                    .catch({error in
                        return Just(Data())
                    })
            }.map{ (out) -> UIImage? in
                UIImage(data: out)
                
            }
            .receive(on: RunLoop.main)
            .assign(to: \.image, on: self)
            .store(in: &subscriptions)
        //            .sink(receiveCompletion: {(completion) in switch completion {
        //        case .finished:
        //            print("fetch request finished")
        //        case .failure(let failure):
        //            print("fetch complete with failure: \(failure.localizedDescription)")
        //        }
        //        }) { (data, response) in
        //            if let description = String(data:data, encoding: .utf8) {
        //                print("fetched new data is \(description)")
        //            }
        //        }.store(in: &subscriptions)
    }
    
//    func createUrl(for date: Date) -> URL {
//        let formatter =  DateFormatter()
//        formatter.dateFormat = "yyyy-MM-dd"
//        let dateString = formatter.string(from: date)
//        let url = URL(string: Constants.baseUrl)!
//        let fullURL = url.withQuery(["api_key" : Constants.key , "date" : dateString])!
//        return fullURL
//    }
}
