module hierarchy.graphics.Image;

import hierarchy;

import std.conv;
import std.traits;

/**
 * An enumeration of every image path to be used in the game
 * Accessed and stored in a list in the image class upon
 * game initialization
 */
enum ImagePath {
    CARD_BASE="res/cards/cardbase.png",
    CARD_HIGHLIGHT="res/cards/highlight.png",
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
    RED_ACE="res/cards/redace.png",
    RED_TWO="res/cards/redtwo.png",
    RED_THREE="res/cards/redthree.png",
    RED_FOUR="res/cards/redfour.png",
    RED_FIVE="res/cards/redfive.png",
    RED_SIX="res/cards/redsix.png",
    RED_SEVEN="res/cards/redseven.png",
    RED_EIGHT="res/cards/redeight.png",
    RED_NINE="res/cards/rednine.png",
    RED_TEN="res/cards/redten.png",
    RED_JACK="res/cards/redjack.png",
    RED_QUEEN="res/cards/redqueen.png",
    RED_KING="res/cards/redking.png",
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
     * TODO: upside down part of image
     */
    static Surface getCardImage(Card card) {
        Surface cardBase = loadImage(ImagePath.CARD_BASE); //TODO: make this copy instead of re-loading
        Surface typeImage;
        if(card.suit == CardSuit.SPADE || card.suit == CardSuit.CLUB) {
            typeImage = loadImage(cast(string)card.type.blackPath);
        } else {
            typeImage = loadImage(cast(string)card.type.redPath);
        }
        cardBase.blit(typeImage, null, 8, 8);
        cardBase.blit(Image.allImages[card.suit], null, 9, 32); //TODO: make these blitting locations defined as constants somewhere
        return cardBase;
    }

}