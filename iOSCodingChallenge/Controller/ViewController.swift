//
//  ViewController.swift
//  iOSCodingChallenge
//
//  Created by Hamza Iqbal on 06/09/2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var simpleBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.customization()
        // Do any additional setup after loading the view.
    }
    
    func customization () {
        simpleBtn.layer.cornerRadius = 5
        self.title = "iOS Coding Challenge"
    }
    
    override func viewDidAppear(_ animated: Bool) {

    }
    
    
    @IBAction func simplestWayAction(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "PhotoViewController") as? PhotoViewController
        self.navigationController?.pushViewController(vc!, animated: true)
    }
}
