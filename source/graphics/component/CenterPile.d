module hierarchy.graphics.component.CenterPile;

import hierarchy;

/**
 * The screen component which displays the pile of cards in the middle
 */
class CenterPile : Component {

    iRectangle _location; ///The location of the component; accessed by property method
    Texture _drawTexture; ///The texture to draw to the screen
    Pile pile; ///The cards on the pile, in reverse order

    /**
     * Constructs a new center pile component in the given display and at the given location
     */
    this(Display container, iRectangle location, Pile pile) {
        super(container);
        this._location = location;
        this.pile = pile;
        this.updateTexture();
    }

    /**
     * Returns the component location
     */
    override @property iRectangle location() {
        return this._location;
    }

    /**
     * Sets the component location
     */
    @property void location(iRectangle newLocation) {
        this._location = newLocation;
    }

    /**
     * Draws the component's draw texture to its location
     */
    override void draw() {
        this.container.renderer.copy(this._drawTexture, this._location);
    }

    /**
     * Updates the texture to be drawn 
     * Happens whenever there is a change to the pile
     */
    private void updateTexture() {
        Surface pileSurface = new Surface(this._location.extent.x, this._location.extent.y, SDL_PIXELFORMAT_RGBA32);
        pileSurface.fill(new iRectangle(0, 0, this._location.extent.x, this._location.extent.y), Color(5, 70, 10));
        Card[] toBeDrawn = this.pile.getTopCards();
        for(int i = 0; i < toBeDrawn.length; i++) {
            pileSurface.blit(Image.getCardImage(toBeDrawn[i]), null, i * this._location.extent.x / toBeDrawn.length, 0);
        }
        this._drawTexture = new Texture(pileSurface, this.container.renderer);
    }

    void handleEvent(SDL_Event event) {}

}