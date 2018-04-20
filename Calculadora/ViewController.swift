//
//  ViewController.swift
//  Calculadora
//
//  Created by Ronald Murillo Solano on 14/4/18.
//  Copyright © 2018 Ronald Murillo Solano. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var pilaCalculadora :  [String] = []
    var bDivisionXZero : Bool = false
    var bCalculoRealizado : Bool = false
    
    
    @IBOutlet weak var lblValorAcumulado: UILabel!
    @IBOutlet weak var lblValorActual: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func btnNumero(_ sender: UIButton) {
        if (bCalculoRealizado){
            lblValorActual.text = ""
            lblValorAcumulado.text = ""
            pilaCalculadora.removeAll()
            bCalculoRealizado = false
        }
        switch sender.tag {
        case 11:
            pilaCalculadora.append(lblValorActual.text!)
            
            lblValorAcumulado.text =  "\(lblValorAcumulado.text!) \(lblValorActual.text!)"
            
            lblValorAcumulado.text =  "\(lblValorAcumulado.text!) \("+")"
            pilaCalculadora.append("suma")
            lblValorActual.text = ""
        case 12:
            pilaCalculadora.append(lblValorActual.text!)
            
            lblValorAcumulado.text =  "\(lblValorAcumulado.text!) \(lblValorActual.text!)"
            
            lblValorAcumulado.text =  "\(lblValorAcumulado.text!) \("-")"
            lblValorActual.text = ""
            pilaCalculadora.append("resta")
        case 13:
            pilaCalculadora.append(lblValorActual.text!)
            
            lblValorAcumulado.text =  "\(lblValorAcumulado.text!) \(lblValorActual.text!)"
            
            lblValorAcumulado.text =  "\(lblValorAcumulado.text!) \("*")"
            lblValorActual.text = ""
            pilaCalculadora.append("multiplicacion")
        case 14:
                pilaCalculadora.append(lblValorActual.text!)
                
                lblValorAcumulado.text =  "\(lblValorAcumulado.text!) \(lblValorActual.text!)"
                
                lblValorAcumulado.text =  "\(lblValorAcumulado.text!) \("/")"
                lblValorActual.text = ""
                pilaCalculadora.append("division")
        default:
           lblValorActual.text?.append(contentsOf: String(sender.tag))
        }
    }
    
    
    @IBAction func btnIgual(_ sender: UIButton) {
        if(lblValorActual.text?.characters.count != 0){
            lblValorAcumulado.text =  "\(lblValorAcumulado.text!) \(lblValorActual.text!)"
            pilaCalculadora.append(lblValorActual.text!)
            lblValorActual.text = ""
        }
        calcularPrimarios()
        if(bDivisionXZero == false){
            lblValorActual.text = String(calculoFinal())
        }
        else{
            lblValorAcumulado.text = "División por Cero!!!!"
            lblValorActual.text = ""
            pilaCalculadora.removeAll()
            bCalculoRealizado = false
            bDivisionXZero = false
        }
        bCalculoRealizado = true
    }
    
    func calcularPrimarios(){
        var contador : Int = 0
        var valorA : Double = 0
        var valorB : Double = 0
        var valorNuevo : Double = 0
        while contador < pilaCalculadora.count{
            switch pilaCalculadora[contador] {
            case "multiplicacion":
                valorA = Double(pilaCalculadora[contador - 1])!
                valorB = Double(pilaCalculadora[contador + 1])!
                valorNuevo = valorA * valorB
                pilaCalculadora[contador - 1] = String(valorNuevo)
                pilaCalculadora.remove(at: contador)
                pilaCalculadora.remove(at: contador)
            case "division":
                valorA = Double(pilaCalculadora[contador - 1])!
                valorB = Double(pilaCalculadora[contador + 1])!
                if(valorB == 0){
                    bDivisionXZero = true
                    contador = pilaCalculadora.count + 2
                }
                else{
                    valorNuevo = valorA / valorB
                    pilaCalculadora[contador - 1] = String(valorNuevo)
                    pilaCalculadora.remove(at: contador)
                    pilaCalculadora.remove(at: contador)
                }
            default:
                contador = contador + 1
                
            }
        }
    }
    
    
    func calculoFinal() -> Double{
        var contador : Int = 1
        var valorFinal : Double = Double(pilaCalculadora[0])!
        while contador < pilaCalculadora.count{
            switch pilaCalculadora[contador] {
            case "suma":
                valorFinal = valorFinal + Double(pilaCalculadora[contador + 1])!
                contador = contador + 2
            case "resta":
                valorFinal = valorFinal - Double(pilaCalculadora[contador + 1])!
                contador = contador + 2
            default:
                break
            }
        }
        return valorFinal
    }
    
    
    @IBAction func btnCE(_ sender: UIButton) {
        lblValorActual.text = ""
        lblValorAcumulado.text = ""
        pilaCalculadora.removeAll()
        bCalculoRealizado = false
    }
    
}

