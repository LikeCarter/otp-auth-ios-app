import Foundation
import SparrowKit
import AVFoundation

enum SoundsService {
    
    static var player: AVAudioPlayer?
    
    enum Sounds: String {
        case success
        case delete
        case warning
        case error
        
        var name: String {
            switch self {
            case .success:
                return "Success"
            case .delete:
                return "Delete"
            case .warning:
                return "Warning"
            case .error:
                return "Error"
            }
        }
    }
    
    static func play(sound: Sounds) {
        
        var isDay: Bool? = nil
        
        guard let url = Bundle.main.url(forResource: sound.name, withExtension: "wav") else { return }

            do {
                try AVAudioSession.sharedInstance().setCategory(.ambient, mode: .default)
                try AVAudioSession.sharedInstance().setActive(true)
                

                player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)

                guard let player = player else { return }
                
                player.volume = 0.5
                
                if isDay == nil {
                    let now = Date()
                    let fromDate = Calendar.current.date(bySettingHour: 7, minute: 0, second: 0, of: now) ?? Date()
                    let toDate = Calendar.current.date(bySettingHour: 21, minute: 0, second: 0, of: now) ?? Date()
                    isDay = (now > fromDate) && (now < toDate)
                }
                
                if Settings.isSoundsEnabled != "3" {
                    if Settings.isSoundsEnabled == "1" {
                        player.play()
                    }
                } else {
                    if isDay! {
                        player.play()
                    }
                }

            } catch let error {
                print(error.localizedDescription)
            }
        
    }
    
}
