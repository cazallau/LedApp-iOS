//
//  DetailsViewController.swift
//  Eoslab
//
//  Created by Gema Beltran on 6/3/17.
//  Copyright © 2017 Antonio Jesus Cazalla. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    @IBOutlet weak var refText: UILabel!

    @IBOutlet weak var imagenDetalles: UIImageView!
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var label4: UILabel!
    @IBOutlet weak var label5: UILabel!
    @IBOutlet weak var label6: UILabel!
    
    var product : Product = Product()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = product.name
        self.downloadImage(product.url!, inView: self.imagenDetalles)
        self.label1.text = product.descripcion
        self.label2.text = product.bluetooth
        self.label3.text = product.cruz
        self.label4.text = product.animacion
        self.label4.text = product.almacenamiento
        self.label5.text = product.cantidad
        self.label6.text = product.brillo
        self.refText.text = product.ref
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func downloadImage(_ uri : String, inView: UIImageView){
        
        let url = URL(string: uri)
        
        let task = URLSession.shared.dataTask(with: url!) {responseData,response,error in
            if error == nil{
                if let data = responseData {
                    
                    DispatchQueue.main.async {
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
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
