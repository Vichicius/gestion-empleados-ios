//
//  RegisterViewController.swift
//  gestion-empleados-ios
//
//  Created by APPS2M on 24/1/22.
//

import UIKit
import Alamofire

class RegisterViewController: ViewController {

    struct Data: Decodable{
        let status: Int
        let msg : String
        let api_token: String
        let puesto: String
        let id: Int
    }
    var status: Int?
    var msg: String?
    var api_token: String?
    var rol: String?
    var id: Int?
    
    @IBOutlet weak var inputEmail: UITextField!
    @IBOutlet weak var inputContra: UITextField!
    @IBOutlet weak var inputNombre: UITextField!
    @IBOutlet weak var inputSalario: UITextField!
    @IBOutlet weak var inputBio: UITextField!
    @IBOutlet weak var puesto: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func registrarse(_ sender: Any) {
        let body = ["name": inputNombre.text,
                    "email": inputEmail.text,
                    "password": inputContra.text,
                    "puesto": puesto.titleForSegment(at: puesto.selectedSegmentIndex),
                    "salario": inputSalario.text,
                    "biografia": inputBio.text]
        
        let url = "http://localhost:8888/gestion-empleados/public/api/register"
        
        AF.request(url, method: .post, parameters: body, encoding: JSONEncoding.default, headers: nil).responseDecodable(of: Data.self){response in
            self.status = response.value?.status
            print("response",response)
            print("status",response.value?.status)
            print("msg",response.value?.msg)
            self.msg = response.value?.msg
            self.api_token = response.value?.api_token
            self.rol = response.value?.puesto
            self.id = response.value?.id
            print("id",self.id)
            self.afterResponse()
        }
        
    }
    func afterResponse(){
        if status == 1 {
            print("todo OK")
            //segue a la lista
            if rol == "Empleado"{
                performSegue(withIdentifier: "registro_perfil", sender: nil)
            }else{
                performSegue(withIdentifier: "registro_lista", sender: nil)
            }
        }else{
            print("Error \(self.msg)")
            print("status \(self.status)")
            if self.status == -1 { //status de contraseña insegura
                print("entra")
                // create the alert
                let alert = UIAlertController(title: "Contraseña insegura", message: "Mínimo: 1 Mayúscula, 1 minúscula y 1 número (6 de longitud)", preferredStyle: UIAlertController.Style.alert)

                // add an action (button)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

                // show the alert
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "registro_lista"{
            let listaVista = segue.destination as! ListaViewController
            listaVista.api_token = self.api_token!
            listaVista.rol = self.rol!
            listaVista.id = self.id!
        }
        if segue.identifier == "registro_perfil"{
            let listaPerfil = segue.destination as! PerfilViewController
            listaPerfil.api_token = self.api_token!
            listaPerfil.rol = self.rol!
            listaPerfil.id = self.id!
        }
    }
    
}
