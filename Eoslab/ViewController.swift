//
//  ViewController.swift
//  Eoslab
//
//  Created by Gema Beltran on 21/2/17.
//  Copyright © 2017 Antonio Jesus Cazalla. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBAction func farmacia(_ sender: AnyObject) {
        
    
    }
    var listProducts: [Product] = [];
    
    @IBOutlet weak var name: UITextField!
    
    @IBOutlet weak var farmacia: UIImageView!
    @IBOutlet weak var veterinarias: UIImageView!
    @IBOutlet weak var gasolinera: UIImageView!
    @IBOutlet weak var ortopedia: UIImageView!
    @IBOutlet weak var parafarmacia: UIImageView!
    @IBOutlet weak var dental: UIImageView!
    @IBOutlet weak var medico: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ViewController.imageTapped(gesture:)))
        //let tapGesture1 = UITapGestureRecognizer(target: self, action: #selector(ViewController.imageTapped(gesture:)))

        
        //opc 1
        //farmacia.addGestureRecognizer(tapGesture)
        //veterinarias.addGestureRecognizer(tapGesture1)
        //gasolinera.addGestureRecognizer(tapGesture)
        
        // black magic
        //[farmacia, veterinarias, gasolinera, ortopedia, parafarmacia, dental, medico ].forEach { (v: UIImageView?) in
           // v?.addGestureRecognizer(tapGesture)
       // }
        
        
        pedirCatalogo()
        /*listProducts.forEach{(p: Product) in
            print(p.name)
            
        }*/
        
        for p in listProducts{
            print(p.name)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "farmacia"{
            let destinationController = segue.destination as! TableTableViewController
            destinationController.listProduct = self.listProducts
            destinationController.categoria = 1
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*func imageTapped(gesture: UIGestureRecognizer) {
        // if the tapped view is a UIImageView then set it to imageview
        if (gesture.view as? UIImageView) != nil {
            
            switch (gesture.view!.tag) {
            case 1:
                self.navigationController?.pushViewController(TableTableViewController(listProduct : listProducts, categoria: 1), animated: true)
                print("farmacia")
                break
                
            case 2:
                self.navigationController?.pushViewController(ViewController2(), animated: true)
                print("veterinaria")
                break
            case 3:
                navigationController?.pushViewController(TableTableViewController(listProduct : listProducts, categoria: 2), animated: true)
                print("gasolinera")
                break
            case 4:
                navigationController?.pushViewController(TableTableViewController(listProduct : listProducts, categoria: 4), animated: true)
                break
            case 5:
                navigationController?.pushViewController(TableTableViewController(listProduct : listProducts, categoria: 5), animated: true)
                break
            case 6:
                navigationController?.pushViewController(TableTableViewController(listProduct : listProducts, categoria: 6), animated: true)
                break
            case 7:
                navigationController?.pushViewController(TableTableViewController(listProduct : listProducts, categoria: 7), animated: true)
                break
                
            default:
                break
            }
            //Here you can initiate your new ViewController
        }
    }*/
    
    func pedirCatalogo(){
        let url = URL(string: "https://demo8112147.mockable.io")
        URLSession.shared.dataTask(with: url!, completionHandler: {
            (data, response, error) in
            if(error != nil){
                print("error")
            }else{
                do{
                    let json = try JSONSerialization.jsonObject(with: data!, options:.allowFragments) as! [String : AnyObject]
                    
                    if let products = json["products"] as? [[String: AnyObject]]{
                        for products in products {
                            var newProduct: Product = Product()
                            newProduct.name = products["descripcion_nombre"] as? String
                            newProduct.descripcion = products["descripcion"] as? String
                            newProduct.url = products["url"] as? String
                            newProduct.ref = products["ref"] as? String
                            newProduct.tresd = products["tresd"] as? String
                            newProduct.bluetooth = products["bluetooth"] as? String
                            newProduct.fecha = products["fecha"] as? String
                            newProduct.cruz = products["cruz"] as? String
                            newProduct.horario = products["horario"] as? String
                            newProduct.brillo = products["brillo"] as? String
                            newProduct.disponibilidad = products["disponibilidad"] as? String
                            newProduct.voltaje = products["voltaje"] as? String
                            newProduct.consumo = products["consumo"] as? String
                            newProduct.almacenamiento = products["almacenamiento"] as? String
                            newProduct.trabajo = products["trabajo"] as? String
                            newProduct.pixeles = products["pixeles"] as? String
                            newProduct.fuente = products["fuente"] as? String
                            newProduct.control = products["control"] as? String
                            newProduct.tipografia = products["tipogradia"] as? String
                            newProduct.cpu = products["cpu"] as? String
                            newProduct.animacion = products["animacion"] as? String
                            newProduct.cantidad = products["cantidad"] as? String
                            newProduct.ancho = products["ancho"] as? String
                            newProduct.alto = products["alto"] as? String
                            newProduct.fondo = products["fondo"] as? String
                            newProduct.categoria = products["categoria"] as? String
                            self.listProducts.append(newProduct)
                            
                        }
                    }
                    
                    print(self.listProducts.count)
                    self.listProducts.forEach{(p: Product) in
                        print(p.name)
                        
                    }
                    OperationQueue.main.addOperation({
                        //print(json["products"])
                    })
                    
                }catch let error as NSError{
                    print(error)
                }
            }
        }).resume()
        
        
    }

}

