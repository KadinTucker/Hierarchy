module hierarchy.graphics.Image;

import hierarchy;

import std.traits;

/**
 * An enumeration of every image path to be used in the game
 * Accessed and stored in a list in the image class upon
 * game initialization
 */
enum ImagePath {
    CARD_BASE="res/cards/cardbase.png",
    BLACK_ACE="res/cards/blackace.png",
    BLACK_TWO="res/cards/blacktwo.png",
    BLACK_THREE="res/cards/blackthree.png",
    BLACK_FOUR="res/cards/blackfour.png",
    BLACK_FIVE="res/cards/blackfive.png",
    BLACK_SIX="res/cards/blacksix.png",
    BLACK_SEVEN="res/cards/blackseven.png",
    BLACK_EIGHT="res/cards/blackeight.png",
    BLACK_NINE="res/cards/blacknine.png",
    BLACK_TEN="res/cards/blackten.png",
    BLACK_JACK="res/cards/blackjack.png",
    BLACK_QUEEN="res/cards/blackqueen.png",
    BLACK_KING="res/cards/blackking.png",
    RED_ACE="res/cards/blackace.png",
    RED_TWO="res/cards/blacktwo.png",
    RED_THREE="res/cards/blackthree.png",
    RED_FOUR="res/cards/blackfour.png",
    RED_FIVE="res/cards/blackfive.png",
    RED_SIX="res/cards/blacksix.png",
    RED_SEVEN="res/cards/blackseven.png",
    RED_EIGHT="res/cards/blackeight.png",
    RED_NINE="res/cards/blacknine.png",
    RED_TEN="res/cards/blackten.png",
    RED_JACK="res/cards/blackjack.png",
    RED_QUEEN="res/cards/blackqueen.png",
    RED_KING="res/cards/blackking.png",
    SMALL_SPADE="res/cards/spade.png",
    SMALL_HEART="res/cards/heart.png",
    SMALL_DIAMOND="res/cards/diamond.png",
    SMALL_CLUB="res/cards/club.png"
}

/**
 * A class which stores images as well as generates images for the game
 */
class Image {

    static Surface[ImagePath] allImages; ///An associative array of all of the images in the game which can be accessed by enum
    static Surface[2][CardType] cardTypeImages; ///An associative array of each of the images used for card types, [red, black]

    /**
     * Loads every image from the enumerated image paths above
     */
    static void initialize() {
        foreach (image; EnumMembers!ImagePath) {
            allImages[image] = loadImage(cast(string)image);
        }
    }

    /**
     * Given a card, returns the image used to display it
     * TODO:
     */
    static Surface getCardImage(Card card) {
        return null;
    }

}