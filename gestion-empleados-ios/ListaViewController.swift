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
    
    struct DataResponse: Decodable{
        let id: Int?
        let nombre: String?
        let email: String?
        let puesto: String?
        let biografia: String?
        let salario: Int?
    }
    var id2: Int?
    var nombre: String?
    var email: String?
    var puesto: String?
    var biografia: String?
    var salario: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("entra a la lista")
        print(rol)
        
        let url = "http://192.168.64.3/proyectos/gestion-empleados/public/api/list"
        let body = ["api_token": api_token]
        
        //AF.req encoding
        AF.request(url, method: .put, parameters: body, encoding: JSONEncoding.default, headers: nil).responseDecodable(of: Data.self){response in
            print(response)
        }
    }
    

}
