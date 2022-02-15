//
//  EmpleadoTableViewCell.swift
//  gestion-empleados-ios
//
//  Created by APPS2M on 15/12/21.
//

import UIKit

class EmpleadoTableViewCell: UITableViewCell {

//    var usuario: Usuario? {
//        didSet{
//            actualizarCampos()
//        }
//    }
    
    @IBOutlet weak var NombreTXT: UILabel!
    @IBOutlet weak var PuestoTXT: UILabel!
    @IBOutlet weak var SalarioTXT: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
//    func actualizarCampos(){
//        NombreTXT.text = usuario!.nombre
//        PuestoTXT.text = usuario!.puesto
//        SalarioTXT.text = String(usuario!.salario!)
//    }

}
