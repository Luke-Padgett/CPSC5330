import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 26/255, green: 26/255, blue: 28/255, alpha: 1)
        buildLayout()
    }

    private func buildLayout() {
        let mainStack = UIStackView()
        mainStack.axis = .vertical
        mainStack.spacing = 16
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mainStack)
		
        let guide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            mainStack.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 16),
            mainStack.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -16),
            mainStack.topAnchor.constraint(equalTo: guide.topAnchor, constant: 16),
            mainStack.bottomAnchor.constraint(lessThanOrEqualTo: guide.bottomAnchor, constant: -16)
        ])

        let displayStack = UIStackView()
        displayStack.axis = .vertical
        displayStack.spacing = 8

        let equationLabel = UILabel()
        equationLabel.text = "13+20="
        equationLabel.textColor = .white
        equationLabel.textAlignment = .right
        equationLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)

        let resultLabel = UILabel()
        resultLabel.text = "260"
        resultLabel.textColor = .white
        resultLabel.textAlignment = .right
        resultLabel.font = UIFont.systemFont(ofSize: 48, weight: .semibold)

        let line = UIView()
        line.backgroundColor = UIColor(red: 204/255, green: 161/255, blue: 69/255, alpha: 1)
        line.heightAnchor.constraint(equalToConstant: 3).isActive = true

        displayStack.addArrangedSubview(equationLabel)
        displayStack.addArrangedSubview(resultLabel)
        displayStack.addArrangedSubview(line)

        mainStack.addArrangedSubview(displayStack)

        let buttonTitles = [
            ["AC", "+/-", "%", "/"],
            ["7", "8", "9", "×"],
            ["4", "5", "6", "−"],
            ["1", "2", "3", "+"],
            ["0", ".", "=", ""]
        ]		
	
        for row in buttonTitles {
            let rowStack = UIStackView()
            rowStack.axis = .horizontal
            rowStack.distribution = .fillEqually
            rowStack.spacing = 12

            for title in row {
                if title == "" {
                    let spacer = UIView()
                    rowStack.addArrangedSubview(spacer)
                } else {
                    let button = makeButton(title: title)
                    rowStack.addArrangedSubview(button)
                }
            }
            mainStack.addArrangedSubview(rowStack)
        }
    }

    private func makeButton(title: String) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        button.backgroundColor = UIColor(red: 44/255, green: 44/255, blue: 46/255, alpha: 1)
        button.layer.cornerRadius = 10
        button.heightAnchor.constraint(equalToConstant: 56).isActive = true
        return button
    }
}
