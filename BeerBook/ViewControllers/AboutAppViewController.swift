//
//  ViewController.swift
//  BeerBook
//
//  Created by Ilnur on 22.05.2023.
//

import UIKit

class AboutAppViewController: UIViewController {
    
    private let networkManager = NetworkManager.shared

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

// MARK: - postRequestWithDictionary
//extension AboutAppViewController {
//    func postRequestWithDict() {
//        let postUrl = URL(string: "https://jsonplaceholder.typicode.com/posts")!
//
//        let parameters = [
//            "name" : "Networking",
//            "imageUrl" : "image url",
//            "numberOfTests" : "8"
//        ]
//
//        networkManager.postRequest(with: parameters, to: postUrl) { result in
//            switch result {
//            case .success(let json):
//                print(json)
//            case .failure(let error):
//                print(error)
//            }
//        }
//    }
//}
