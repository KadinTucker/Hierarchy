module hierarchy.logic.Deck;

import hierarchy.logic;

import std.algorithm;
import std.random;
import std.traits;

/**
 * An object representing a deck of cards
 */
class Deck {

    private Card[] cards; ///All of the cards currently in the deck

    /**
     * Constructs a new deck
     * Refreshes the cards; see refresh
     */
    this() {
        this.refresh();
    }

    /**
     * Refreshes the deck of cards, returning it to having the
     * correct number by suit and type
     */
    void refresh() {
        this.cards = [];
        foreach(suit; EnumMembers!CardSuit) {
            foreach(type; EnumMembers!CardType) {
                this.cards ~= Card(suit, type);
            }
        }
    }

    /**
     * Takes a random card from the deck
     * Returns the card taken and removes that card from the deck
     */
    Card drawRandom() {
        int chosenIndex = uniform(0, this.cards.length);
        Card chosen = this.cards[chosenIndex];
        this.cards.remove(chosenIndex);
        return chosen;
    }

}