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

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginBotonPulsado(_ sender: Any) {
        //email.text
        var url = "https://private-088c5a-usuarios4.apiary-mock.com/users"

        AF.request(url).responseJSON {
            response in
            if let json = respuesta.result.value {
                var users: [User] = []
                for user in json as! [[String : Any]] {
                    users.append(User(json: user))
                }
            }
        }
        performSegue(withIdentifier: "logueado", sender: nil)
    }
    
    
    @IBSegueAction func segueee(_ coder: NSCoder) -> ViewController? {
        return <#ViewController(coder: coder)#>
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
