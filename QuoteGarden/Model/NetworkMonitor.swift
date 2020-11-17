//
//  NetworkMonitor.swift
//  QuoteGarden
//
//  Created by Master Family on 28/10/2020.
//

import Foundation
import Network

class NetworkMonitor: ObservableObject {
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "Monitor")

    var isActive = false
    var isExpensive = false
    var isConstrained = false
    var connectionType = NWInterface.InterfaceType.other

    init() {
        monitor.pathUpdateHandler = { path in
            self.isActive = path.status == .satisfied
            self.isExpensive = path.isExpensive
            self.isConstrained = path.isConstrained

            let connectionTypes: [NWInterface.InterfaceType] = [.cellular, .wifi, .wiredEthernet]
            self.connectionType = connectionTypes.first(where: path.usesInterfaceType) ?? .other

            DispatchQueue.main.async {
                self.objectWillChange.send()
            }
        }

        monitor.start(queue: queue)
    }

}

struct QuoteGardenApi {
    
    func getRandomQuote(completion: @escaping (Quote) -> Void) {
        
        let config = URLSessionConfiguration.default
        config.allowsExpensiveNetworkAccess = true
        config.allowsConstrainedNetworkAccess = true
        config.allowsCellularAccess = true
        config.waitsForConnectivity = false
//        config.requestCachePolicy = .reloadIgnoringLocalCacheData

        let url = URL(string: "https://quote-garden.herokuapp.com/api/v2/quotes/random")

        var request = URLRequest(url: url!, timeoutInterval: Double.infinity)
        request.httpMethod = "GET"

        let task = URLSession(configuration: config).dataTask(with: request) { data, response, error in
            guard let data = data else {
                print(String(describing: error))
                return
            }

            guard let response = try? JSONDecoder().decode(Response.self, from: data) else {
                print(String(describing: error))
                return
            }
            DispatchQueue.main.async {
                completion(response.quote)
            }

            print(String(data: data, encoding: .utf8)!)
        }

        task.resume()
    }

}
