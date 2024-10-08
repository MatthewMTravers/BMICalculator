//
//  AudioPlayerService.swift
//  BMICalculator
//
//  Created by Matthew Travers on 8/6/24.
//

import Foundation
import AVFoundation

protocol AudioPlayerService {
    func playSound()
}

final class DefaultAudioPlayer: AudioPlayerService {
    
    private var player: AVAudioPlayer?
    
    /// Plays sound when logo is clicked
    func playSound() {
        let path = Bundle.main.path(forResource: "LogoClickSound", ofType: "m4a")!
        let url = URL(fileURLWithPath: path)
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch (let error) {
            print(error.localizedDescription)
        }
    }
}
