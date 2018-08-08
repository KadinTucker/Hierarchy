module hierarchy.logic.Player;

import hierarchy;

/**
 * A class representing a player
 * Stores their hand as well as a numeric identifier
 */
class Player {

    int id; ///A number which identifies the player
    string uname; ///The player's username
    Game game; ///The game to which this player belongs
    Card[] hand; ///The cards in the player's hand
    bool knocked; ///Whether or not the player has passed this round
    
    /**
     * Constructs a new player with the given id and name in the given game
     */
    this(int id, string uname, Game game) {
        this.id = id;
        this.uname = uname;
        this.game = game;
    }

    /**
     * Removes the given cards from the player's hand
     */
    void discardCards(Card[] cards) {
        foreach(card; cards) {
            import std.algorithm;
            this.hand = this.hand.remove(this.hand.countUntil(card));
        }
    }

}