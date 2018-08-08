module hierarchy.graphics.component.HandComponent;

import hierarchy;

import std.algorithm;

/**
 * The screen component which displays the player's hand
 * Draws cards in a fashion that pleases the eye
 */
class HandComponent : Component {

    iRectangle _location; ///The location of the component; accessed by property method
    Texture _drawTexture; ///The texture to draw to the screen
    Player owner; ///The player whose hand to indicate with this component
    int[] selectedCards; ///The cards selected by the player by index
    iRectangle[] cardPositions; ///The card positions relative to the component; x is distance along and y is the width of the card; for use in clicking 

    /**
     * Constructs a new handcomponent in the given display and at the given location
     */
    this(Display container, iRectangle location, Player owner) {
        super(container);
        this._location = location;
        this.owner = owner;
        sortHand(this.owner.hand);
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
    void updateTexture() {
        Surface handSurface = new Surface(this._location.extent.x, this._location.extent.y, SDL_PIXELFORMAT_RGBA32);
        handSurface.fill(new iRectangle(0, 0, this._location.extent.x, this._location.extent.y), Color(5, 70, 10));
        int[] positions = this.getDrawPositions(this.owner.hand.length);
        int increment;
        foreach(pos; positions) {
            if(this.selectedCards.canFind(increment)) {
                handSurface.blit(Image.allImages[ImagePath.CARD_HIGHLIGHT], null, pos - 3, 0);
            }
            handSurface.blit(Image.getCardImage(this.owner.hand[increment]), null, pos, 3);
            increment++;
        }
        this._drawTexture = new Texture(handSurface, this.container.renderer);
        this.updateCardPositions();
    }

    /**
     * Updates the stored card positions
     * based on the cards in hand
     */
    private void updateCardPositions() {
        this.cardPositions = null;
        int[] positions = this.getDrawPositions(this.owner.hand.length);
        if(this.owner.hand.length == 0) {
            this.cardPositions = [];
            return;
        }
        for(int i = 0; i < positions.length - 1; i++) {
            this.cardPositions ~= new iRectangle(positions[i], 3, positions[i + 1] - positions[i], Image.allImages[ImagePath.CARD_BASE].dimensions.y);
        }
        if(positions.length > 0) {
            this.cardPositions ~= new iRectangle(positions[positions.length - 1], 3, Image.allImages[ImagePath.CARD_BASE].dimensions.x,
                    Image.allImages[ImagePath.CARD_BASE].dimensions.y);
        }
    }

    /**
     * Gets the pixel positions at which to draw each card,
     * given a number of cards
     * Also sets the stored cardPositions
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
            for(int i = -(numCards / 2); i < -(numCards / 2) + numCards; i++) {
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

    /**
     * Selects a card at the given index of cards in hand
     */
    private void selectCard(int index) {
        if(this.selectedCards.canFind(index)) {
            import std.algorithm;
            this.selectedCards = this.selectedCards.remove(this.selectedCards.countUntil(index));
        } else {
            this.selectedCards ~= index;
        }
        this.updateTexture();
    }

    /**
     * Returns the actual cards that are selected 
     * from the indices as thusly stored in this object 
     */
    Card[] getSelectedCards() {
        Card[] toPlay;
        foreach(index; selectedCards) {
            toPlay ~= this.owner.hand[index];
        }
        return toPlay;
    }

    /**
     * When the user clicks, try to select a card
     * TODO: Have the user be able to drag across cards to select
     */
    void handleEvent(SDL_Event event) {
        if(event.type == SDL_MOUSEBUTTONDOWN) {
            if(event.button.button == SDL_BUTTON_LEFT) {
                for(int i = 0; i < this.cardPositions.length; i++) {
                    if(this.cardPositions[i].contains(new iVector(this.container.mouse.location.x - this._location.initialPoint.x, 
                            this.container.mouse.location.y - this._location.initialPoint.y))) {
                        this.selectCard(i);
                    }
                }
            } else if(event.button.button == SDL_BUTTON_RIGHT) {
                this.selectedCards = null;
                this.updateTexture();
            }
        }
    }
 
}