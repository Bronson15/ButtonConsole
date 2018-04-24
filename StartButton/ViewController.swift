//
//  ViewController.swift
//  StartButton
//
//  Created by Bronson Lane on 6/9/16.
//  Copyright © 2016 iOSLife. All rights reserved.

import UIKit
import AVFoundation

class ViewController: UIViewController {
    var imageview = UIImageView()
    
    //delcaring our code as a String and the array of our input characters
    var code = String()
    var codeArray: [String] {
        return code.characters.map({ (character) -> String in
            return String(character)
        })
    }
    var input = String()
    var labelArray: [UILabel] = Array()
    var currentChar = 0
    
    //audio file declaration
    var correct = URL(fileURLWithPath: Bundle.main.path(forResource: "correct", ofType: "mp3")!)
    var wrong = URL(fileURLWithPath: Bundle.main.path(forResource: "wrong2", ofType: "mp3")!)
    var complete = URL(fileURLWithPath: Bundle.main.path(forResource: "complete", ofType: "mp3")!)
    var wrongAudioPlayer = AVAudioPlayer()
    var correctAudioPlayer = AVAudioPlayer()
    var completeAudioPlayer = AVAudioPlayer()
    var error: NSError?
    
    @IBOutlet weak var first: UILabel!
    @IBOutlet weak var second: UILabel!
    @IBOutlet weak var third: UILabel!
    @IBOutlet weak var fourth: UILabel!
    @IBOutlet var backgroundImage: UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        let value =  UIInterfaceOrientation.landscapeLeft.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
        UIViewController.attemptRotationToDeviceOrientation()
        showCodeAlert()
        
        do {
            correctAudioPlayer = try AVAudioPlayer(contentsOf: correct)
            wrongAudioPlayer = try AVAudioPlayer(contentsOf: wrong)
            completeAudioPlayer = try AVAudioPlayer(contentsOf: complete)
        } catch {
            print(error)
        }
        
        //loads up our audioPlayers 
        correctAudioPlayer.prepareToPlay()
        wrongAudioPlayer.prepareToPlay()
        completeAudioPlayer.prepareToPlay()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool){
        super.viewDidAppear(true)
        showCodeAlert()
    }

    override var prefersStatusBarHidden : Bool {
        return true
    }
    
    @IBOutlet var codeField: UITextField?
    func codeEntered(alert: UIAlertAction!){
        code = (self.codeField?.text)!
        print(code)
        print(codeArray)
    }
    
    //shows the admin the Enter Passcode screen
    func showCodeAlert() {
        let alert = UIAlertController(title: "Enter Passcode", message: "", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Submit", style: UIAlertActionStyle.default, handler: codeEntered))
        alert.addTextField(configurationHandler: {(textField: UITextField!) in
            textField.placeholder = "Enter passcode:"
            self.codeField = textField
            textField.isSecureTextEntry = false
        })
        self.present(alert, animated: true, completion: nil)
        
    }
    
    //checks the inputted number vs the correct current number
    func numberCheck(_ input: String) -> Bool {
        return input == codeArray[currentChar]
    }
    
    //if the number is wrong, display a red border and play the wrongAudio
    func wrongNumber() {
        labelArray[currentChar].layer.borderColor = UIColor.red.cgColor
        labelArray[currentChar].layer.borderWidth = 10.0
        wrongAudioPlayer.play()
    }
    
    //if the number is correct, display the number with a green border and play the correctAudio
    func rightNumber() {
        labelArray[currentChar].text = input
        labelArray[currentChar].layer.borderColor = UIColor.green.cgColor
        labelArray[currentChar].layer.borderWidth = 10.0
        if currentChar != 3 {
            correctAudioPlayer.play()
        }
    }
    
    //check the entire code
    func checkCode() -> Bool {
        return currentChar == code.characters.count
    }
    
    //function to check the current iteration of the code
    //if the code is complete, play the completeAudio and show the KidStuf Klubhouse
    func checkInput(_ input: String) {
        labelArray = [self.first, self.second, self.third, self.fourth]
        
        if numberCheck(input) {
            rightNumber()
            currentChar = currentChar + 1;
            if checkCode() == true {
                completeAudioPlayer.play()
                backgroundImage.image = UIImage(named: "Klubhouse Side.png")
                clearScreen()
            }
            return
        }
        wrongNumber()
    
    }
    
    func clearScreen() {
        self.first.text = ""
        self.first.layer.borderWidth = 0
        self.second.text = ""
        self.second.layer.borderWidth = 0
        self.third.text = ""
        self.third.layer.borderWidth = 0
        self.fourth.text = ""
        self.fourth.layer.borderWidth = 0
        
    }
    
    //buttons for the numpad
    @IBAction func oneButton() {
        input = "1"
        checkInput(input)
        print(codeArray)
    }
    
    @IBAction func twoButton() {
        input = "2"
        checkInput(input)
        print(codeArray)
    }
    
    @IBAction func threeButton() {
        input = "3"
        checkInput(input)
        print(codeArray)
    }
    
    @IBAction func fourButton() {
        input = "4"
        checkInput(input)
        print(codeArray)
    }
    
    @IBAction func fiveButton() {
        input = "5"
        checkInput(input)
        print(codeArray)
    }
    
    @IBAction func sixButton() {
        input = "6"
        checkInput(input)
        print(codeArray)
    }
    
    @IBAction func sevenButton() {
        input = "7"
        checkInput(input)
        print(codeArray)
    }
    
    @IBAction func eightButton() {
        input = "8"
        checkInput(input)
        print(codeArray)
    }
    
    @IBAction func nineButton() {
        input = "9"
        checkInput(input)
        print(codeArray)
    }
    
    @IBAction func zeroButton() {
        input = "0"
        checkInput(input)
        print(codeArray)
    }


    
    
}

