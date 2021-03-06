//
//  FileManager+Extension.swift
//  CountDown
//
//  Created by Krzysztof Kukiz on 19/11/2021.
//

import Foundation

let fileName = "Events.json"

extension FileManager {
    static var docDirURL: URL {
        return self.default.containerURL(forSecurityApplicationGroupIdentifier: "group.pl.cookiez.CountDown")!
    }
    
    func saveDocument(contents: String, docName: String, completion: (Error?) -> Void) {
        let url = Self.docDirURL.appendingPathComponent(docName)
        print("Save url: \(url.path)")
        do {
            try contents.write(to: url, atomically: true, encoding: .utf8)
        } catch {
            completion(error)
        }
    }
    
    func readDocument(docName: String, completion: (Result<Data, Error>) -> Void) {
        let url = Self.docDirURL.appendingPathComponent(docName)
        print("Read url: \(url.path)")
        do {
            let data = try Data(contentsOf: url)
            completion(.success(data))
        } catch {
            completion(.failure(error))
        }
    }
    
    func docExist(named docName: String) -> Bool {
        return fileExists(atPath: Self.docDirURL.appendingPathComponent(docName).path)
    }
}
