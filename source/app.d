module hierarchy.app;

import hierarchy;

void main() {
    Image.initialize();
	Display display = new Display(1100, 650, SDL_WINDOW_SHOWN | SDL_WINDOW_RESIZABLE, 0, "Hierarchy");
    display.renderer.drawColor = Color(10, 100, 20);
    display.activity = new MenuActivity(display);
    display.run();
}
