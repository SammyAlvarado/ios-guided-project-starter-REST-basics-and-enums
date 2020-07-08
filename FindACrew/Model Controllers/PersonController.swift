//
//  PersonController.swift
//  FindACrew
//
//  Created by Ben Gohlke on 5/4/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

class PersonController {
    enum HTTPMethod: String {
        case get = "GET"
        case put = "PUT"
        case post = "POST"
        case delete = "DELETE"
    }
    
    private let baseURL = URL(string: "https://lambdaswapi.herokuapp.com")!
    private lazy var peopleURL = URL(string: "/api/people", relativeTo: baseURL)!
    var people: [Person] = []

    func searchForPeople(searchTerm: String, completion: @escaping () -> Void) {

        // URL Components will construct our url with our query item
        var urlComponents = URLComponents(url: peopleURL, resolvingAgainstBaseURL: true)
        let searchTermQueryItem = URLQueryItem(name: "search", value: searchTerm)
        urlComponents?.queryItems = [searchTermQueryItem]

        guard let requestURL = urlComponents?.url else {
            print("Request URL is nil")
            completion() // is ment to let us know when its is done.
            return
        }

        // URL Requst
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue

        // Data Task look at 10:40
        let task =  URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
            if let error = error {
                print("error fetching data: \(error)")
                completion()
                return
            }

            guard let self = self else {
                completion()
                return
            }

           guard let data = data else {
                      print("no data retruned from data task")
                      completion()
                      return
            }

            // This converts from snake case
            let jsondDecoder = JSONDecoder()
            jsondDecoder.keyDecodingStrategy = .convertFromSnakeCase

            // Do - Try - CATCh (used for methonds that throw and error
            do {
                let personSearch = try jsondDecoder.decode(PersonSearch.self, from: data)
                self.people.append(contentsOf: personSearch.results)
            } catch {
                print("Unable to decode data into objec of type PersonSerarch: \(error)")
                completion()
                return
            }
            completion()
        }

        task.resume()

    }
}
