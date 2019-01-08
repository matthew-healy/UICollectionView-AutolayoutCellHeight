import UIKit

class ViewController: UIViewController {
    // outlets
    @IBOutlet var collectionView: UICollectionView!
    
    // variables
    var collectionViewLayout: UICollectionViewFlowLayout {
        return collectionView.collectionViewLayout as! UICollectionViewFlowLayout
    }
    private let dataSource = TestDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionViewLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        // register cells with text label
        collectionView.register(
            TextLabelCollectionViewCell.self,
            forCellWithReuseIdentifier: TextLabelCollectionViewCell.reuseIdentifier
        )
        // make one massive one and some smaller ones
        collectionView.dataSource = dataSource
    }
}

final class TextLabelCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = String(describing: TextLabelCollectionViewCell.self)
    
    private let label = UILabel()
    private var widthConstraint: NSLayoutConstraint?
    
    var text: String? {
        get { return label.text }
        set {
            label.text = newValue
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func configureCellSubviews() {
        guard !contentView.subviews.contains(label) else { return }
        backgroundColor = .purple
        
        label.numberOfLines = 0
        label.textColor = .green
        contentView.addSubview(label)
        constrainLabelToContentView()
        
        widthConstraint = contentView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width)
        widthConstraint?.priority = .defaultHigh
        widthConstraint?.isActive = true
    }
    
    private func constrainLabelToContentView() {
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
            label.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            label.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16)
        ])
    }
}

final class TestDataSource: NSObject, UICollectionViewDataSource {
    private let data = [
        "I'm a shorter cell.",
        "I expect I'll be a bit longer. Perhaps long enough to stretch over two lines or perhaps a little bit shorter than that on wider devices like the iPad. Either way I am longer than the one above.",
        """
        Lorem ipsum dolor amet godard flannel shabby chic YOLO snackwave meh. Offal mixtape semiotics, ramps post-ironic hashtag humblebrag palo santo marfa cloud bread echo park readymade. Ramps pork belly quinoa disrupt flannel pitchfork celiac flexitarian selfies aesthetic retro lyft man bun enamel pin. Raclette umami cold-pressed church-key. Locavore air plant asymmetrical blue bottle cronut copper mug. Lomo intelligentsia green juice chambray fashion axe. Gentrify forage cronut poke.
        
        Hammock pour-over dreamcatcher, prism four dollar toast semiotics forage art party live-edge readymade yr palo santo cornhole. Thundercats poke locavore green juice, cred irony meditation chartreuse distillery. Schlitz master cleanse skateboard fashion axe woke intelligentsia synth, gentrify ugh pitchfork cronut sartorial small batch shaman microdosing. Keytar heirloom try-hard tote bag brooklyn cred gentrify scenester wolf vaporware freegan.
        
        Ethical hella you probably haven't heard of them, 90's brunch viral williamsburg subway tile craft beer direct trade lo-fi. Lo-fi swag scenester gentrify hashtag, ethical 3 wolf moon disrupt salvia letterpress photo booth bespoke post-ironic. Celiac ethical tbh kogi hell of brooklyn mumblecore readymade yuccie try-hard 8-bit glossier gastropub ennui umami. Crucifix letterpress mumblecore wolf gluten-free green juice pour-over humblebrag selvage vice. Street art church-key drinking vinegar, XOXO aesthetic gentrify asymmetrical humblebrag trust fund hoodie direct trade try-hard master cleanse. Wayfarers tattooed dreamcatcher roof party copper mug blue bottle, lumbersexual hammock vice gastropub.
        
        IPhone sustainable pabst, sartorial ennui fanny pack intelligentsia neutra 8-bit chicharrones af. Gluten-free bitters ethical ramps, shabby chic scenester helvetica portland polaroid heirloom cronut. Quinoa wolf hammock gluten-free, vape tousled thundercats activated charcoal 8-bit four dollar toast meggings before they sold out pop-up woke. Gastropub iPhone pabst, ugh sustainable cray normcore art party man braid tacos cardigan kombucha subway tile vape venmo. Vape fanny pack iceland photo booth put a bird on it authentic. 90's meggings sustainable poke blog. Farm-to-table vexillologist mlkshk sustainable tousled neutra, man bun banjo readymade.
        
        Craft beer waistcoat marfa quinoa meditation organic. Banjo typewriter 3 wolf moon marfa 90's direct trade pickled green juice put a bird on it irony chillwave. Master cleanse selvage distillery unicorn whatever next level fingerstache squid viral small batch vegan. Adaptogen selfies artisan, edison bulb pok pok pork belly hammock austin.
        """,
        "More cells afterwards.",
        "CELL PARTY. ALL THE CELLS. LET'S GO CELL CRAZY."
    ]
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: TextLabelCollectionViewCell.reuseIdentifier,
            for: indexPath
        ) as! TextLabelCollectionViewCell
        cell.configureCellSubviews()
        cell.text = data[indexPath.item]
        return cell
    }
}
