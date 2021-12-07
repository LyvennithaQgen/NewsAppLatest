//
//  ViewMoreViewController.swift
//  NewsApp
//
//  Created by Lyvennitha on 07/12/21.
//

import Foundation
import UIKit
import WebKit

class ViewMoreNewsController: UIViewController{
    @IBOutlet weak var webView: WKWebView!
    
    var urlStriing = ""
    var titleStr = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.load(NSURLRequest(url: NSURL(string: urlStriing)! as URL) as URLRequest)
        self.title = titleStr
    }
}
