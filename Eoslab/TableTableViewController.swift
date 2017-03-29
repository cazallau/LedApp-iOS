//
//  TableTableViewController.swift
//  Eoslab
//
//  Created by Gema Beltran on 2/3/17.
//  Copyright © 2017 Antonio Jesus Cazalla. All rights reserved.
//

import UIKit
import ImageIO
import Realm

class TableTableViewController: UITableViewController {
    var listProduct: [Product] = []
    var categoria : Int = 0
    var finalListProduct: [Product] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /*self.listProduct.forEach{(p: Product) in
            print(p.name)
            let pr : Product = Product()
            pr.name = "hola"
            self.prod.append(pr)*/
        self.tableView.tableFooterView = UIView()

        
        switch categoria {
        case 1:
            for product in self.listProduct{
                if product.categoria == "farmacia" {
                    self.finalListProduct.append(product)
                    title = "Cruces de Farmacia"
                }
            }
            break
        case 2:
            for product in self.listProduct{
                if product.categoria == "veterinario" {
                    self.finalListProduct.append(product)
                    title = "Cruces de Veterinaria"
                }
            }
            break
        case 3:
            for product in self.listProduct{
                if product.categoria == "gasolinera" {
                    self.finalListProduct.append(product)
                    title = "Preciarios de Gasolineras"
                }
            }
            break
        case 4:
            for product in self.listProduct{
                if product.categoria == "ortopedia" {
                    self.finalListProduct.append(product)
                    title = "Tiendas de Ortopedia"
                }
            }
            break
        case 5:
            for product in self.listProduct{
                if product.categoria == "parafarmacia" {
                    self.finalListProduct.append(product)
                    title = "Cruces de Parafarmacia"
                }
            }
            break
        case 6:
            for product in self.listProduct{
                if product.categoria == "dentista" {
                    self.finalListProduct.append(product)
                    title = "Clínica Dental"
                }
            }
            break
        case 7:
            for product in self.listProduct{
                if product.categoria == "médico" {
                    self.finalListProduct.append(product)
                    title = "Cruces de Centro Médico"
                }
            }
            break
        default:
            categoria = 0
        }

            
            
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetails"{
            if let indexPath = self.tableView.indexPathForSelectedRow{
                let destinationController = segue.destination as! DetailsViewController
                destinationController.product = self.finalListProduct[indexPath.row]
                let backItem = UIBarButtonItem()
                backItem.title = "Back"
                destinationController.navigationItem.backBarButtonItem = backItem
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return self.finalListProduct.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "productCell", for: indexPath) as! ProductosCell
        if finalListProduct.count == 0 {
            cell.nombreProducto.text = "No hay productos para esta categoria"
        }
        let product = finalListProduct[indexPath.row]
        
        cell.nombreProducto.text = product.name
        self.downloadImage(product.url!, inView: cell.imagenProducto)
        print(product.url)
        print(product.name)
        return cell
    }
    
    
    
    func downloadImage(_ uri : String, inView: UIImageView){
        guard let url = URL(string: uri) else {
            print("😱 Error in \(uri)")
            return
        }
        
        /* modo java
        let url = URL(string: uri)

        if url == nil {
            return
        }
        */
        
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.color = UIColor.red
        inView.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        activityIndicator.activityIndicatorViewStyle = .whiteLarge
        activityIndicator.sizeToFit()
        activityIndicator.hidesWhenStopped = false
    
        
        let task = URLSession.shared.dataTask(with: url) {responseData,response,error in
            if error == nil{
                if let data = responseData {
                    
                    DispatchQueue.main.async {
                        activityIndicator.stopAnimating()
                        activityIndicator.removeFromSuperview()
                        inView.image = UIImage(data: data)
                    }
                    
                }else {
                    print("no data")
                }
            }else{
                print(error)
            }
        }
        
        task.resume()
        
    }

    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func backButtonClicked(_ sender: AnyObject) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    
    
}



