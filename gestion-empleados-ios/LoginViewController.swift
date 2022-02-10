//
//  LoginViewController.swift
//  gestion-empleados-ios
//
//  Created by APPS2M on 26/1/22.
//

import UIKit
import Alamofire

//var url = "http://private-088c5a-usuarios4.apiary-mock.com/users"


class LoginViewController: ViewController {
    
    struct Data: Decodable { //esto se tiene que llamar como en el response (las variables)
        let api_token: String
        let msg: String
    }
    var api_token:String?
    //var rol:String?
    var msg:String?
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginBotonPulsado(_ sender: Any) {
        //email.text
        let url = "http://192.168.64.3/proyectos/gestion-empleados/public/api/users/login"
        let body = ["email": email.text, "password": password.text]
        
        //AF.req encoding
        AF.request(url, method: .put, parameters: body, encoding: JSONEncoding.default, headers: nil).responseDecodable(of: Data.self){response in
            print(response)
            self.api_token = response.value?.api_token
            self.msg = response.value?.msg
            //self.rol = response.value?.rol
        }
        print("Tu api token es ",api_token)
        print(msg)
//        if rol == "empleado"{
//            performSegue(withIdentifier: "logueado_perfil", sender: nil)
//        }else{
//            performSegue(withIdentifier: "logueado_lista", sender: nil)
//        }
        
        
       // performSegue(withIdentifier: "logueado", sender: nil)
    }
    
    //func prepare for segue
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//
//        if segue.identifier == "logueado_lista"{
//            let listaVista = segue.destination as! ListaViewController
//            listaVista.api_token = api_token!
//        }
//        if segue.identifier == "logueado_perfil"{
//            let listaPerfil = segue.destination as! PerfilViewController
//            listaPerfil.api_token = api_token!
//        }
//    }
    
    

}
