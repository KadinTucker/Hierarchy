module hierarchy.graphics.component.Notifications;

import hierarchy;

/**
 * A component which shows the notifications coming from the game
 */
class Notifications : Component {

    iRectangle _location; ///The location of the component; accessed by property method
    Texture _drawTexture; ///The texture to draw to the screen

    /**
     * Constructs a new notfications component in the given display and at the given location
     */
    this(Display container, iRectangle location) {
        super(container);
        this._location = location;
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
     * Updates the texture to be drawn to the screen
     * Uses the text given
     */
    void updateTexture(string text=" ") {
        Font font = new Font("res/font/Courier.ttf", 50);
        this._drawTexture = new Texture(font.renderTextSolid(text, Color(75, 10, 10)), this.container.renderer);
    }

    void handleEvent(SDL_Event event) {}

}