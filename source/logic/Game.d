module hierarchy.logic.Game;

import hierarchy;

/**
 * The class which stores all of the functionalities of the game
 * Main purpose is to serialize and de-serialize
 * TODO: implement serialization
 */
class Game {

    Pile pile; ///The pile of cards in the center
    Player[] players; ///The players in the game
    int activePlayerIndex = 0; ///The player currently taking their turn
    int lastPlayedIndex = 0; ///The player who last played and did not knock
    bool isCleared; ///Whether or not the pile is ready to be cleared

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

}