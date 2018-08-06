module hierarchy.graphics.component.HandComponent;

import hierarchy;

/**
 * The screen component which displays the player's hand
 * Draws cards in a fashion that pleases the eye
 */
class HandComponent : Component {

    iRectangle _location; ///The location of the component; accessed by property method
    Texture _drawTexture; ///The texture to draw to the screen

    /**
     * Constructs a new handcomponent in the given display and at the given location
     */
    this(Display container, iRectangle location) {
        super(container);
        this._location = location;
        Deck tempDeck = new Deck();
        this.updateTexture(tempDeck.distributeCards(7)[0]);
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

    override void draw() {
        this.container.renderer.copy(this._drawTexture, this._location);
    }

    private void updateTexture(Card[] cards) {
        import std.stdio;
        writeln(cards);
        Surface handSurface = new Surface(this._location.extent.x, this._location.extent.y, SDL_PIXELFORMAT_RGBA32);
        handSurface.fill(new iRectangle(0, 0, this._location.extent.x, this._location.extent.y), Color(5, 70, 10));
        int[] positions = this.getDrawPositions(cards.length);
        foreach(pos; positions) {
            handSurface.blit(Image.allImages[ImagePath.CARD_BASE], null, pos, 0);
        }
        this._drawTexture = new Texture(handSurface, this.container.renderer);
    }

    /**
     * Gets the pixel positions at which to draw each card,
     * given a number of cards
     * Assumes that cards are 75 px wide and that there
     * can be a maximum of 7 cards
     * TODO: Make this more modular with the hand component's width
     */
    private int[] getDrawPositions(int numCards) {
        int[] positions;
        if(numCards > 7) {
            int actingWidth = 75 - 75 * (numCards - 7) / (numCards - 1); //75 is card width
            for(int i = 0; i < numCards; i++) {
                positions ~= i * actingWidth;
            }
        } else {
            for(int i = -(numCards / 2); i < numCards / 2; i++) {
                positions ~= (i + 3) * 75; //3 is 7 (max cards) integer divided by 2
            }
            if(numCards % 2 == 0) {
                for(int i = 0; i < positions.length; i++) {
                    positions[i] += 37; //37 is 75 / 2
                }
            }
        }
        return positions;
    }

    void handleEvent(SDL_Event event) {}
 
}