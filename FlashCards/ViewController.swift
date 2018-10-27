//
//  ViewController.swift
//  FlashCards
//
//  Created by Alex Kowalczuk on 10/13/18.
//  Copyright © 2018 Alex Kowalczuk. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var frontLabel: UILabel!
    @IBOutlet weak var backLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didTapOnFlashcard(_ sender: Any) {
        if(frontLabel.isHidden == true){
            frontLabel.isHidden = false;
        }
        else{
            frontLabel.isHidden = true
        }
    }
    
    func updateFlashcard(question: String, answer: String){
        frontLabel.text = question
        backLabel.text = answer
    }
    
    override func prepare(for segure: UIStoryboardSegue, sender: Any?){
        
        let navigationController = segure.destination as! UINavigationController
        
        let creationController = navigationController.topViewController as! CreationViewController
        
        creationController.flashcardsController = self
    }
}

