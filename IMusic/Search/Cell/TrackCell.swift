//
//  TrackCell.swift
//  IMusic
//
//  Created by Mykyta Babanin on 03/04/2022.
//

import UIKit
import SDWebImage
import Parse
import MessageUI

protocol TrackCellViewModel {
    var iconUrlString: String? { get }
    var trackName: String { get }
    var artistName: String { get }
    var collectionName: String { get }
    
}

class TrackCell: UITableViewCell, UNUserNotificationCenterDelegate, MFMailComposeViewControllerDelegate {
    private let notificationCenter: UNUserNotificationCenter = .current()
    
    static let reuseId = "TrackCell"
    @IBOutlet weak var trackNameLabel: UILabel!
    @IBOutlet weak var trackImageView: UIImageView!
    
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var collectionNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBOutlet weak var addTrackOutlet: UIButton!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        trackImageView.image = nil
    }
    
    var cell: SearchViewModel.Cell?
    
    func set(viewModel: SearchViewModel.Cell) {
        notificationCenter.delegate = self
        self.cell = viewModel
        
        let savedTracks = UserDefaults.standard.savedTracks()
        let hasFavourite = savedTracks.firstIndex(where: {
            $0.trackName == self.cell?.trackName && $0.artistName == self.cell?.artistName
        }) != nil
        if hasFavourite {
            addTrackOutlet.isHidden = true
        } else {
            addTrackOutlet.isHidden = false
        }

        
        trackNameLabel.text = viewModel.trackName
        artistNameLabel.text = viewModel.artistName
        collectionNameLabel.text = viewModel.collectionName
        
        guard let url = URL(string: viewModel.iconUrlString ?? "") else { return }
        trackImageView.sd_setImage(with: url, completed: nil)
        trackImageView.layer.cornerRadius = 30
        addCalendarNotification()
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        if #available(iOS 14.0, *) {
            completionHandler([.banner, .sound])
        } else {
            // Fallback on earlier versions
        }
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse) async {
        switch response.actionIdentifier {
        case UNNotificationDefaultActionIdentifier:
            print("UNNotificationDefaultActionIdentifier")
        case UNNotificationDismissActionIdentifier:
            print("UNNotificationDismissActionIdentifier")
        default:
            break
        }
    }
    
    @IBAction func addTrackAction(_ sender: Any) {
        let defaults = UserDefaults.standard
        guard let cell = cell else { return }
        addTrackOutlet.isHidden = true
        
        var listOfTracks = defaults.savedTracks()
        
        listOfTracks.append(cell)
        
        if let savedData = try? NSKeyedArchiver.archivedData(withRootObject: listOfTracks, requiringSecureCoding: false) {
            print("Успешно!")
            defaults.set(savedData, forKey: UserDefaults.favouriteTrackKey)
        }
        
        addNotification()
    }
    
    private func addNotification() {
        guard let trackName = trackNameLabel.text else { return }
        let content = UNMutableNotificationContent()
        content.title = "Specific music notification"
        content.subtitle = "\(trackName) was added to your playlist"
        content.badge = 100
        content.sound = .default
        let timeIntervalTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        let request = UNNotificationRequest(identifier: "Trigger", content: content, trigger: timeIntervalTrigger)
        notificationCenter.add(request)
    }
    
    private func addCalendarNotification() {
        let content = UNMutableNotificationContent()
        var dateComponent = DateComponents()
        dateComponent.second = 50
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponent, repeats: true)
        content.title = "Calendar notification"
        content.subtitle = "Update your library to view new music songs"
        content.sound = .default
        let request = UNNotificationRequest(identifier: "Calendar", content: content, trigger: trigger)
        notificationCenter.add(request)
    }
}
