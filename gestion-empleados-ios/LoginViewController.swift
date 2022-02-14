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
        let msg: String
        let api_token: String
        let puesto: String
        let id: Int
    }
    @IBOutlet weak var errormsg: UILabel!
    var msg:String?
    var api_token:String?
    var rol:String?
    var id:Int?
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginBotonPulsado(_ sender: Any) {
        //email.text
        let url = "http://localhost:8888/gestion-empleados/public/api/login"
        let body = ["email": email.text, "password": password.text]
        
        //AF.req encoding
        AF.request(url, method: .put, parameters: body, encoding: JSONEncoding.default, headers: nil).responseDecodable(of: Data.self){response in
            print(response)
            self.msg = response.value?.msg
            self.api_token = response.value?.api_token
            self.rol = response.value?.puesto
            self.id = response.value?.id
            
            self.afterResponse()
        }
    }
    
    func afterResponse(){
        print("llega1")
        if(api_token != nil){
            print("llega1")
            print("Tu api token es ",api_token!)
            print("Tu rol token es ",rol!)
            print(msg!)
            
            if rol == "Empleado"{ //si es empleado solo puede ver su propio perfil
                performSegue(withIdentifier: "logueado_perfil", sender: nil)
            }else{
                performSegue(withIdentifier: "logueado_lista", sender: nil)
            }
        }else{
            print("llega3")
            errormsg.isHidden = false
        }
        
        // performSegue(withIdentifier: "logueado", sender: nil)
    }
    //func prepare for segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "logueado_lista"{
            let listaVista = segue.destination as! ListaViewController
            listaVista.api_token = api_token!
            listaVista.rol = rol!
            listaVista.id = id!
        }
        if segue.identifier == "logueado_perfil"{
            let listaPerfil = segue.destination as! PerfilViewController
            listaPerfil.api_token = api_token!
            listaPerfil.rol = rol!
            listaPerfil.id = id!
        }
    }
    
    

}
