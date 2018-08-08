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
     * Tries to play cards the player's hand
     * Uses a list of indices from the hand
     * Returns whether or not the play occurred
     */
    bool playCards(int[] toPlayIndices) {
        Card[] toPlay;
        foreach(index; toPlayIndices) {
            toPlay ~= this.hand[index];
        }
        bool played = this.game.playCards(toPlay);
        if(played) {
            foreach(card; toPlay) {
                import std.algorithm;
                this.hand = this.hand.remove(this.hand.countUntil(card));
            }
        }
        return played;
    }

}