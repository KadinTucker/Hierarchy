module hierarchy.graphics.activity.MenuActivity;

import hierarchy;

/**
 * The activity present when the user is in the menu
 */
class MenuActivity : Activity {

    Texture drawTexture; ///The texture to draw to the screen; for buttons and things

    /**
     * Constructs a new menu activity
     */
    this(Display container) {
        super(container);
        Surface drawSurface = new Surface(600, 400, SDL_PIXELFORMAT_RGBA32);
        drawSurface.blit(Image.allImages[ImagePath.TITLE], null, 0, 0);
        drawSurface.blit(Image.allImages[ImagePath.HOST], null, 200, 150);
        drawSurface.blit(Image.allImages[ImagePath.JOIN], null, 200, 250);
        drawSurface.blit(Image.allImages[ImagePath.QUIT], null, 200, 350);
        this.drawTexture = new Texture(drawSurface, container.renderer);
    }

    /**
     * Clears the screen with green
     */
    override void draw() {
        this.container.renderer.clear();
        this.container.renderer.copy(this.drawTexture, 250, 50);
    }

}