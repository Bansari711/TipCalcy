//
//  PdfViewController.swift
//  TipCalcy
//
//  Created by Bansari on 8/29/17.
//  Copyright © 2017 Bansari. All rights reserved.
//

import UIKit

class PdfViewController: UIViewController {

    @IBOutlet var pdfWebView: UIWebView!
    var pdfFileName = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadPDF(filename: pdfFileName)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    func loadPDF(filename: String) {
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let filePath = "\(documentsPath)/\(filename).pdf"
        let url = NSURL(fileURLWithPath: filePath)
        let urlRequest = URLRequest(url: url as URL)
        
        pdfWebView.loadRequest(urlRequest)
    }
}
