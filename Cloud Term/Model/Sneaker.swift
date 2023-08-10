//
//  Sneaker.swift
//  Cloud Term
//
//  Created by Mayank Patel on 2023-07-12.
//

import Foundation

struct Sneaker: Decodable, Identifiable, Hashable {
    let id: String
    let name: String
    let description: String
    let releaseDate: String
    let images: [String]
    var date: Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yy"
        return dateFormatter.date(from: releaseDate) ?? Date.now
    }
    var allowEntry: Bool {
        let currentDate = Date.now
        let calender = Calendar.current
        let startReleaseEntry = calender.date(bySettingHour: 7, minute: 0, second: 0, of: date)!
        let endReleaseEntry = calender.date(bySettingHour: 19, minute: 58, second: 0, of: date)!
        if(currentDate >= startReleaseEntry && currentDate <= endReleaseEntry) {
            return true
        } else {
            return false
        }
    }
}

var sneakers: [Sneaker] = [
    Sneaker(id: "aj1-unc", name: "AJ1 UNC", description: "The Air Jordan 1 continues its relentless momentum in 2023, preparing for a spectacular array of releases throughout the year, with the Air Jordan 1 High OG UNC Toe undoubtedly topping the list of most-awaited launches.The iconic Bred Toe color blocking returns, this time featuring an eye-catching combination of Black, White, and University Blue. Black Toe overlays elegantly outline a pristine white mid-panel, while vivid blues accentuate the toe, heel, and collar sections. A classic white and blue rubber outsole completes the striking aesthetic.", releaseDate: "07-29-2023", images: ["https://term-project-5409.s3.amazonaws.com/AJ1+LOW+ATMOSPHERE+GREY/AJ1-Low-OG-Atmosphere-Grey-1.jpeg", "https://term-project-5409.s3.amazonaws.com/AJ1+LOW+ATMOSPHERE+GREY/AJ1-Low-OG-Atmosphere-Grey-2.jpeg", "https://term-project-5409.s3.amazonaws.com/AJ1+LOW+ATMOSPHERE+GREY/AJ1-Low-OG-Atmosphere-Grey-3.jpeg", "https://term-project-5409.s3.amazonaws.com/AJ1+LOW+ATMOSPHERE+GREY/AJ1-Low-OG-Atmosphere-Grey-4.jpeg", "https://term-project-5409.s3.amazonaws.com/AJ1+LOW+ATMOSPHERE+GREY/AJ1-Low-OG-Atmosphere-Grey-5.jpeg", "https://term-project-5409.s3.amazonaws.com/AJ1+LOW+ATMOSPHERE+GREY/AJ1-Low-OG-Atmosphere-Grey-6.jpeg"]),
    Sneaker(id: "aj1-atmosphere-grey", name: "AJ1 Low OG Atmosphere Grey", description: "Jordan Brand will continue traditions in 2023, with a select series of Air Jordan 1 Low OG releases sprinkled through the Spring/Summer seasons. The next to join the ranks is the Air Jordan 1 Low OG “Atmosphere Grey. First revealed back in November by Sole Retriever, information was scarce. But now, a very first look at the release has landed, and it looks all-too familiar.Borrowing an identical color make-up and color blocking to last year’s Air Jordan 1 High OG Stealth this new Air Jordan 1 Low OG Atmosphere Grey deviates in only few instances from its high-top counterpart. Keeping the same tumbled white leather upper, the pair presents identically-blocked grey toes, Swoosh overlays, and heels, though here it opts for a fine suede. Slight sail tints are applied to the midsole, too, while stock laces arrive in white; Otherwise, the pair is pretty close to what we saw in last August’s High OG.", releaseDate: "07-17-2023", images: ["https://term-project-5409.s3.amazonaws.com/AJ1+LOW+ATMOSPHERE+GREY/AJ1-Low-OG-Atmosphere-Grey-1.jpeg", "https://term-project-5409.s3.amazonaws.com/AJ1+LOW+ATMOSPHERE+GREY/AJ1-Low-OG-Atmosphere-Grey-2.jpeg", "https://term-project-5409.s3.amazonaws.com/AJ1+LOW+ATMOSPHERE+GREY/AJ1-Low-OG-Atmosphere-Grey-3.jpeg", "https://term-project-5409.s3.amazonaws.com/AJ1+LOW+ATMOSPHERE+GREY/AJ1-Low-OG-Atmosphere-Grey-4.jpeg", "https://term-project-5409.s3.amazonaws.com/AJ1+LOW+ATMOSPHERE+GREY/AJ1-Low-OG-Atmosphere-Grey-5.jpeg", "https://term-project-5409.s3.amazonaws.com/AJ1+LOW+ATMOSPHERE+GREY/AJ1-Low-OG-Atmosphere-Grey-6.jpeg"]),
    Sneaker(id: "aj1-unc-1", name: "AJ1 UNC BLUE", description: "The Air Jordan 1 continues its relentless momentum in 2023, preparing for a spectacular array of releases throughout the year, with the Air Jordan 1 High OG UNC Toe undoubtedly topping the list of most-awaited launches.The iconic Bred Toe color blocking returns, this time featuring an eye-catching combination of Black, White, and University Blue. Black Toe overlays elegantly outline a pristine white mid-panel, while vivid blues accentuate the toe, heel, and collar sections. A classic white and blue rubber outsole completes the striking aesthetic.", releaseDate: "07-17-2023", images: ["https://term-project-5409.s3.amazonaws.com/AJ1+LOW+ATMOSPHERE+GREY/AJ1-Low-OG-Atmosphere-Grey-1.jpeg", "https://term-project-5409.s3.amazonaws.com/AJ1+LOW+ATMOSPHERE+GREY/AJ1-Low-OG-Atmosphere-Grey-2.jpeg", "https://term-project-5409.s3.amazonaws.com/AJ1+LOW+ATMOSPHERE+GREY/AJ1-Low-OG-Atmosphere-Grey-3.jpeg", "https://term-project-5409.s3.amazonaws.com/AJ1+LOW+ATMOSPHERE+GREY/AJ1-Low-OG-Atmosphere-Grey-4.jpeg", "https://term-project-5409.s3.amazonaws.com/AJ1+LOW+ATMOSPHERE+GREY/AJ1-Low-OG-Atmosphere-Grey-5.jpeg", "https://term-project-5409.s3.amazonaws.com/AJ1+LOW+ATMOSPHERE+GREY/AJ1-Low-OG-Atmosphere-Grey-6.jpeg"]),
]
