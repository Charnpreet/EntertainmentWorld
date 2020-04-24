//
//  DBConnection.swift
//  EntainmentWorld
//
//  Created by CHARNPREET SINGH on 11/4/20.
//  Copyright © 2020 CHARNPREET SINGH. All rights reserved.
//
import Foundation
import UIKit
class DBConnection {
    // generic method to load data from themoviedatabase
    //  where  T is decodable class
    public func loadMoviesFromDB<T:Decodable>(pageNO: Int, route: String,completionHandler:@escaping(T)->Void){
        
        guard let url = URL(string: "\(Connection.API_BASE_URL)\(route)\(Connection.API_KEY)\(Connection.PAGE)\(pageNO)") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if (error != nil){
                print ("error")
            }else{
                do{
                    guard let data = data else { return }
                    let deocder = JSONDecoder()
                    deocder.keyDecodingStrategy = .convertFromSnakeCase
                    let movies = try JSONDecoder().decode(T.self, from: data)
                    DispatchQueue.main.async {
                        completionHandler(movies)
                    }
                } catch{
                    print(error)
                }
                
            }
        }
        task.resume()
    }
    
    
    func searchDataBase<T:Decodable>(pageNO: Int, route: String,query: String, completionHandler:@escaping(T)->Void){
        let urlString = "\(Connection.API_BASE_URL)\(route)\(Connection.API_KEY)\(Routes.SEARCH_QUERY)\(query)\(Connection.PAGE)\(pageNO)"
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if (error != nil){
                print ("error")
            }else{
                do{
                    guard let data = data else { return }
                    let movies = try JSONDecoder().decode(T.self, from: data)
                    DispatchQueue.main.async {
                        print(query)
                        completionHandler(movies)
                    }
                } catch{
                    print(error)
                }
                
            }
        }
        task.resume()
    }
    
    func LoadGenre<T:Decodable>(route: String, completionHandler:@escaping(T)->Void){
        
        let urlString = "\(Connection.API_BASE_URL)\(route)\(Connection.API_KEY)"
        print(urlString)
        guard let url = URL(string: urlString) else { return }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if (error != nil){
                print ("error")
            }else{
                do{
                    guard let data = data else { return }
                    let movies = try JSONDecoder().decode(T.self, from: data)
                    DispatchQueue.main.async {
                        completionHandler(movies)
                    }
                } catch{
                    print(error)
                }
                
            }
        }
        task.resume()
    }
    
    
    
    public func downloadImage(from url: URL ,completionHandler:@escaping(_ img :UIImage)->Void){
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if (error != nil){
                print (error.debugDescription)
            }else{
                guard let data = data else { return }
                DispatchQueue.main.async {
                    
                    completionHandler(UIImage(data: data)!)
                }
                
            }
        }
        
        task.resume()
    }
}
