import UIKit
import PlaygroundSupport

class MoodViewController: UIViewController {
    
    let titleLabel = UILabel()
    let moodLabel = UILabel()
    let moodSlider = UISlider()
    let datePicker = UIDatePicker()
    let saveButton = UIButton(type: .system)
    let savedLabel = UILabel()
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }()
    
    var currentEmoji: String = "🙂"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        updateMoodLabel()
    }
    
    func setupView() {
        view.backgroundColor = UIColor(red: 0.60, green: 0.87, blue: 0.82, alpha: 1.0)
        
        let views: [UIView] = [titleLabel, moodLabel, moodSlider, datePicker, saveButton, savedLabel]
        for v in views {
            v.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(v)
        }
        
        titleLabel.text = "MoodTracker"
        titleLabel.textAlignment = .center
        titleLabel.font = .systemFont(ofSize: 34, weight: .bold)
        
        moodLabel.textAlignment = .center
        moodLabel.font = .systemFont(ofSize: 28, weight: .medium)
        
        moodSlider.minimumValue = 0
        moodSlider.maximumValue = 100
        moodSlider.value = 75
        moodSlider.addTarget(self, action: #selector(sliderChanged(_:)), for: .valueChanged)
        
        datePicker.datePickerMode = .date
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .compact
        }
        
        saveButton.setTitle("Save Mood", for: .normal)
        saveButton.setTitleColor(.white, for: .normal)
        saveButton.backgroundColor = UIColor(red: 0.08, green: 0.60, blue: 0.73, alpha: 1.0)
        saveButton.layer.cornerRadius = 10
        saveButton.titleLabel?.font = .systemFont(ofSize: 24, weight: .semibold)
        saveButton.addTarget(self, action: #selector(saveMoodTapped), for: .touchUpInside)
        
        savedLabel.textAlignment = .center
        savedLabel.numberOfLines = 0
        savedLabel.font = .systemFont(ofSize: 20, weight: .regular)
        savedLabel.text = ""
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            titleLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            
            moodLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 80),
            moodLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            moodLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            
            moodSlider.topAnchor.constraint(equalTo: moodLabel.bottomAnchor, constant: 32),
            moodSlider.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            moodSlider.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            
            datePicker.topAnchor.constraint(equalTo: moodSlider.bottomAnchor, constant: 40),
            datePicker.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            saveButton.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 40),
            saveButton.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            saveButton.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            saveButton.heightAnchor.constraint(equalToConstant: 56),
            
            savedLabel.topAnchor.constraint(equalTo: saveButton.bottomAnchor, constant: 32),
            savedLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            savedLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            savedLabel.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
    
    func moodDescription(for value: Int) -> (text: String, emoji: String) {
        switch value {
        case 0...20:   return ("Very Sad", "😢")
        case 21...40:  return ("Sad", "🙁")
        case 41...60:  return ("Neutral", "😐")
        case 61...80:  return ("Happy", "🙂")
        default:       return ("Very Happy", "😄")
        }
    }
    
    func updateMoodLabel() {
        let value = Int(moodSlider.value)
        let mood = moodDescription(for: value)
        currentEmoji = mood.emoji
        moodLabel.text = "Feeling: \(mood.text) \(mood.emoji)"
    }
    
    @objc func sliderChanged(_ sender: UISlider) {
        updateMoodLabel()
    }
    
    @objc func saveMoodTapped() {
        let dateString = dateFormatter.string(from: datePicker.date)
        savedLabel.text = "On \(dateString), you felt \(currentEmoji)"
    }
}

let moodVC = MoodViewController()
moodVC.preferredContentSize = CGSize(width: 390, height: 844)
PlaygroundPage.current.liveView = moodVC
PlaygroundPage.current.needsIndefiniteExecution = true
