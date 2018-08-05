module hierarchy.app;

import hierarchy;

void main() {
    Image.initialize();
	Display display = new Display(1100, 690, SDL_WINDOW_SHOWN | SDL_WINDOW_RESIZABLE, 0, "Hierarchy");
}
