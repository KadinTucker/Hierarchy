module hierarchy.logic.Game;

import hierarchy;

/**
 * The class which handles the main functionalities of the game,
 * such as turn order 
 * A JSON-serialized version of this object is transferred between players
 */
class Game {

    Pile pile; ///The pile of cards in the center
    Player[] players; ///The players in the game
    int activePlayerIndex = 0; ///The player currently taking their turn
    int lastPlayedIndex = 0; ///The player who last played and did not knock
    bool isCleared; ///Whether or not the pile is ready to be cleared
    string notification; ///A notification on the game's status to be displayed

    /**
     * Constructs a new game object
     * with the given number of players
     * TODO: Add constructor overload that takes in a json file
     */
    this(int numPlayers) {
        Deck tempDeck = new Deck();
        Card[][] allHands = tempDeck.distributeCards(numPlayers);
        for(int i = 0; i < allHands.length; i++) {
            this.players ~= new Player(i, "Test Player", this);
            this.players[i].hand = allHands[i];
        }
        this.pile = new Pile();
    }

    /**
     * Plays a card or cards to the pile if possible
     * Returns whether or not the cards could be played
     * Can be played if FOUR conditions are met:
     * - A nonzero number of cards are played
     * - Each card played is of the same type
     * - The card type is at a value equal to or greater than that on top of the pile
     * - The number of cards played is equal to the current mode of the pile unless it completes
     * A skip occurs when the mode is singles (1) and the card played is the same as the card beneath it
     * A double skip occurs with the same conditions as a skip but if there are two cards of the same type beneath
     * A clear occurs when either 2's are played or there are four cards of the same type on the pile 
     */
    bool playCards(Card[] played) {
        if(played.length == 0 || played.length >= 4) { //Must have at least one card played but no more than three to lead with
            return false;
        }
        CardType type = played[0].type;
        foreach(card; played) { //Must have all cards played be the same type
            if(card.type != type) {
                return false;
            }
        }
        if(this.pile.cards.length > 0 && type.value < this.pile.cards[0].type.value) { //Must have cards be equal or greater value
            return false;
        }
        Card[] topCards = this.pile.getTopCards();
        bool sameType;
        if(topCards.length > 0) {
            sameType = topCards[0].type == played[0].type; //Checks if the card(s) to be played are the same type as those beneath; for use in various places
        }
        if(sameType && topCards.length + played.length == 4) { //If a 4 is completed, clear TODO: Make bombs able to happen
            this.pile.addToPile(played);
            this.isCleared = true;
            return true;
        }
        if(this.pile.mode != 0 && played.length != this.pile.mode) { //If a 4 is not completed and the mode of play is not followed, cannot play
            return false;
        }
        this.pile.addToPile(played);
        if(played[0].type == CardType.TWO) { //If two(s) are played, clear
            this.isCleared = true;
        }
        if(this.pile.mode == 1 && sameType) { //Check for skips
            if(played.length == 1) { 
                this.activePlayerIndex += 2;
            } else {
                this.activePlayerIndex += 3;
            }
        } else {
            this.activePlayerIndex += 1;
        }
        this.activePlayerIndex %= this.players.length;
        return true;
    }

}