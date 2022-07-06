//
//  ViewModel.swift
//  Task
//
//  Created by Bala on 01/07/22.
//

import UIKit

class FilmViewModel: NSObject {

    var errMessage = String()
    
    func apiForGetFilmList(completionHandler: @escaping (Result<Data, Error>) -> Void) {
        
        let urlsession = URLSession.shared
        guard let url = URL.init(string: "\(APIEndPoints.baseUrl)/?apikey=\(APIEndPoints.apiKey)\(APIEndPoints.getfilmlist)") else { return  }
        let urlrequest = URLRequest.init(url: url)
        
        urlsession.dataTask(with: urlrequest) { resultdata, response, error in
                guard let data = resultdata else {
                    completionHandler(.failure(error!))
                    return
                }
                completionHandler(.success(data))
        }.resume()
        
    }
}
