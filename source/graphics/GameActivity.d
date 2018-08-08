module hierarchy.graphics.GameActivity;

import hierarchy;

/**
 * The activity in which the player plays the game
 * TODO: Make it store a game
 */
class GameActivity : Activity {

    HandComponent hand; ///The hand component used by the player on this activity
    CenterPile pile; ///The center-pile component for the game

    /**
     * Constructs a new game activity in the given container
     */
    this(Display container) {
        super(container);
        this.hand = new HandComponent(container, new iRectangle(287, 525, 525, 120));
        this.components ~= this.hand;
        this.pile = new CenterPile(container, new iRectangle(500, 200, 150, 115), new Pile());
        this.components ~= this.pile;
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
                if(this.pile.contains(this.container.mouse.location)) {
                    //TODO:
                }
            }
        }
    }

}