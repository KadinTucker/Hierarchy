module hierarchy.logic.Pile;

import hierarchy;

import std.array;

/**
 * An enumeration of the various results of playing a card
 * Cannot play means that the action was illegal
 * Normal means that it proceeds to the next player as normal
 * Skip means that the next player cannot take their turn
 * Double skip means that the next two players cannot take their turns
 * Clear means that the pile is cleared and the player who played now leads
 */
enum PlayResult {
    CANNOT_PLAY=0,
    NORMAL=1,
    SKIP=2,
    DOUBLE_SKIP=3,
    CLEAR=4
}

/**
 * The class representing the pile of cards to be played on
 */
class Pile {

    Card[] cards; ///The cards in the pile; start of the list is the top of the pile
    int mode; ///How many cards need to be put down; defined by the lead; 0 means any number can be played

    /**
     * Plays a card or cards to the pile if possible
     * Returns the result of the card(s) played (see PlayResult)
     * Can be played if FOUR conditions are met:
     * - A nonzero number of cards are played
     * - Each card played is of the same type
     * - The card type is at a value equal to or greater than that on top of the pile
     * - The number of cards played is equal to the current mode of the pile unless it completes
     * A skip occurs when the mode is singles (1) and the card played is the same as the card beneath it
     * A double skip occurs with the same conditions as a skip but if there are two cards of the same type beneath
     * A clear occurs when either 2's is played or there are four cards of the same type on the pile 
     */
    PlayResult playCards(Card[] toAdd) {
        if(toAdd.length == 0) { //Must have at least one card played
            return PlayResult.CANNOT_PLAY;
        }
        CardType type = toAdd[0].type;
        foreach(card; toAdd) { //Must have all cards played be the same type
            if(card.type != type) {
                return PlayResult.CANNOT_PLAY;
            }
        }
        if(type.value < this.cards[0].type.value) { //Must have cards be equal or greater value
            return PlayResult.CANNOT_PLAY;
        }
        Card[] topCards = this.getTopCards();
        bool sameType;
        if(topCards.length > 0) {
            sameType = topCards[0].type == toAdd[0].type; //Checks if the card(s) to be played are the same type as those beneath; for use in various places
        }
        if(sameType && topCards.length + toAdd.length == 4) { //If a 4 is completed, clear
            this.addToPile(toAdd);
            return PlayResult.CLEAR;
        }
        if(this.mode != 0 && toAdd.length != this.mode) { //If a 4 is not completed and the mode of play is not followed, cannot play
            return PlayResult.CANNOT_PLAY; 
        }
        this.addToPile(toAdd);
        if(toAdd[0].type == CardType.TWO) { //If two(s) are played, clear
            return PlayResult.CLEAR;
        }
        if(this.mode == 1 && sameType) { //Check for skips
            if(toAdd.length == 1) { 
                return PlayResult.SKIP;
            } else {
                return PlayResult.DOUBLE_SKIP;
            }
        }
        return PlayResult.NORMAL;
    }

    /**
     * Inserts the cards into the pile
     */
    void addToPile(Card[] toAdd) {
        this.cards.insertInPlace(0, toAdd);
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

}