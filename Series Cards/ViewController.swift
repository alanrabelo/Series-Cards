//
//  ViewController.swift
//  Series Cards
//
//  Created by Alan Rabelo Martins on 20/04/17.
//  Copyright © 2017 Alan Rabelo Martins. All rights reserved.
//

enum Localization {
    case local
    case global
}

import UIKit
import Koloda
import FirebaseAuth

private var numberOfCards: Int = 5

class ViewController: UIViewController {
    @IBOutlet weak var kolodaView: KolodaView!
    
    fileprivate var dataSource: [Word] = []
    fileprivate var globalDataSource: [Word] = []
    fileprivate var userName : String!
    fileprivate var localization : Localization = .local
    
    override func viewDidLoad() {
        
        User.verifyiCloud()
        
        super.viewDidLoad()
        kolodaView.delegate = self
        kolodaView.dataSource = self
        
        if let userID = UserDefaults.standard.value(forKey: "id") as? String {
            self.userName = userID
        } else {
            self.userName = ""
        }
        
        self.modalTransitionStyle = UIModalTransitionStyle.flipHorizontal
        
        Word.all { words in
            
            self.dataSource = (words as! [Word]).filter({ (word) -> Bool in
                return word.user == self.userName
            })
            
            self.globalDataSource = (words as! [Word]).filter({ (word) -> Bool in
                return word.user != self.userName
            })
            
            self.dataSource.shuffle()
            self.globalDataSource.shuffle()
            
            DispatchQueue.main.async {
                self.kolodaView.reloadData()
            }
            
        }
        
        

        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func changeWordsScope(_ sender: UISegmentedControl) {
        localization = sender.selectedSegmentIndex == 0 ? .local : .global
        self.kolodaView.resetCurrentCardIndex()
        self.kolodaView.reloadData()
    }
    
    @IBAction func addNewWord(_ sender: Any) {

        if FIRAuth.auth()!.currentUser != nil {
            self.performSegue(withIdentifier: "newWord", sender: nil)
        } else {
            performSegue(withIdentifier: "ShowAuthentication", sender: nil)
        }
    }
}

extension ViewController: KolodaViewDelegate {
    
    func kolodaDidRunOutOfCards(_ koloda: KolodaView) {
        koloda.resetCurrentCardIndex()
    }
    
    func koloda(_ koloda: KolodaView, didSelectCardAt index: Int) {
        UIApplication.shared.openURL(URL(string: "https://yalantis.com/")!)
    }
    
    
    @IBAction func unwindFrom(segue unwindSegue: UIStoryboardSegue) {
        let addView = unwindSegue.source as! NewWordViewController
        let newWord = Word(withWord: addView.textFieldWord.text!, andTranslation: addView.textFieldTranslation.text!, andTranslationDescription: addView.textViewDescription.text)
        
        newWord.save()
        
        
    }
    
}


// MARK: KolodaViewDataSource

extension ViewController: KolodaViewDataSource {
    
    func kolodaNumberOfCards(_ koloda: KolodaView) -> Int {
        return localization == .local ? dataSource.count : globalDataSource.count
    }
    
    func kolodaSpeedThatCardShouldDrag(_ koloda: KolodaView) -> DragSpeed {
        return .default
    }
    
    
    func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView {
        
        let currentWord = localization == .local ? dataSource[index] : globalDataSource[index]
        let view = Bundle.main.loadNibNamed("WordView", owner: nil, options: nil)?.first! as! WordView
        view.labelWord.text = currentWord.word
        view.labelTranslation.text = currentWord.translation
        view.labelDescription.text = currentWord.translationDescription
        return view
    }

}

public enum DragSpeed: TimeInterval {
    case slow = 2.0
    case moderate = 1.5
    case `default` = 0.8
    case fast = 0.4
}

