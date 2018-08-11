module hierarchy.logic.Pile;

import hierarchy;

import std.array;

/**
 * The class representing the pile of cards to be played on
 */
class Pile {

    Card[] cards; ///The cards in the pile; start of the list is the top of the pile
    int mode; ///How many cards need to be put down; defined by the lead; 0 means any number can be played

    /**
     * Constructs a new pile
     * By default begins with no cards and mode 0
     */
    this(Card[] cards = null, int mode = 0) {
        this.cards = cards;
        this.mode = mode;
    }

    /**
     * Inserts the cards into the pile
     */
    void addToPile(Card[] toAdd) {
        this.cards.insertInPlace(0, toAdd);
        this.mode = toAdd.length;
    }

    /**
     * Gets the card(s) at the top of the pile that are of the same type
     */
    Card[] getTopCards() {
        if(this.cards.length == 0) {
            return null;
        }
        Card[] topCards;
        topCards ~= this.cards[0];
        for(int i = 1; i < this.cards.length; i++) {
            if(this.cards[i].type == topCards[0].type) {
                topCards ~= this.cards[i];
            } else {
                break;
            }
        }
        return topCards;
    }

    /**
     * Resets the pile to be empty
     */ 
    void reset() {
        this.cards = null;
        this.mode = 0;
    }

}