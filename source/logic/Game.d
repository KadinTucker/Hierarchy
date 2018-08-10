module hierarchy.logic.Game;

import hierarchy;

import std.conv;
import std.json;

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

    /**
     * Saves the game data to a file which can be json read
     */
    void exportToJson() {
        string toParse = "{\"pile\": {\"mode\"" ~ this.pile.mode.to!string ~ ",
                        \"cards\"" ~ this.formatIntoList(this.pile.cards) ~ "},
                        \"players\": " ~ this.formatIntoList(this.players) ~ ",
                        \"active\": " ~ this.activePlayerIndex.to!string ~ ",
                        \"lastplayed\": " ~ this.lastPlayedIndex.to!string ~ ",
                        \"cleared\": " ~ this.isCleared.to!string ~ "}";
        //TODO: make it save to file using file io
    }

    /**
     * Formats a list of objects into jsonable string
     * Uses formatObject template, see below
     */
    private string formatIntoList(T)(T[] toParse) {
        string jsonString = "[";
        for(int i = 0; i < toParse.length; i++) {
            jsonString ~= this.formatObject(toParse[i]);
            if(i < toParse.length - 1) {
                jsonString ~= ",";
            }
        }
        jsonString ~= "]";
        return jsonString;
    }

    /**
     * Formats a player into a json string
     */
    private string formatObject(Player player) {
        return "{\"id\": " ~ player.id.to!string ~ ",
                \"uname\"" ~ player.uname ~ ",
                \"knocked\"" ~ player.knocked.to!string ~ ",
                \"cards\"" ~ this.formatIntoList(player.hand) ~ "}";
    }

    /**
     * Formats a card into a json string
     */
    private string formatObject(Card card) {
        return "{\"type\": \"" ~ card.type.to!string ~ "\",
                \"suit\": \"" ~ card.suit.to!string ~ "\"}";
    }

}