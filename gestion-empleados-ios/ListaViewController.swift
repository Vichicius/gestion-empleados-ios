//
//  ListaViewController.swift
//  gestion-empleados-ios
//
//  Created by APPS2M on 1/2/22.
//

import UIKit
import Alamofire

class ListaViewController: ViewController {

    var api_token:String? = ""
    var rol:String? = ""
    var id:Int? = nil
    
    struct Usuario: Encodable, Decodable {
        let id: Int?
        let nombre: String?
        let puesto: String?
        let salario: Int?
    }
    
    struct Data: Encodable, Decodable{
        var usuario: [Usuario]?
    }
    
//    var user: [Usuario] = []
//    struct Usuario {
//        var id: Int?
//        var nombre: String?
//        var email: String?
//        var puesto: String?
//        var biografia: String?
//        var salario: Int?
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("entra a la lista")
        print(rol)
        
        let url = "http://localhost:8888/gestion-empleados/public/api/list"
        let body = ["api_token": api_token]
        
        //AF.req encoding
        AF.request(url, method: .put, parameters: body, encoding: JSONEncoding.default, headers: nil).responseDecodable(of: Data.self){response in
            if let usuarios = response.value?.usuario{
                success(usuarios)
            }
        }
    }
    

}
