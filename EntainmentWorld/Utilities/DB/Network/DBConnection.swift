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
    
    private func load<T:Decodable>(error: Error ,data: Data, completionHandler:@escaping(T?, Error?)->Void){
        do{
            let deocder = JSONDecoder()
            deocder.keyDecodingStrategy = .convertFromSnakeCase
            let movies = try JSONDecoder().decode(T.self, from: data)
            completionHandler(movies, nil)
        }
        catch{
            print(error)
            completionHandler(nil, error)
        }
    }
    
    public func loadDataFromDB<T:Decodable>(pageNO: Int, route: String,completionHandler:@escaping(T?, Error?)->Void){
        if(Connection.API_KEY.isEmpty){
            print("You must have API Key")
        } else{
            
            guard let url = URL(string: "\(Connection.API_BASE_URL)\(route)\(Connection.API_KEY)\(Connection.PAGE)\(pageNO)") else { return }
            
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if (error != nil){
                    print ("error")
                    completionHandler(nil ,error)
                }else{
                    do{
                        guard let data = data else { return }
                        let deocder = JSONDecoder()
                        deocder.keyDecodingStrategy = .convertFromSnakeCase
                        let movies = try JSONDecoder().decode(T.self, from: data)
                        DispatchQueue.main.async {
                            completionHandler(movies, nil)
                        }
                    } catch{
                        print(error)
                        completionHandler(nil, error)
                    }
                    
                }
            }
            task.resume()
        }
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
    
    public func loadContentWithGenreId<T:Decodable>(pageNO: Int, route: String,genreId: Int,completionHandler:@escaping(T)->Void){
        guard let url = URL(string: "\(Connection.API_BASE_URL)\(route)\(Connection.API_KEY)\(Connection.PAGE)\(pageNO)\(Routes.MOVIE_GENRE_ID )\(genreId)") else { return }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if (error != nil){
                print ("error")
            }else{
                do{
                    guard let data = data else { return }
                    let deocder = JSONDecoder()
                    deocder.keyDecodingStrategy = .convertFromSnakeCase
                    let content = try JSONDecoder().decode(T.self, from: data)
                    DispatchQueue.main.async {
                        completionHandler(content)
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
                    guard  let image = UIImage(data: data) else{
                        return completionHandler(UIImage(named: "img1")!)
                    }
                    completionHandler(image)
                }
                
            }
        }
        
        task.resume()
    }
    
    
    public func LoadVideo <T:Decodable>(route: String, content_Type: String,  content_ID: Int,completionHandler:@escaping(T)->Void){
        guard let url = URL(string: "\(Connection.API_BASE_URL)\(content_Type)\(content_ID)\(route)\(Connection.API_KEY)") else { return }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if (error != nil){
                print ("error")
            }else{
                do{
                    guard let data = data else { return }
                    let deocder = JSONDecoder()
                    deocder.keyDecodingStrategy = .convertFromSnakeCase
                    let content = try JSONDecoder().decode(T.self, from: data)
                    DispatchQueue.main.async {
                        completionHandler(content)
                    }
                } catch{
                    print(error)
                }
                
            }
        }
        task.resume()
    }
}
