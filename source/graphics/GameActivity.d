module hierarchy.graphics.GameActivity;

import hierarchy;

/**
 * The activity in which the player plays the game
 * TODO: Make it store a game
 */
class GameActivity : Activity {

    HandComponent hand; ///The hand component used by the player on this activity
    CenterPile pile; ///The center-pile component for the game
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
        this.game = game;
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
                if(this.pile.location.contains(this.container.mouse.location)) {
                    if(this.game.players[this.game.activePlayerIndex].playCards(this.hand.selectedCards)) {
                        this.hand.selectedCards = null;
                    }
                    this.hand.updateTexture();
                    this.pile.updateTexture();
                }
            }
        }
    }

}