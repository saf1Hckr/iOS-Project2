import Foundation
import UIKit

class BoardController: NSObject,
                       UICollectionViewDataSource,
                       UICollectionViewDelegate,
                       UICollectionViewDelegateFlowLayout {
  
  // MARK: - Properties
  var numItemsPerRow = 5
  var numRows = 6
  let collectionView: UICollectionView
  var goalWord: [String]

  var numTimesGuessed = 0
  var isAlienWordle = false
  var currRow: Int {
    return numTimesGuessed / numItemsPerRow
  }
  
  init(collectionView: UICollectionView) {
    self.collectionView = collectionView
    let rawTheme = SettingsManager.shared.settingsDictionary[kWordThemeKey] as! String
    let theme = WordTheme(rawValue: rawTheme)!
    self.goalWord = WordGenerator.generateGoalWord(with: theme)
    super.init()
    collectionView.delegate = self
    collectionView.dataSource = self
  }
  
  // MARK: - Public Methods
  func resetBoard(with settings: [String: Any]) {
    applyNumLettersSettings(with: settings)
    applyNumGuessesSettings(with: settings)
    applyThemeSettings(with: settings)
    applyIsAlienWordleSettings(with: settings)
    numTimesGuessed = 0
    collectionView.reloadData()
  }
  
  func resetBoardWithCurrentSettings() {
    collectionView.reloadData()
  }
  
  private func applyNumLettersSettings(with settings: [String: Any]) {
    if let numLetters = settings[kNumLettersKey] as? Int {
      numItemsPerRow = numLetters
    }
  }
  
  private func applyNumGuessesSettings(with settings: [String: Any]) {
    if let numGuesses = settings[kNumGuessesKey] as? Int {
      numRows = numGuesses
    }
  }
  
  private func applyThemeSettings(with settings: [String: Any]) {
    if let rawTheme = settings[kWordThemeKey] as? String, let theme = WordTheme(rawValue: rawTheme) {
      goalWord = WordGenerator.generateGoalWord(with: theme)
    }
  }
  
  private func applyIsAlienWordleSettings(with settings: [String: Any]) {
    if let isAlien = settings[kIsAlienWordleKey] as? Bool {
      isAlienWordle = isAlien
    }
  }
}
