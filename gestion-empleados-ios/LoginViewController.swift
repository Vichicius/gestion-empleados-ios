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
    
    struct Data: Codable {
        let api_token: String
        let rol: String
    }
    var api_token:String = ""
    var rol:String?
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginBotonPulsado(_ sender: Any) {
        //email.text
        let url = "http://localhost/proyectos/gestion-empleados/public/api/users/login"
        let body = ["email": email.text, "password": password.text]
        
        AF.request(url, method: .put, parameters: body, encoding: JSONEncoding.default, headers: nil).responseDecodable(of: Data.self){response in
            self.api_token = response.value!.api_token
            self.rol = response.value!.rol
        }
        print(api_token)
        if rol == "empleado"{
            performSegue(withIdentifier: "logueado_perfil", sender: nil)
        }else{
            performSegue(withIdentifier: "logueado_lista", sender: nil)
        }
        print(api_token)
        
        //performSegue(withIdentifier: "logueado", sender: nil)
    }
    
    //func prepare for segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "logueado_lista"{
            let listaVista = segue.destination as! ListaViewController
            listaVista.api_token = api_token
        }
        if segue.identifier == "logueado_perfil"{
            let listaPerfil = segue.destination as! PerfilViewController
            listaPerfil.api_token = api_token
        }
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
