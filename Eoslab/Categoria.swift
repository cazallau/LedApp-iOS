//
//  Categoria.swift
//  Eoslab
//
//  Created by Gema Beltran on 5/3/17.
//  Copyright © 2017 Antonio Jesus Cazalla. All rights reserved.
//

import Foundation
import UIKit
class Categoria: NSObject {
    var nombre :String?
    var imagen : UIImage?
    
    init(nombre: String, imagen: UIImage) {
        self.nombre = nombre
        self.imagen = imagen
    }
}
