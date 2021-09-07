//
//  Parser.swift
//  iOSCodingChallenge
//
//  Created by Hamza Iqbal on 06/09/2021.
//

import Foundation

class Parser {
    weak var vc: ViewController?
    var arrPhotos = [Photo]()
    func parse(completion : @escaping ([Photo]) -> ()) {
        let reachability = try! Reachability.init()
        if((reachability.connection) != .unavailable) {
            let api = URL(string: "https://jsonplaceholder.typicode.com/photos")
            URLSession.shared.dataTask(with: api!) {
                (data, response, error) in
                if(error != nil) {
                    print(error?.localizedDescription ?? "Error: Not getting result from api.")
                    return
                }
                if let data = data {
                    do {
                        let fileManager = FileManager.default
                        let urls = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
                        if let url = urls.first {
                            var fileURL = url.appendingPathComponent("Photo")
                            fileURL = fileURL.appendingPathExtension("json")
                            try FileManager.default.removeItem(at:fileURL)
                        }
                        let decoder = JSONDecoder()
                        let result = try decoder.decode([Photo].self, from: data)
                        print(result)
                        let status = try self.save(result, for: "Photo")
                        print("status check", status)
                        let model = try self.loadJSON(withFilename: "Photo")
                        completion(model ?? [])
                    } catch let err{
                        print(err.localizedDescription)
                    }
                }
            }.resume()
        } else {
            do {
                let model = try self.loadJSON(withFilename: "Photo")
                completion(model ?? [])
            } catch let err{
                print(err.localizedDescription)
            }
        }
    }
    
    func save(_ model: [Photo], for filename: String) throws -> Bool{
        let fileManager = FileManager.default
        let urls = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        if let url = urls.first {
            var fileURL = url.appendingPathComponent(filename)
            fileURL = fileURL.appendingPathExtension("json")
            let data = try JSONEncoder().encode(model)
            
            //Checking file is available or now
            guard fileManager.fileExists(atPath: fileURL.path) else {
                /// Create new file here
                return fileManager.createFile(atPath: fileURL.path,
                                              contents: data, attributes: nil)
            }
            try data.write(to: fileURL, options: [.atomicWrite])
            return true
        }
        return false
    }
    
    func loadJSON(withFilename filename: String) throws -> [Photo]? {
        let fileManager = FileManager.default
        let urls = fileManager.urls(for: .documentDirectory,
                                    in: .userDomainMask)
        if let url = urls.first {
            var fileURL = url.appendingPathComponent(filename)
            fileURL = fileURL.appendingPathExtension("json")
            let data = try Data(contentsOf: fileURL)
            let jsonObject = try JSONDecoder().decode([Photo].self, from: data)
            return jsonObject
        }
        return nil
    }
    
}
