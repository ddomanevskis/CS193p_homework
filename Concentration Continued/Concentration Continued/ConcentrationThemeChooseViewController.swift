//
//  ConcentrationThemeChooseViewController.swift
//  Concentration Continued
//
//  Created by dans.domanevskis on 23/04/2020.
//  Copyright Β© 2020 dans.domanevskis. All rights reserved.
//

import UIKit

class ConcentrationThemeChooseViewController: VCLLoggingViewController, UISplitViewControllerDelegate
{
    
    override var vclLoggingName: String {
        return "ThemeChooser"
    }
    
    let themes = [
        "Halloween":"π»π¬πππ¦π­πππ±πͺ",
        "Winter":"βοΈπ¨βοΈπΏπβ·π₯Άπ©βοΈβοΈ",
        "Sports":"π₯πΎπβ½οΈπππ»ββοΈππ€Ίππ΄π»ββοΈ",
        "Wild Animals":"π¦πππ¦ππππππ¦",
        "Farm Animals":"π¦ππππ¦’ππ¦ππ₯π",
        "Transport":"π©πππ²π’πππππ΄"
    ]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        splitViewController?.delegate = self
    }
    
    func splitViewController(
        _ splitViewController: UISplitViewController,
        collapseSecondary secondaryViewController: UIViewController,
        onto primaryViewController: UIViewController) -> Bool {
        if let cvc = secondaryViewController as? ConcentrationViewController {
            if cvc.theme == nil {
                return true
            }
        }
        return false
    }
    
    @IBAction func changeTheme(_ sender: Any) {
        if let cvc = splitViewDetailConcentrationViewController {
            if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName] {
                cvc.theme = theme
            }
        } else if let cvc = lastSeguedToConcentrtionViewController {
            if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName] {
                cvc.theme = theme
            }
            navigationController?.pushViewController(cvc, animated: true)
        } else {
            performSegue(withIdentifier: "Choose Theme", sender: sender)
        }
    }

    private var splitViewDetailConcentrationViewController: ConcentrationViewController? {
        return splitViewController?.viewControllers.last as? ConcentrationViewController
    }
    
    private var lastSeguedToConcentrtionViewController: ConcentrationViewController?

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Choose Theme" {
            if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName] {
                if let cvc = segue.destination as? ConcentrationViewController {
                    cvc.theme = theme
                    lastSeguedToConcentrtionViewController = cvc
                }
            }
        }
    }
}
