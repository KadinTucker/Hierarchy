module hierarchy.graphics.GameActivity;

import hierarchy;

class GameActivity : Activity {

    HandComponent hand; ///The hand component used by the player on this activity

    this(Display container) {
        super(container);
        this.hand = new HandComponent(container, new iRectangle(287, 535, 525, 115));
        this.components ~= this.hand;
    }

    override void draw() {
        this.container.renderer.clear();
    }

}