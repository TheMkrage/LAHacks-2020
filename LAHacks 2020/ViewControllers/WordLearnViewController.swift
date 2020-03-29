//
//  WordLearnViewController.swift
//  LAHacks 2020
//
//  Created by Matthew Krager on 3/28/20.
//  Copyright © 2020 Matthew Krager. All rights reserved.
//

import UIKit
import AVKit

class WordLearnViewController: UIViewController {

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
    
    let words = ["collaborate", "teamwork", "experience", "synergy"]
    var isRecording: Bool {
        get {
            return audioRecorder != nil
        }
    }
    var word = "collaborate"
    var recordingSession: AVAudioSession!
    var audioRecorder: AVAudioRecorder!
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
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
        NetworkingStore.shared.uploadAudio(word: word, callback: { (score) in
            if score > 0.9 {
                self.feedbackLabel.text = "Perfect Pronunciation!"
            } else if score > 0.7 {
                self.feedbackLabel.text = "Great Progress! You are almost there"
            } else if score > 0.4 {
                self.feedbackLabel.text = "Keep Practicing! Try to copy the animation!"
            } else {
                self.feedbackLabel.text = "Oh? Speak more clearly into the mic!"
            }
            
        })
        print("finished")
    }

    @IBAction func recordButton(_ sender: UIButton) {
        if isRecording {
            sender.setImage(UIImage.init(named: "microphone"), for: .normal)
            finishRecording(success: true)
        } else {
            sender.setImage(UIImage.init(named: "stop"), for: .normal)
            startRecording()
        }
        self.gifView.isHidden = false
        self.definitionWrapperView.isHidden = true
    }
    
    @IBAction func nextWordButton(_ sender: Any) {
        let index = words.firstIndex(of: word)! + 1
        word = words[index]
        wordEnglishLabel.text = word
        wordEnglishLabel2.text = word
        self.gifView.isHidden = true
        self.definitionWrapperView.isHidden = false
    }
}

extension WordLearnViewController: AVAudioRecorderDelegate {
    
}
