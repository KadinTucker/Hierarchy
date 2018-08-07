module hierarchy.logic.Card;

import hierarchy;

/**
 * An enumeration of all of the suits in the game
 * and the image paths used to draw them
 */
enum CardSuit {
    SPADE=ImagePath.SMALL_SPADE,
    HEART=ImagePath.SMALL_HEART,
    DIAMOND=ImagePath.SMALL_DIAMOND,
    CLUB=ImagePath.SMALL_CLUB
}

/**
 * A struct containing data for a card value
 * Contains two image paths for how the card is represented
 * in red and black, as well as the value of the card in the game
 */
struct CardTypeData {
    ImagePath blackPath;
    ImagePath redPath;
    int value;
}

/**
 * An enumeration of all of the types of cards in the game
 * as well as their data for display and value
 */
enum CardType : CardTypeData {
    THREE=CardTypeData(ImagePath.BLACK_THREE, ImagePath.RED_THREE, 0),
    FOUR=CardTypeData(ImagePath.BLACK_FOUR, ImagePath.RED_FOUR, 0),
    FIVE=CardTypeData(ImagePath.BLACK_FIVE, ImagePath.RED_FIVE, 0),
    SIX=CardTypeData(ImagePath.BLACK_SIX, ImagePath.RED_SIX, 0),
    SEVEN=CardTypeData(ImagePath.BLACK_SEVEN, ImagePath.RED_SEVEN, 0),
    EIGHT=CardTypeData(ImagePath.BLACK_EIGHT, ImagePath.RED_EIGHT, 0),
    NINE=CardTypeData(ImagePath.BLACK_NINE, ImagePath.RED_NINE, 0),
    TEN=CardTypeData(ImagePath.BLACK_TEN, ImagePath.RED_TEN, 0),
    JACK=CardTypeData(ImagePath.BLACK_JACK, ImagePath.RED_JACK, 0),
    QUEEN=CardTypeData(ImagePath.BLACK_QUEEN, ImagePath.RED_QUEEN, 0),
    KING=CardTypeData(ImagePath.BLACK_KING, ImagePath.RED_KING, 0),
    ACE=CardTypeData(ImagePath.BLACK_ACE, ImagePath.RED_ACE, 0),
    TWO=CardTypeData(ImagePath.BLACK_TWO, ImagePath.RED_TWO, 0)
}

/**
 * A card struct, with suit and type
 */
struct Card {

    CardSuit suit; ///The suit of the card
    CardType type; ///The type of the card

}

/**
 * Sorts the cards in hand in order of value
 * TODO:
 */
void sortHand(Card[] hand) {

}