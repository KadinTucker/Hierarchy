module hierarchy.logic.Game;

import hierarchy;

import std.conv;
import std.socket;

/**
 * An enum that determines how the game should be constructed
 */
enum GameType {
    HOST=0,
    JOIN=1
}

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

    Socket socket; ///The socket through which the game connects to other computers

    /**
     * Constructs a new game object
     * with the given number of players
     * Based on the game type, either creates a host or joins a port
     */
    this(int numPlayers, GameType type) {
        Deck tempDeck = new Deck();
        Card[][] allHands = tempDeck.distributeCards(numPlayers);
        for(int i = 0; i < allHands.length; i++) {
            this.players ~= new Player(i, "Test Player", this);
            this.players[i].hand = allHands[i];
        }
        this.pile = new Pile();
        this.socket = new Socket(AddressFamily.INET, SocketType.STREAM);
        if(type == GameType.HOST) { 
            Address[] addresses = getAddress("127.0.0.1");
            this.socket.bind(addresses[0]);
        } else if(type == GameType.JOIN) {
            Address[] addresses = getAddress("127.0.0.1");
            this.socket.connect(addresses[0]);
        }
    }

    /**
     * Shutdown the game's socket when the game is closed
     */
    ~this() {
        this.socket.shutdown(SocketShutdown.BOTH);
        this.socket.close();
    }

}