//
//  WordLearnViewController.swift
//  LAHacks 2020
//
//  Created by Matthew Krager on 3/28/20.
//  Copyright © 2020 Matthew Krager. All rights reserved.
//

import UIKit
import AVKit
import SwiftyGif
import ROGoogleTranslate

class WordLearnViewController: UIViewController {
    @IBOutlet weak var phonemeLabel: UILabel!
    
    @IBOutlet weak var feedbackLabel: UILabel!
    @IBOutlet weak var definitionWrapperView: WhiteCardView!
    @IBOutlet weak var gifWrapperView: WhiteCardView!
    @IBOutlet weak var wordEnglishLabel: UILabel!
    @IBOutlet weak var wordSpanishLabel: UILabel!
    @IBOutlet weak var wordSpanishLabel2: UILabel!
    @IBOutlet weak var wordEnglishLabel2: UILabel!
    @IBOutlet weak var definitionEnglishLabel: UILabel!
    @IBOutlet weak var gifView: UIImageView!
    @IBOutlet weak var definitionSpanishLabel: UILabel!
    var shapeLayer: CAShapeLayer?
    let words = [
        CultureWord(word:"Impact", definition:"the force of impression of one thing on another : a significant or major effect"),
        CultureWord(word:"Communicate", definition:"to convey knowledge of or information about"),
        CultureWord(word:"Teamwork", definition:"work done by several associates with each doing a part but all subordinating personal prominence to the efficiency of the whole"),
        CultureWord(word:"Collaboration", definition:"to work jointly with others or together especially in an intellectual endeavor"),
        CultureWord(word:"Opportunity", definition:"a good chance for advancement or progress"),
        CultureWord(word:"Leadership",definition:"roviding direction or guidance"),
        CultureWord(word:"Manage",definition:"to exercise executive, administrative, and supervisory direction of"),
        CultureWord(word:"Strategy",definition:"a careful plan or method"),
        CultureWord(word:"Influence",definition:"the act or power of producing an effect without apparent exertion of force or direct exercise of command"),
        CultureWord(word:"Flexible",definition:"characterized by a ready capability to adapt to new, different, or changing requirements"),
        CultureWord(word:"Organization",definition:"an administrative and functional structure (such as a business or a political party)"),
        CultureWord(word:"Motivation",definition:"to urge or drive forward or on by or as if by the exertion of strong moral pressure"),
        CultureWord(word:"Passionate",definition:"capable of, affected by, or expressing intense feeling"),
        CultureWord(word:"Certified",definition:"to recognize as having met special qualifications (as of a governmental agency or professional board) within a field"),
        CultureWord(word:"Experience",definition:"direct observation of or participation in events as a basis of knowledge"),
        CultureWord(word:"Rewarding",definition:"yielding or likely to yield a reward"),
        CultureWord(word:"Supervised",definition:"to be in charge of"),
        CultureWord(word:"Delegate",definition:"to entrust to another"),
        CultureWord(word:"Developed",definition:"to create or produce especially by deliberate effort over time")
    ]
    var phonemesPermanent: [String] = ["IH", "M", "P", "AE", "K", "T"]
    var phonemes: [String] = ["T"]
    var isRecording: Bool {
        get {
            return audioRecorder != nil
        }
    }
    
    lazy var word = words.first!
    var recordingSession: AVAudioSession!
    var audioRecorder: AVAudioRecorder!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.phonemeLabel.text = ""
        self.title = "Fluent"
        self.translate()
        wordEnglishLabel.text = word.word
        wordEnglishLabel2.text = word.word
        recordingSession = AVAudioSession.sharedInstance()
        feedbackLabel.text = ""
        do {
            try recordingSession.setCategory(.playAndRecord, mode: .default)
            try recordingSession.setActive(true)
            recordingSession.requestRecordPermission() { [unowned self] allowed in
                DispatchQueue.main.async {
                }
            }
        } catch {
            // failed to record!
        }
        self.fireTimer()
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    @objc private func fireTimer() {
        if let phoneme = phonemes.first {
            print(phoneme)
            do {
                let filename = "mouth_" + phoneme
                print(filename)
                let gif = try UIImage(gifName: filename)
                gifView.setGifImage(gif)
                gifView.animationRepeatCount = 1
                gifView.loopCount = 1
                self.phonemeLabel.text = phoneme.contains("relax") ? "" : phoneme
                phonemes.remove(at: 0)
                if(phonemes.count > 0) {
                    Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: false)
                } else {
                    self.phonemes = self.phonemesPermanent
                    Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: false)
                    
                    self.shapeLayer?.removeFromSuperlayer()

                    // create whatever path you want

                    let path = UIBezierPath()
                    self.wordEnglishLabel.layer.masksToBounds = false
                    path.move(to: CGPoint(x: 0, y: self.wordEnglishLabel.frame.height))
                    path.addLine(to: CGPoint(x: self.wordEnglishLabel.frame.width, y: self.wordEnglishLabel.frame.height))

                    // create shape layer for that path

                    let shapeLayer = CAShapeLayer()
                    shapeLayer.fillColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0).cgColor
                    shapeLayer.strokeColor = #colorLiteral(red: 0.5215686275, green: 0.3019607843, blue: 1, alpha: 1).cgColor
                    shapeLayer.lineWidth = 2
                    shapeLayer.path = path.cgPath

                    // animate it
                    wordEnglishLabel.layer.addSublayer(shapeLayer)
                    let animation = CABasicAnimation(keyPath: "strokeEnd")
                    animation.beginTime = CACurrentMediaTime() + 1.5
                    animation.fromValue = 0
                    animation.duration = Double((self.phonemesPermanent.count - 1)) * 0.5
                    shapeLayer.add(animation, forKey: "MyAnimation")
                    
                    // save shape layer
                    self.shapeLayer = shapeLayer
                }
            } catch {
                print(error)
            }
        }
    }
    
    func startRecording() {
        let audioFilename = getDocumentsDirectory().appendingPathComponent("recording.m4a")

        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 16000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue,
        ]

        do {
            print("audio recorder")
            audioRecorder = try AVAudioRecorder(url: audioFilename, settings: settings)
            audioRecorder.delegate = self
            audioRecorder.record()
        } catch {
            finishRecording(success: false)
        }
    }
    
    func finishRecording(success: Bool) {
        audioRecorder.stop()
        audioRecorder = nil
        NetworkingStore.shared.uploadAudio(word: word.word, callback: { (score, phonemes) in
            print(phonemes)
         
            self.phonemes = phonemes + ["_relax_to_close"]
            self.phonemesPermanent = phonemes + ["_relax_to_close"]
            if score > 0.9 {
                self.feedbackLabel.text = "Perfect Pronunciation!"
            } else if score > 0.7 {
                self.feedbackLabel.text = "Great Progress! You are almost there"
            } else if score > 0.4 {
                self.feedbackLabel.text = "Keep Practicing! Try to copy the animation!"
            } else {
                self.feedbackLabel.text = "Oh? Speak more clearly into the mic!"
            }
            
            //self.fireTimer()
            
        })
        print("finished")
    }

    @IBAction func recordButton(_ sender: UIButton) {
        if isRecording {
            sender.setImage(UIImage.init(named: "microphone"), for: .normal)
            sender.backgroundColor = UIColor.init(named: "LanguagePick Background")
            finishRecording(success: true)
        } else {
            sender.setImage(UIImage.init(named: "stop"), for: .normal)
            sender.backgroundColor = UIColor.init(named: "stop")
            startRecording()
        }
        self.gifView.isHidden = false
        self.definitionWrapperView.isHidden = true
    }
    
    private func translate() {
        let translator = ROGoogleTranslate()
        translator.apiKey = Keys.google
        self.wordSpanishLabel.text = ""
        self.wordSpanishLabel2.text = ""
        self.definitionSpanishLabel.text = ""
        
        let params = ROGoogleTranslateParams(source: "en",
                                             target: NetworkingStore.shared.language,
            text: word.word)
        translator.translate(params: params) { (result) in
            DispatchQueue.main.async {
                self.wordSpanishLabel.text = result
                self.wordSpanishLabel2.text = result
            }
        }
        
        let paramsDef = ROGoogleTranslateParams(source: "en",
            target: NetworkingStore.shared.language,
            text: word.definition)
        translator.translate(params: paramsDef) { (result) in
            DispatchQueue.main.async {
                self.definitionSpanishLabel.text = result
            }
        }
    }
    
    @IBAction func nextWordButton(_ sender: Any) {
        let index = words.firstIndex(where: { (word) -> Bool in
            return word.word == self.word.word
        })! + 1
        print(index)
        
        word = words[index]
        wordEnglishLabel.text = word.word
        wordEnglishLabel2.text = word.word
        definitionEnglishLabel.text = word.definition
        wordEnglishLabel2.text = word.word
        self.gifView.isHidden = true
        self.definitionWrapperView.isHidden = false
        feedbackLabel.text = ""

        self.translate()
    }
}

extension WordLearnViewController: AVAudioRecorderDelegate {
    
}
