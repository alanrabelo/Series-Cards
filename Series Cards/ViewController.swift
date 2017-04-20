//
//  ViewController.swift
//  Series Cards
//
//  Created by Alan Rabelo Martins on 20/04/17.
//  Copyright © 2017 Alan Rabelo Martins. All rights reserved.
//

import UIKit
import Koloda

private var numberOfCards: Int = 5

class ViewController: UIViewController {
    @IBOutlet weak var kolodaView: KolodaView!
    
    fileprivate var dataSource: [Word] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        kolodaView.delegate = self
        kolodaView.dataSource = self
        
        
        self.modalTransitionStyle = UIModalTransitionStyle.flipHorizontal
        
        Word.all { words in
            self.dataSource = words as! [Word]
            self.kolodaView.reloadData()
        }

        // Do any additional setup after loading the view, typically from a nib.
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
        return dataSource.count
    }
    
    func kolodaSpeedThatCardShouldDrag(_ koloda: KolodaView) -> DragSpeed {
        return .default
    }
    
    func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView {
        
        let currentWord = self.dataSource[index]
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

