module hierarchy.graphics.activity.MenuActivity;

import hierarchy;

/**
 * The activity present when the user is in the menu
 */
class MenuActivity : Activity {

    Texture drawTexture; ///The texture to draw to the screen; for buttons and things
    iRectangle hostButton; ///The rectangle which bounds the host button
    iRectangle joinButton; ///The rectangle bounding the join button
    iRectangle quitButton; ///The rectangle defining the boundaries of the quit button

    /**
     * Constructs a new menu activity
     */
    this(Display container) {
        super(container);
        this.hostButton = new iRectangle(450, 200, 200, 50);
        this.joinButton = new iRectangle(450, 300, 200, 50);
        this.quitButton = new iRectangle(450, 400, 200, 50);
        Surface drawSurface = new Surface(1100, 500, SDL_PIXELFORMAT_RGBA32);
        drawSurface.blit(Image.allImages[ImagePath.TITLE], null, 250, 50);
        drawSurface.blit(Image.allImages[ImagePath.HOST], null, this.hostButton.initialPoint.x, this.hostButton.initialPoint.y);
        drawSurface.blit(Image.allImages[ImagePath.JOIN], null, this.joinButton.initialPoint.x, this.joinButton.initialPoint.y);
        drawSurface.blit(Image.allImages[ImagePath.QUIT], null, this.quitButton.initialPoint.x, this.quitButton.initialPoint.y);
        this.drawTexture = new Texture(drawSurface, container.renderer);
    }

    /**
     * Clears the screen with green
     */
    override void draw() {
        this.container.renderer.clear();
        this.container.renderer.copy(this.drawTexture, 0, 0);
    }

    /**
     * Handles incoming events 
     * Checks if the menu buttons have been clicked
     * TODO: Make this done less crappily
     */
    override void handleEvent(SDL_Event event) {
        import std.stdio;
        if(event.type == SDL_MOUSEBUTTONDOWN) {
            if(event.button.button == SDL_BUTTON_LEFT) {
                writeln("Left clicked");
                writeln(this.container.mouse.location);
                if(this.quitButton.contains(this.container.mouse.location)) {
                    writeln("quit");
                    this.container.isRunning = false;
                } else if(this.hostButton.contains(this.container.mouse.location)) {
                    writeln("host");
                    this.container.activity = new GameActivity(this.container, new Game(4, GameType.HOST)); //TODO: add lobbies 
                }
            }
        }
    }

}