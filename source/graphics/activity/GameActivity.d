module hierarchy.graphics.activity.GameActivity;

import hierarchy;

/**
 * The activity in which the player plays the game
 */
class GameActivity : Activity {

    HandComponent hand; ///The hand component used by the player on this activity
    CenterPile pile; ///The center-pile component for the game
    Notifications notificationComponent; ///The notifications display component
    Game game; ///The game being run by this activity

    /**
     * Constructs a new game activity in the given container
     */
    this(Display container, Game game) {
        super(container);
        this.hand = new HandComponent(container, new iRectangle(287, 525, 525, 120), 
                game.players[game.activePlayerIndex]);
        this.components ~= this.hand;
        this.pile = new CenterPile(container, new iRectangle(500, 200, 150, 115), game.pile);
        this.components ~= this.pile;
        this.notificationComponent = new Notifications(container, new iRectangle(450, 150, 250, 30));
        this.components ~= this.notificationComponent;
        this.game = game;
    }

    /**
     * Set's the game's notification on the notification component
     */
    @property void notification(string toSet) {
        this.notificationComponent.updateTexture(toSet);
    }

    /**
     * Clears the screen with green
     */
    override void draw() {
        this.container.renderer.clear();
    }

    /**
     * Handles events
     * Handles moving cards from the hand to the center pile
     * TODO: Make this happen
     */
    override void handleEvent(SDL_Event event) {
        if(event.type == SDL_MOUSEBUTTONDOWN) {
            if(event.button.button == SDL_BUTTON_LEFT) {
                if(this.game.isCleared) {
                    this.game.pile.reset();
                    this.pile.updateTexture();
                    this.hand.selectedCards = null;
                    this.hand.updateTexture();
                    this.game.isCleared = false;
                    this.notification = " ";
                } else if(this.pile.location.contains(this.container.mouse.location)) {
                    if(this.playCards(this.hand.getSelectedCards())) {
                        this.hand.owner.discardCards(this.hand.getSelectedCards());
                        this.hand.selectedCards = null;
                    }
                    this.hand.updateTexture();
                    this.pile.updateTexture();
                }
            }
        }
        this.hand.updateTexture();
        this.pile.updateTexture();
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
        if(this.game.pile.cards.length > 0 && type.value < this.game.pile.cards[0].type.value) { //Must have cards be equal or greater value
            return false;
        }
        Card[] topCards = this.game.pile.getTopCards();
        bool sameType;
        if(topCards.length > 0) {
            sameType = topCards[0].type == played[0].type; //Checks if the card(s) to be played are the same type as those beneath; for use in various places
        }
        if(sameType && topCards.length + played.length == 4) { //If a 4 is completed, clear TODO: Make bombs able to happen
            this.game.pile.addToPile(played);
            this.game.isCleared = true;
            this.notification = "Clear!";
            //Set active player to be the one who played the four
            return true;
        }
        if(this.hand.owner.id != this.game.players[this.game.activePlayerIndex].id) { //4 can be completed out of turn, but otherwise player cannot play
            this.notification = "It's not your turn";
            return false;
        }
        if(this.game.pile.mode != 0 && played.length != this.game.pile.mode) { //If a 4 is not completed and the mode of play is not followed, cannot play
            return false;
        }
        this.game.pile.addToPile(played);
        if(played[0].type == CardType.TWO) { //If two(s) are played, clear
            this.game.isCleared = true;
            this.notification = "Clear!";
            return true;
        }
        if(this.game.pile.mode == 1 && sameType) { //Check for skips
            if(played.length == 1) { 
                this.game.activePlayerIndex += 2;
                this.notification = "Skip";
            } else {
                this.game.activePlayerIndex += 3;
                this.notification = "Double Skip";
            }
        } else {
            this.game.activePlayerIndex += 1;
            this.notification = " ";
        }
        this.game.activePlayerIndex %= this.game.players.length;
        return true;
    }

}