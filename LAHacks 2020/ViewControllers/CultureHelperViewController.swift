//
//  CultureHelperViewController.swift
//  LAHacks 2020
//
//  Created by Matthew Krager on 3/28/20.
//  Copyright © 2020 Matthew Krager. All rights reserved.
//

import UIKit
import ROGoogleTranslate

enum Languages: String {
    case spanish = "es"
    case chinese = "zh"
    case japanese = "ja"
    case french = "fr"
}

class CultureHelperViewController: UIViewController {
    @IBOutlet weak var tipCard: WhiteCardView!
    
    let tips = [
        CultureTip(language: Languages.spanish, tip: "Answer questions in a calm, even-speed tone while maintaining eye contact with your interviewer. If a question breaks your concentration, feel free to ask for time or to move onto another question until you’re ready to answer them."),
        CultureTip(language: Languages.spanish, tip:"Shaking hands with a firm grasp is a respectful greeting in interview settings. Don’t shy away from an initial handshake upon meeting your interviewer!"),
        CultureTip(language: Languages.spanish, tip: "When applying in certain countries your interviewer will likely appreciate personal space beyond the initial firm handshake. Be mindful of the space you encroach (about a table’s width apart)"),
        CultureTip(language: Languages.spanish, tip: "Send between 0.5 to 12 hours after your interview thanking the recruiter for their time and reference 1 to 2 interesting points of information you learned from the recruiter"),
        CultureTip(language: Languages.spanish, tip: "Avoid framing aspects of your former employer in a negative light"),
        CultureTip(language: Languages.spanish, tip: "Almost all jobs/industries prefer business professional"),
        CultureTip(language: Languages.spanish, tip: "Know your recruiter’s background using LinkedIn and Google Search for follow-up question content"),
        CultureTip(language: Languages.chinese, tip: "Answer questions in a calm, even-speed tone while maintaining eye contact with your interviewer. If a question breaks your concentration, feel free to ask for time or to move onto another question until you’re ready to answer them."),
        CultureTip(language: Languages.chinese, tip: "When applying in certain countries your interviewer will likely appreciate personal space beyond the initial firm handshake. Be mindful of the space you encroach (about a table’s width apart)"),
        CultureTip(language: Languages.chinese, tip: "Send between 0.5 to 12 hours after your interview thanking the recruiter for their time and reference 1 to 2 interesting points of information you learned from the recruiter"),
        CultureTip(language: Languages.chinese, tip: "Avoid framing aspects of your former employer in a negative light"),
        CultureTip(language: Languages.chinese, tip: "Almost all jobs/industries prefer business professional"),
        CultureTip(language: Languages.chinese, tip: "Know your recruiter’s background using LinkedIn and Google Search for follow-up question content"),
        CultureTip(language: Languages.chinese, tip: "Shaking hands with a firm grasp is a respectful greeting in interview settings. Don’t shy away from an initial handshake upon meeting your interviewer"),
        CultureTip(language: Languages.french, tip: "Answer questions in a calm, even-speed tone while maintaining eye contact with your interviewer. If a question breaks your concentration, feel free to ask for time or to move onto another question until you’re ready to answer them."),
        CultureTip(language: Languages.french, tip: "When applying in certain countries your interviewer will likely appreciate personal space beyond the initial firm handshake. Be mindful of the space you encroach (about a table’s width apart)"),
        CultureTip(language: Languages.french, tip: "Send between 0.5 to 12 hours after your interview thanking the recruiter for their time and reference 1 to 2 interesting points of information you learned from the recruiter"),
        CultureTip(language: Languages.french, tip: "Avoid framing aspects of your former employer in a negative light"),
        CultureTip(language: Languages.french, tip: "Almost all jobs/industries prefer business professional"),
        CultureTip(language: Languages.french, tip: "Know your recruiter’s background using LinkedIn and Google Search for follow-up question content"),
        CultureTip(language: Languages.french, tip: "Shaking hands with a firm grasp is a respectful greeting in interview settings. Don’t shy away from an initial handshake upon meeting your interviewer"),
        CultureTip(language: Languages.japanese, tip: "Answer questions in a calm, even-speed tone while maintaining eye contact with your interviewer. If a question breaks your concentration, feel free to ask for time or to move onto another question until you’re ready to answer them."),
        CultureTip(language: Languages.japanese, tip: "When applying in certain countries your interviewer will likely appreciate personal space beyond the initial firm handshake. Be mindful of the space you encroach (about a table’s width apart)"),
        CultureTip(language: Languages.japanese, tip: "Send between 0.5 to 12 hours after your interview thanking the recruiter for their time and reference 1 to 2 interesting points of information you learned from the recruiter"),
        CultureTip(language: Languages.japanese, tip: "Avoid framing aspects of your former employer in a negative light"),
        CultureTip(language: Languages.japanese, tip: "Almost all jobs/industries prefer business professional"),
        CultureTip(language: Languages.japanese, tip: "Know your recruiter’s background using LinkedIn and Google Search for follow-up question content"),
        CultureTip(language: Languages.japanese, tip: "Shaking hands with a firm grasp is a respectful greeting in interview settings. Don’t shy away from an initial handshake upon meeting your interviewer"),

    ]
    
    @IBOutlet weak var artImageView: UIImageView!
    @IBOutlet weak var tipSpanishLabel: UILabel!
    @IBOutlet weak var tipLabel: UILabel!
    
    lazy var tip: CultureTip = self.tips.first!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tipLabel.text = tip.tip
        translate()
        self.title = "Fluent"
    }
    
    @IBAction func nextTip(_ sender: Any) {
        let index = tips.firstIndex(where: { (tip) -> Bool in
            return tip.tip == self.tip.tip
        })! + 1

        tip = tips[index]
        tipLabel.text = tip.tip
        
        self.translate()
    }
    
    private func translate() {
        let translator = ROGoogleTranslate()
        translator.apiKey = Keys.google
        self.tipSpanishLabel.text = ""
        
        let params = ROGoogleTranslateParams(source: "en",
                                             target: NetworkingStore.shared.language,
            text: tip.tip)
        translator.translate(params: params) { (result) in
            DispatchQueue.main.async {
                self.tipSpanishLabel.text = result
            }
        }
    }
}
