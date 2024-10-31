//
//  AudioPlayerService.swift
//  tip-calculator
//
//  Created by Elzo Lourenço Júnior on 08/03/24.
//

import Foundation
import AVFoundation

protocol AudioPlayerService {
    func playSound()
}

final class DefaultAudioPlayer: AudioPlayerService {
    
    private var player: AVAudioPlayer?
    
    func playSound() {
        let path = Bundle.main.path(forResource: "click", ofType: "m4a")!
        let url = URL(fileURLWithPath: path)
        do {
            player =  try AVAudioPlayer(contentsOf: url)
            player?.play()
        }catch{
            print("error")
        }
    }
}
