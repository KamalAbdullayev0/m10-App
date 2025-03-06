import UIKit

protocol DropdownSelectorDelegate: AnyObject {
    func dropdown(_ dropdown: DropdownSelectorView<Any>, didSelectOption option: Any)
}

class DropdownSelectorView<T>: UIView {
    
    // MARK: - UI Components
    private let titleLabel = UILabel()
    private let arrowImageView = UIImageView()
    private let searchTextField = UITextField()
    private let optionsTableView = UITableView()
    
    private var tableViewHeightConstraint: NSLayoutConstraint!
    
    // MARK: - Configuration
    weak var delegate: DropdownSelectorDelegate?
    
    // Замыкание для обработки выбора опции
    var onOptionSelected: ((T) -> Void)?
    
    var placeholderText: String = "Выберите вариант" {
        didSet { updateTitleLabel() }
    }
    var placeholderColor: UIColor = .gray
    var normalTextColor: UIColor = .black
    var dropdownFont: UIFont = .systemFont(ofSize: 16)
    var maximumDropdownHeight: CGFloat = 150
    
    // MARK: - Data
    private var allOptions: [T] = []
    private var filteredOptions: [T] = []
    private var isExpanded = false {
        didSet { animateDropdown() }
    }
    private var selectedOption: T? {
        didSet { updateTitleLabel() }
    }
    
    // MARK: - Init
    init(options: [T]) {
        super.init(frame: .zero)
        self.allOptions = options
        self.filteredOptions = options
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    // MARK: - Setup UI
    private func setupUI() {
        backgroundColor = .white
        layer.cornerRadius = 12
        layer.borderWidth = 1
        layer.borderColor = UIColor.lightGray.cgColor
        
        // Настройка компонентов (заголовок, стрелка, поле поиска и т.д.)
        // ...
        
        // Регистрация таблицы и назначение делегатов
//        optionsTableView.delegate = self
//        optionsTableView.dataSource = self
        optionsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    // MARK: - Actions
    @objc private func toggleDropdown() {
        isExpanded.toggle()
    }
    
    @objc private func filterOptions() {
        guard let text = searchTextField.text, !text.isEmpty else {
            filteredOptions = allOptions
            optionsTableView.reloadData()
            return
        }
        filteredOptions = allOptions.filter { option in
            if let optionString = "\(option)".lowercased() as? String {
                return optionString.contains(text.lowercased())
            }
            return false
        }
        optionsTableView.reloadData()
    }
    
    // MARK: - Private Methods
    private func animateDropdown() {
        let targetHeight: CGFloat
        if isExpanded {
            let contentHeight = CGFloat(filteredOptions.count) * 48
            targetHeight = min(contentHeight, maximumDropdownHeight)
        } else {
            targetHeight = 0
        }
        
        tableViewHeightConstraint.constant = targetHeight
        UIView.animate(withDuration: 0.3) {
            self.arrowImageView.transform = self.isExpanded ?
                CGAffineTransform(rotationAngle: .pi) :
                CGAffineTransform.identity
            self.layoutIfNeeded()
        }
    }
    
    private func updateTitleLabel() {
        if let option = selectedOption {
            titleLabel.text = "\(option)"
            titleLabel.textColor = normalTextColor
        } else {
            titleLabel.text = placeholderText
            titleLabel.textColor = placeholderColor
        }
    }
    
    // MARK: - UITableViewDataSource & UITableViewDelegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "\(filteredOptions[indexPath.row])"
        cell.textLabel?.font = dropdownFont
        cell.backgroundColor = .white
        cell.selectionStyle = .default
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedOption = filteredOptions[indexPath.row]
        self.selectedOption = selectedOption
        
        // Уведомляем через замыкание
        onOptionSelected?(selectedOption)
        
        // Уведомляем через делегат
        delegate?.dropdown(self as! DropdownSelectorView<Any>, didSelectOption: selectedOption)
        
        isExpanded = false
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 48
    }
}
