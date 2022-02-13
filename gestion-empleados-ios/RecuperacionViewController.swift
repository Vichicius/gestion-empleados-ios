//
//  RecuperacionViewController.swift
//  gestion-empleados-ios
//
//  Created by APPS2M on 1/2/22.
//

import UIKit
import Alamofire
class RecuperacionViewController: ViewController {

    struct Data: Decodable {
        var status: Int
        var password: String
    }
    var status:Int?
    var pass:String?
    @IBOutlet weak var outputMSG: UILabel!
    @IBOutlet weak var inputEmail: UITextField!
    @IBOutlet weak var output: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func recuperarContra(_ sender: Any) {
        let url = "http://localhost:8888/gestion-empleados/public/api/forgot-password"
        let body = ["email": inputEmail.text]
        
        AF.request(url, method: .put, parameters: body, encoding: JSONEncoding.default, headers: nil).responseDecodable(of: Data.self){response in
            print("EL RESPONSE: ",response)
            self.status = response.value?.status
            self.pass = response.value?.password
                        
            print("EL STATUS",self.status)
            self.afterResponse()
        }
    }
    func afterResponse(){
        output.isHidden = false
        print(status)
        if status == 1{
            output.text = "Contraseña restablecida: \(self.pass!)"
        }else{
            output.text = "Ese email no está registrado"
        }
    }
    

}
