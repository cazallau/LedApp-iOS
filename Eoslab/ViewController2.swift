//
//  ViewController2.swift
//  Eoslab
//
//  Created by Gema Beltran on 5/3/17.
//  Copyright © 2017 Antonio Jesus Cazalla. All rights reserved.
//

import UIKit

class ViewController2: UIViewController {
    
    @IBOutlet weak var loadingLabel: UILabel!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    @IBOutlet weak var tableView: UITableView!
    var prod : [Product] = []
    var listProducts: [Product] = []{
        didSet {
            hideLoadingView()
            
            self.cargarCategorias()
            
        }
        
    }
    
    

    var categorias: [Categoria] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        showLoadingView()
        pedirCatalogo()
        self.tableView.dataSource = self
        self.tableView.delegate = self
                // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        showLoadingView()

        // Dispose of any resources that can be recreated.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showCategoria"{
            if let indexPath = self.tableView.indexPathForSelectedRow{
                let destinationController = segue.destination as! TableTableViewController
                destinationController.listProduct = self.listProducts
                destinationController.categoria = indexPath.row + 1
            }
        }
    }
}



    extension ViewController2 : UITableViewDataSource, UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categorias.count
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let c = self.categorias[indexPath.row]
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CategoriaCell
        cell.textoCategoria.text = c.nombre
        cell.imagenCategoria.image = c.imagen
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


private extension ViewController2 {
    func showLoadingView() {
        indicator.startAnimating()
        indicator.backgroundColor = UIColor.white
        loadingLabel.isHidden = false
    }
    
    func hideLoadingView() {
        indicator.stopAnimating()
        indicator.hidesWhenStopped = true
        loadingLabel.isHidden = true
    }
    func cargarCategorias(){
        self.categorias = []
        var cat = Categoria(nombre: "Cruces de Farmacia", imagen: #imageLiteral(resourceName: "farmacía"))
        self.categorias.append(cat)
        cat = Categoria(nombre: "Cruces de Clínicas Veterinarias", imagen: #imageLiteral(resourceName: "veterinaria"))
        self.categorias.append(cat)
        cat = Categoria(nombre: "Preciarios de Gasolineras", imagen: #imageLiteral(resourceName: "gasolinera"))
        self.categorias.append(cat)
        cat = Categoria(nombre: "Tiendas de Ortopedia", imagen: #imageLiteral(resourceName: "ortopedia"))
        self.categorias.append(cat)
        cat = Categoria(nombre: "Cruces de Parafarmácia", imagen: #imageLiteral(resourceName: "parafarmacia"))
        self.categorias.append(cat)
        cat = Categoria(nombre: "Clínicas Dental", imagen: #imageLiteral(resourceName: "clinicadental"))
        self.categorias.append(cat)
        cat = Categoria(nombre: "Cruces de Centro Médico", imagen: #imageLiteral(resourceName: "medicocorazon"))
        self.categorias.append(cat)
        
        self.tableView.reloadData()
    }
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
