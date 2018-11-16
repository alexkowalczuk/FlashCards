//
//  ViewController.swift
//  FlashCards
//
//  Created by Alex Kowalczuk on 10/13/18.
//  Copyright © 2018 Alex Kowalczuk. All rights reserved.
//

import UIKit

struct Flashcard{
    var question: String
    var answer: String
}

class ViewController: UIViewController {

    
    @IBOutlet weak var frontLabel: UILabel!
    @IBOutlet weak var backLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var prevButton: UIButton!
    
    // Array to hold our flashcards
    var flashcards = [Flashcard]()
    var currentIndex = 0
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        readSavedFlashcards()
        
        if flashcards.count == 0 {
            updateFlashcard(question: "Whats's the capital of Brazil?", answer: "Brasilia")
        }
        else{
            updateLabels()
            updateNextPrevButtons()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func didTapOnNext(_ sender: Any) {
        currentIndex = currentIndex + 1 //icrease curr index
        
        updateLabels() //update labels
        
        updateNextPrevButtons() //update buttons
    }
    
    @IBAction func didTapOnPrev(_ sender: Any) {
        currentIndex = currentIndex - 1
        
        updateLabels()
        
        updateNextPrevButtons()
    }
    
    func updateNextPrevButtons()
    {
        if currentIndex == flashcards.count - 1
        {
            nextButton.isEnabled = false
        }
        else
        {
            nextButton.isEnabled = true
        }
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
        let flashcard = Flashcard(question: question, answer: answer)
        //frontLabel.text = flashcard.question
        //backLabel.text = flashcard.answer
        
        flashcards.append(flashcard) // Adding flashcar in the flashcard array
        print("🙉 Added new flashcard!")
        print("🙉 We now have \(flashcards.count) flashcards")
        
        currentIndex = flashcards.count - 1
        print("🙉 Our current index is \(currentIndex)")
        
        updateNextPrevButtons()
        
        updateLabels()
        
        saveAllFlashcardsToDisk()
    }
    
    func updateLabels(){
        let currentFlashcard = flashcards[currentIndex]
        frontLabel.text = currentFlashcard.question
        backLabel.text = currentFlashcard.answer
    }
    
    func saveAllFlashcardsToDisk(){
        let dictionaryArray = flashcards.map { (card) -> [String: String] in
            return ["question": card.question, "answer": card.answer]
        }
        UserDefaults.standard.set(dictionaryArray, forKey: "flashcard")
    }
        
    func readSavedFlashcards(){
        if let dictionaryArray = UserDefaults.standard.array(forKey: "flashcards") as? [[String: String]]{
            let savedCards = dictionaryArray.map {dictionary -> Flashcard in
                return Flashcard(question: dictionary["question"]!, answer: dictionary["answer"]!)}
            flashcards.append(contentsOf: savedCards)}
        }
    
    
    
    override func prepare(for segure: UIStoryboardSegue, sender: Any?){
        
        let navigationController = segure.destination as! UINavigationController
        
        let creationController = navigationController.topViewController as! CreationViewController
        
        creationController.flashcardsController = self
    }
}

