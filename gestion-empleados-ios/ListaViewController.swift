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

    struct UsuarioR: Encodable, Decodable{
        var usuarios: [Usuario]?
    }
    
    var usuarios: [Usuario]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("entra a la lista")
        print(rol)
        
        let url = "http://192.168.64.3/proyectos/gestion-empleados/public/api/list"
        let body = ["api_token": api_token]
        
        //AF.req encoding
        AF.request(url, method: .put, parameters: body, encoding: JSONEncoding.default, headers: nil).responseDecodable(of: UsuarioR.self){response in
            print(response)
            self.usuarios = response.value?.usuarios
            print(self.usuarios)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usuarios?.count ?? 0
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tableView.dequeueReusableCell(withIdentifier: "celdaID", for: indexPath) as! EmpleadoTableViewCell
        celda.NombreTXT.text = self.usuarios![indexPath.row].nombre!
        celda.PuestoTXT.text = self.usuarios![indexPath.row].puesto!
        celda.SalarioTXT.text = String(self.usuarios![indexPath.row].salario!)

        return celda
        }
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //segue a perfil
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "logueado_perfil"{
            let listaPerfil = segue.destination as! PerfilViewController
            listaPerfil.api_token = api_token!
            listaPerfil.rol = rol!
            listaPerfil.id = id!
        }
    }


}
