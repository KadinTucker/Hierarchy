module hierarchy.graphics.component.HandComponent;

import hierarchy;

/**
 * The screen component which displays the player's hand
 * Draws cards in a fashion that pleases the eye
 */
class HandComponent : Component {

    iRectangle _location; ///The location of the component; accessed by property method
    Texture _drawTexture; ///The texture to draw to the screen
    Card[] hand; ///The hand indicated by this component

    /**
     * Constructs a new handcomponent in the given display and at the given location
     */
    this(Display container, iRectangle location) {
        super(container);
        this._location = location;
        Deck tempDeck = new Deck();
        this.hand = tempDeck.distributeCards(4)[0];
        sortHand(this.hand);
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
     * Updates the texture to drawn to the screen
     * Happens whenever there is a change to the hand
     */
    private void updateTexture() {
        Surface handSurface = new Surface(this._location.extent.x, this._location.extent.y, SDL_PIXELFORMAT_RGBA32);
        handSurface.fill(new iRectangle(0, 0, this._location.extent.x, this._location.extent.y), Color(5, 70, 10));
        int[] positions = this.getDrawPositions(this.hand.length);
        int increment;
        foreach(pos; positions) {
            handSurface.blit(Image.getCardImage(this.hand[increment]), null, pos, 0);
            increment++;
        }
        this._drawTexture = new Texture(handSurface, this.container.renderer);
    }

    /**
     * Gets the pixel positions at which to draw each card,
     * given a number of cards
     */
    private int[] getDrawPositions(int numCards) {
        int[] positions;
        int cardWidth = Image.allImages[ImagePath.CARD_BASE].dimensions.x;
        int maxCards = this._location.extent.x / cardWidth;
        if(numCards > maxCards) {
            int actingWidth = cast(int)(cardWidth * (1.0 - (numCards - maxCards) / cast(double)(numCards - 1)));
            for(int i = 0; i < numCards; i++) {
                positions ~= i * actingWidth;
            }
        } else {
            for(int i = -(numCards / 2); i < numCards / 2; i++) {
                positions ~= (i + maxCards / 2) * cardWidth;
            }
            if(numCards % 2 == 0) {
                for(int i = 0; i < positions.length; i++) {
                    positions[i] += cardWidth / 2;
                }
            }
        }
        return positions;
    }

    void handleEvent(SDL_Event event) {}
 
}