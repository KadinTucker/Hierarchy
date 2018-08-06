module hierarchy.logic.Card;

import hierarchy.logic;

/**
 * An enumeration of all of the suits in the game
 * and how they are displayed as text
 */
enum CardSuit {
    SPADE="Spades",
    HEART="Hearts",
    DIAMOND="Diamonds",
    CLUB="Clubs"
}

/**
 * An enumeration of all of the types of cards in the game
 * as well as their values
 */
enum CardType {
    THREE=0,
    FOUR=1,
    FIVE=2,
    SIX=3,
    SEVEN=4,
    EIGHT=5,
    NINE=6,
    TEN=7,
    JACK=8,
    QUEEN=9,
    KING=10,
    ACE=11,
    TWO=12
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