//
//  String+Utils.swift
//  TextFieldProject
//
//  Created by Benny Davidovitz on 08/02/2022.
//

import Foundation
import libPhoneNumber_iOS

extension String {
    //https://stackoverflow.com/a/56617023/6133419
    var isValidEmail: Bool {
        NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}").evaluate(with: self)
    }
    
    //check if string contains 'real' character
    //inspired from: https://stackoverflow.com/questions/27768064/check-if-swift-text-field-contains-non-whitespace
    var isContainsNonWhiteSpaces: Bool {
        self.trimmingCharacters(in: .whitespacesAndNewlines).count > 0
    }
    
    //check if string represents a valid phone number (Default Region: IL)
    var isValidPhoneNumber: Bool {
        //exclude emergency numbers
        guard self.count > 4 else { return false }
        
        //https://github.com/iziz/libPhoneNumber-iOS
        guard let util = NBPhoneNumberUtil.sharedInstance() else { return false }
        guard let number = try? util.parse(self, defaultRegion: "IL") else {
            print("failed to parse " + self)
            return false
        }
        
        return util.isValidNumber(number)
    }
    
}


//check if string contains emoji
//https://stackoverflow.com/a/39425959/6133419

extension Character {
    /// A simple emoji is one scalar and presented to the user as an Emoji
    var isSimpleEmoji: Bool {
        guard let firstScalar = unicodeScalars.first else { return false }
        return firstScalar.properties.isEmoji && firstScalar.value > 0x238C
    }

    /// Checks if the scalars will be merged into an emoji
    var isCombinedIntoEmoji: Bool { unicodeScalars.count > 1 && unicodeScalars.first?.properties.isEmoji ?? false }

    var isEmoji: Bool { isSimpleEmoji || isCombinedIntoEmoji }
}

extension String {
    var isSingleEmoji: Bool { count == 1 && containsEmoji }

    var containsEmoji: Bool { contains { $0.isEmoji } }

    var containsOnlyEmoji: Bool { !isEmpty && !contains { !$0.isEmoji } }

    var emojiString: String { emojis.map { String($0) }.reduce("", +) }

    var emojis: [Character] { filter { $0.isEmoji } }

    var emojiScalars: [UnicodeScalar] { filter { $0.isEmoji }.flatMap { $0.unicodeScalars } }
}
