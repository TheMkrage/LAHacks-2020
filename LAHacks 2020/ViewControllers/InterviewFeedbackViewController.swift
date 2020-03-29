//
//  InterviewFeedbackViewController.swift
//  LAHacks 2020
//
//  Created by Matthew Krager on 3/28/20.
//  Copyright © 2020 Matthew Krager. All rights reserved.
//

import UIKit
import ROGoogleTranslate
import AVKit
import Presentr

class InterviewFeedbackViewController: UIViewController {

    let questions = [
        CultureQuestion(question:"Describe a time where you experienced conflict."),
        CultureQuestion(question:"Please explain one area of weakness and one area of strength."),
        CultureQuestion(question:"What are your long-term career plans?"),
        CultureQuestion(question:"Why do you want to work at this company?"),
        CultureQuestion(question:"Provide an example where you led a team through obstacles."),
        CultureQuestion(question:"What is a current event of interest to you?"),
        CultureQuestion(question:"Why are you interested in this position?")
    ]
    @IBOutlet weak var questionEnglishLabel: UILabel!
    @IBOutlet weak var questionSpanishLabel: UILabel!
    lazy var question = questions[0]
    
    var isRecording: Bool {
        get {
            return audioRecorder != nil
        }
    }
    
    var recordingSession: AVAudioSession!
    var audioRecorder: AVAudioRecorder!
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Fluent"
        translate()
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
        NetworkingStore.shared.uploadInterviewFeedbackAudio(allback: { (feedback) in
            DispatchQueue.main.async {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let controller = storyboard.instantiateViewController(withIdentifier: "Feedback") as! FeedbackViewController
                controller.feedback = feedback
                controller.question = self.question.question
                let presenter = Presentr(presentationType: .popup)
                self.customPresentViewController(presenter, viewController: controller, animated: true, completion: nil)
            }
        })
        print("finished")
    }
    
    private func translate() {
        let translator = ROGoogleTranslate()
        translator.apiKey = Keys.google
        self.questionSpanishLabel.text = ""
        
        let params = ROGoogleTranslateParams(source: "en",
                                             target: NetworkingStore.shared.language,
            text: question.question)
        translator.translate(params: params) { (result) in
            DispatchQueue.main.async {
                self.questionSpanishLabel.text = result
            }
        }
    }
    
    @IBAction func record(_ sender: UIButton) {
        if isRecording {
            sender.setImage(UIImage.init(named: "microphone"), for: .normal)
            sender.backgroundColor = UIColor.init(named: "LanguagePick Background")
            finishRecording(success: true)
        } else {
            sender.setImage(UIImage.init(named: "stop"), for: .normal)
            sender.backgroundColor = UIColor.init(named: "stop")
            startRecording()
        }
    }
    
    @IBAction func nextQuestion(_ sender: Any) {
        let index = questions.firstIndex(where: { (q) -> Bool in
            return q.question == self.question.question
        })! + 1
        
        question = questions[index]
        questionEnglishLabel.text = question.question
        self.translate()
    }
}

extension InterviewFeedbackViewController: AVAudioRecorderDelegate {
    
}
