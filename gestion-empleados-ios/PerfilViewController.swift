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
    
    struct DataResponse: Decodable{
        let id: Int?
        let nombre: String?
        let email: String?
        let puesto: String?
        let biografia: String?
        let salario: Int?
        
        enum CodignKeys: String, CodingKey {
            case id
            case nombre
            case email
            case puesto
            case biografia
            case salario
        }
    }
    var id2: Int?
    var nombre: String?
    var email: String?
    var puesto: String?
    var biografia: String?
    var salario: Int?
    
    @IBOutlet weak var nombreTXT: UILabel!
    @IBOutlet weak var puestoTXT: UILabel!
    @IBOutlet weak var salarioTXT: UILabel!
    @IBOutlet weak var biografiaTXT: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("entra al perfil")
        
        let url = "http://192.168.64.3/proyectos/gestion-empleados/public/api/details"
        let body = ["api_token": api_token, "id": String(id)]
        
        print("body",body)
        AF.request(url, method: .put, parameters: body, encoding: JSONEncoding.default, headers: nil).responseDecodable(of: DataResponse.self){ response in
            print("response", response)
            print("id", response.value?.id)
                        
            if response.value?.id != nil{
                self.id2 = Int((response.value?.id)!)
            }else{
                self.id2 = nil
            }
            
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
        nombreTXT.text = nombre!
        puestoTXT.text = puesto!
        salarioTXT.text = String(salario!)
        biografiaTXT.text = biografia!
    }
}
