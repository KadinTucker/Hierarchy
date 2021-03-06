module hierarchy.logic.Deck;

import hierarchy.logic;

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
        this.cards.randomShuffle();
    }

    /**
     * Takes a random card from the deck
     * Returns the card taken and removes that card from the deck
     */
    Card drawRandom() {
        int chosenIndex = uniform(0, cast(int)this.cards.length);
        Card chosen = this.cards[chosenIndex];
        import std.algorithm;
        this.cards = this.cards.remove(chosenIndex);
        return chosen;
    }

    /**
     * Distributes cards mostly evenly among the given number of players
     * Refreshes the deck each time this is done
     */
    Card[][] distributeCards(int numPlayers) {
        if(numPlayers <= 0) {
            return null;
        }
        Card[][] allHands;
        for(int i = 0; i < numPlayers; i++) {
            allHands ~= null;
        }
        while(this.cards.length > 0) {
            for(int i; i < allHands.length; i++) {
                if(this.cards.length > 0) {
                    allHands[i] ~= this.drawRandom();
                }
            }
        }
        this.refresh();
        return allHands;
    }

}