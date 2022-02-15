//
//  ListaViewController.swift
//  gestion-empleados-ios
//
//  Created by APPS2M on 1/2/22.
//

import UIKit
import Alamofire

class ListaViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var api_token:String? = ""
    var rol:String? = ""
    var id:Int? = nil
    
    @IBOutlet weak var tablaEmpleados: UITableView!
    
    struct Usuario: Encodable, Decodable {
        let id: Int
        let nombre: String
        let puesto: String
        let salario: Int
    }

    struct UsuarioR: Encodable, Decodable{
        var usuarios: [Usuario]?
    }
    
    var usuarios: [Usuario]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tablaEmpleados.dataSource = self
        tablaEmpleados.delegate = self
        print("entra a la lista")
        print(rol)
        
        let url = "http://192.168.64.3/proyectos/gestion-empleados/public/api/list"
        let body = ["api_token": api_token]
        print("apitoken", api_token)
        //AF.req encoding
        AF.request(url, method: .put, parameters: body, encoding: JSONEncoding.default, headers: nil).responseDecodable(of: UsuarioR.self){response in
            print("response de lista",response)
            self.usuarios = response.value?.usuarios
            print("lista de usuarios:",self.usuarios)
            
            self.tablaEmpleados.reloadData()
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usuarios?.count ?? 0
//        return 10
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var celda = tableView.dequeueReusableCell(withIdentifier: "celdaID", for: indexPath) as! EmpleadoTableViewCell
        celda.NombreTXT.text = self.usuarios![indexPath.row].nombre
        celda.PuestoTXT.text = self.usuarios![indexPath.row].puesto
        celda.SalarioTXT.text = String(self.usuarios![indexPath.row].salario)
        
//        celda.NombreTXT.text = "paco"
//        celda.PuestoTXT.text = "albañil"
//        celda.SalarioTXT.text = "9999"

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
