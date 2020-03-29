//
//  HomeWithCardsViewController.swift
//  LAHacks 2020
//
//  Created by Matthew Krager on 3/28/20.
//  Copyright © 2020 Matthew Krager. All rights reserved.
//

import UIKit

class HomeWithCardsViewController: UIViewController {

    @IBAction func tapLearnWords(_ sender: UITapGestureRecognizer) {
        print("beabs")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "WordLearn")
        self.show(controller, sender: self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
