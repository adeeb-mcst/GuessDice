//
//  ViewController.swift
//  GuessDice
//
//  Created by Mac on 12/11/18.
//  Copyright © 2018 Adeeb.MCST. All rights reserved.
//
// Images Assets from www.codewithchris.com

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tLabel:UILabel!
    @IBOutlet weak var dice1PlayerImg:UIImageView!
    @IBOutlet weak var dice2PlayerImg:UIImageView!
    @IBOutlet weak var dice1CPUImg:UIImageView!
    @IBOutlet weak var dice2CPUImg:UIImageView!
    @IBOutlet weak var scorePlayer:UILabel!
    @IBOutlet weak var scoreCPU:UILabel!
    @IBOutlet weak var turnStat:UISegmentedControl!
    @IBOutlet weak var dice1Guess:UISegmentedControl!
    @IBOutlet weak var dice2Guess:UISegmentedControl!
    @IBOutlet weak var topScoreStat: UISegmentedControl!
    @IBOutlet weak var newGameBtn: UIButton!
    
    var seconds = 0
    var timer = Timer()
    var altDice = false
    var gameStarted = 0
    var totalPlayerScore = 0
    var totalCPUScore = 0
    //var calcAnim = "Calculating"
    
    let animatedImages1 =  [UIImage(named:"Dice1")!,UIImage(named:"Dice2")!,UIImage(named:"Dice3")!,UIImage(named:"Dice4")!,UIImage(named:"Dice5")!,UIImage(named:"Dice6")!]
    let animatedImages2 =  [UIImage(named:"Dice2")!,UIImage(named:"Dice3")!,UIImage(named:"Dice4")!,UIImage(named:"Dice5")!,UIImage(named:"Dice6")!,UIImage(named:"Dice1")!]
    let animatedImages3 =  [UIImage(named:"Dice3")!,UIImage(named:"Dice4")!,UIImage(named:"Dice5")!,UIImage(named:"Dice6")!,UIImage(named:"Dice1")!,UIImage(named:"Dice2")!]
    let animatedImages4 =  [UIImage(named:"Dice4")!,UIImage(named:"Dice5")!,UIImage(named:"Dice6")!,UIImage(named:"Dice1")!,UIImage(named:"Dice2")!,UIImage(named:"Dice3")!]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        runTimer()
        //let imagesDice = UIImage.animatedImage(with: animatedImages, duration: 7)
        dice1PlayerImg.image = UIImage.animatedImage(with: animatedImages1, duration: 7)
        dice2PlayerImg.image = UIImage.animatedImage(with: animatedImages3, duration: 7)
        dice1CPUImg.image = UIImage.animatedImage(with: animatedImages2, duration: 7)
        dice2CPUImg.image = UIImage.animatedImage(with: animatedImages4, duration: 7)
    }
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(ViewController.updateTimer)), userInfo: nil, repeats: true)
        print("runTimer")
    }
    
    func updateScore() {
        if(turnStat.selectedSegmentIndex == 0) {
            //player's score
//            print("Start 01 Update Player Score")
//            print(dice1PlayerImg.tag)
//            print(dice1Guess.selectedSegmentIndex+1)
//            print("Start 02 Update Player Score")
//            print(dice2PlayerImg.tag)
//            print(dice2Guess.selectedSegmentIndex+1)
            if(dice1PlayerImg.tag == dice1Guess.selectedSegmentIndex+1) {
                totalPlayerScore+=3
            }
            
            if(dice2PlayerImg.tag == dice2Guess.selectedSegmentIndex+1) {
                totalPlayerScore+=3
            }
            scorePlayer.text = String(totalPlayerScore)
            newGameBtn.setTitle("CPU's Turn", for: .normal)
            print("End Update Player Score")
        } else {
            if(dice1CPUImg.tag == dice1Guess.selectedSegmentIndex+1) {
                totalCPUScore+=3
            }
            
            if(dice2CPUImg.tag == dice2Guess.selectedSegmentIndex+1) {
                totalCPUScore+=3
            }
            scoreCPU.text = String(totalCPUScore)
            newGameBtn.setTitle("Player's Turn", for: .normal)
            print("End Update CPU Score")
        }
        //calcAnim = "Calculating"
    }
    
    func endGame() {
        
    }
    
    @objc func updateTimer() {
        if(gameStarted < 1 && newGameBtn.isEnabled) {
            if(altDice) {
                //dice1PlayerImg.image=UIImage(named: "Dice"+String(Int.random(in: 1 ... 6)))
                //dice1CPUImg.image=UIImage(named: "Dice"+String(Int.random(in: 1 ... 6)))
                turnStat.selectedSegmentIndex = 0
                //newGameBtn.setTitle("Player's Roll", for: .normal)
                dice1Guess.selectedSegmentIndex = Int.random(in: 0 ... 5)
                dice2Guess.selectedSegmentIndex = Int.random(in: 0 ... 5)
                //topScoreStat.selectedSegmentIndex = Int.random(in: 1 ... 3)
            }else {
                //dice2PlayerImg.image=UIImage(named: "Dice"+String(Int.random(in: 1 ... 6)))
                //dice2CPUImg.image=UIImage(named: "Dice"+String(Int.random(in: 1 ... 6)))
                turnStat.selectedSegmentIndex = 1
                //newGameBtn.setTitle("CPU's Roll", for: .normal)
                dice1Guess.selectedSegmentIndex = Int.random(in: 0 ... 5)
                dice2Guess.selectedSegmentIndex = Int.random(in: 0 ... 5)
                //topScoreStat.selectedSegmentIndex = Int.random(in: 1 ... 3)
            }
            altDice = !altDice
            //print("updateTimer")
        } else if(gameStarted == 1) {
            if(turnStat.selectedSegmentIndex == 1) {
                dice1Guess.selectedSegmentIndex = dice1CPUImg.tag
                dice2Guess.selectedSegmentIndex = dice2CPUImg.tag
            }

        } else if(gameStarted < 3) {
            //calcAnim+="."
            newGameBtn.setTitle("Calculating...", for: .normal)
            gameStarted+=1
        } else if(gameStarted == 3) {
            //timer.invalidate()
            gameStarted+=1
            updateScore()
        } else if(gameStarted > 3) {
            if(turnStat.selectedSegmentIndex == 0) {
                //newGameBtn.isEnabled = false
                turnStat.selectedSegmentIndex = 1
                newGameBtn.setTitle("CPU's Roll", for: .normal)
                rollDice()
                gameStarted = 1
                newGameBtn.isEnabled = true
            } else {
                ///TEST END GAME
                let pScore = Int(scorePlayer.text!)
                let cpuScore = Int(scoreCPU.text!)
                let tScore = Int(topScoreStat.titleForSegment(at: topScoreStat.selectedSegmentIndex)!)
                
                if(pScore != cpuScore) {
                    if(pScore! >= tScore!)&&(pScore! > cpuScore!) {
                        //Show Alert
                        let alert = UIAlertController(title: "Game Over!", message: "You Won!", preferredStyle: UIAlertController.Style.alert)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    } else if(cpuScore! >= tScore!)&&(cpuScore! > pScore!) {
                        //Show Alert
                        let alert = UIAlertController(title: "Game Over!", message: "You Lost!", preferredStyle: UIAlertController.Style.alert)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                }
                ///TEST END GAME
                turnStat.selectedSegmentIndex = 0
                newGameBtn.setTitle("Player's Roll", for: .normal)
                rollDice()
                gameStarted = 1
                newGameBtn.isEnabled = true
                dice1Guess.isEnabled = true
                dice2Guess.isEnabled = true
            }
            //updateTimer()
        }
        
    }
    
    func rollDice() {
        if(turnStat.selectedSegmentIndex == 0) {
            dice1PlayerImg.image = UIImage.animatedImage(with: animatedImages1, duration: 2)
            dice2PlayerImg.image = UIImage.animatedImage(with: animatedImages3, duration: 2)
            dice1CPUImg.image = #imageLiteral(resourceName: "Roll")
            dice2CPUImg.image = #imageLiteral(resourceName: "Roll")
        } else {
            dice1CPUImg.image = UIImage.animatedImage(with: animatedImages1, duration: 2)
            dice2CPUImg.image = UIImage.animatedImage(with: animatedImages3, duration: 2)
            dice1PlayerImg.image = #imageLiteral(resourceName: "Roll")
            dice2PlayerImg.image = #imageLiteral(resourceName: "Roll")
        }
        
        //runTimer()
    }
    
    @IBAction func newGame(sender: UIButton!) {
        //newGameBtn.setTitle("Roll", for: .normal)
        if(gameStarted == 1) {
            if(turnStat.selectedSegmentIndex == 0) {
                sender.isEnabled = false
                dice1Guess.isEnabled = false
                dice2Guess.isEnabled = false
                dice1PlayerImg.tag = Int.random(in: 1 ... 6)
                dice2PlayerImg.tag = Int.random(in: 1 ... 6)
                dice1PlayerImg.image=UIImage(named: "Dice"+String(dice1PlayerImg.tag))
                dice2PlayerImg.image=UIImage(named: "Dice"+String(dice2PlayerImg.tag))
                gameStarted+=1
            } else {
                sender.isEnabled = false
                dice1Guess.isEnabled = false
                dice2Guess.isEnabled = false
                dice1CPUImg.tag = Int.random(in: 1 ... 6)
                dice2CPUImg.tag = Int.random(in: 1 ... 6)
                dice1CPUImg.image=UIImage(named: "Dice"+String(dice1CPUImg.tag))
                dice2CPUImg.image=UIImage(named: "Dice"+String(dice2CPUImg.tag))
                gameStarted+=1
            }
            
            //updateTimer()
            //newGameBtn.isEnabled = true
        } else {
            gameStarted = 1
            //timer.invalidate()
            turnStat.selectedSegmentIndex = 0
            sender.setTitle("Player's Roll", for: .normal)
            topScoreStat.isUserInteractionEnabled = false
            if(topScoreStat.selectedSegmentIndex == 0) {
                topScoreStat.selectedSegmentIndex = 1
            }
            dice1PlayerImg.image = #imageLiteral(resourceName: "Roll")
            dice2PlayerImg.image = #imageLiteral(resourceName: "Roll")
            dice1CPUImg.image = #imageLiteral(resourceName: "Roll")
            dice2CPUImg.image = #imageLiteral(resourceName: "Roll")
            rollDice()
        }
        
    }
    
    @IBAction func resetGame() {
        newGameBtn.setTitle("Start Player", for: .normal)
        newGameBtn.isEnabled = true
        scorePlayer.text = "0"
        scoreCPU.text = "0"
        dice1PlayerImg.image = UIImage.animatedImage(with: animatedImages1, duration: 7)
        dice2PlayerImg.image = UIImage.animatedImage(with: animatedImages3, duration: 7)
        dice1CPUImg.image = UIImage.animatedImage(with: animatedImages2, duration: 7)
        dice2CPUImg.image = UIImage.animatedImage(with: animatedImages4, duration: 7)
    }


}

