//
//  PerfilViewController.swift
//  gestion-empleados-ios
//
//  Created by APPS2M on 1/2/22.
//

import UIKit
import Alamofire

class PerfilViewController: ViewController {

    var api_token:String = ""
    var rol:String = ""
    var id:Int = 0
    
    struct Data: Decodable{
        let id: Int
        let nombre: String
        let email: String
        let puesto: String
        let biografia: String
        let salario: String
    }
    var id2: Int?
    var nombre: String?
    var email: String?
    var puesto: String?
    var biografia: String?
    var salario: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("entra al perfil")
        
        let url = "http://localhost:8888/gestion-empleados/public/api/details"
        let body = ["api_token": api_token, "id": "\(id)"]
        print("body",body)
        AF.request(url, method: .put, parameters: body, encoding: JSONEncoding.default, headers: nil).responseDecodable(of: Data.self){response in
            print("response",response)
            self.id2 = response.value?.id
            self.nombre = response.value?.nombre
            self.email = response.value?.email
            self.puesto = response.value?.puesto
            self.biografia = response.value?.biografia
            self.salario = response.value?.salario
            
            self.afterResponse()
        }
        
        
    }

    func afterResponse(){
        print("id", id,"id2",id2, "nombre",nombre, "email",email, "puesto",puesto, "biografia",biografia, "salario", salario)
    }
}
