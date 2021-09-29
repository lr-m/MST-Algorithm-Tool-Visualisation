class Button {
    String label;
    float x; // top left corner x position
    float y; // top left corner y position
    float w; // width of button
    float h; // height of button

    // Button constructor
    Button(String labelB, float xpos, float ypos, float widthB, float heightB) {
        label = labelB;
        x = xpos;
        y = ypos;
        w = widthB;
        h = heightB;
    }

    boolean pressed = false;
    float animationI = 0;

    // Draw the button with default label
    void Draw() {
        rectMode(CORNER);
        stroke(255);
        
        if (pressed) {
            pressed = false;
        }

        if (animationI > 0) {
            fill(lerpColor(color(100, 100), color(200), animationI / 25));
            animationI--;
        } else {
            fill(100, 100);
        }

        textSize(14);
        rect(x, y, w, h);
        textAlign(CENTER, CENTER);
        fill(255);
        text(label, x + (w / 2), y + (h / 2));
        rectMode(CENTER);
    }

    // Draw the button with the passed PImage
    void Draw(PImage image) {
        fill(255);
        image(image, x, y, w, h);
        textAlign(CENTER, CENTER);
        fill(0);
    }

    // Draws the button with a darker fill to signify that it has been selected.
    void drawSelected() {
        rectMode(CORNER);
        if (pressed == true) {
            if (animationI < 25) {
                fill(lerpColor(color(100, 100), color(200), animationI / 25));
                animationI++;
            } else {
                fill(200);
            }
        }

        textSize(14);
        rect(x, y, w, h);
        textAlign(CENTER, CENTER);
        fill(lerpColor( color(255), color(0), animationI / 25));
        if (animationI == 0){
            fill(0);
        }
        
        text(label, x + (w / 2), y + (h / 2));
        rectMode(CENTER);
    }

    // Returns a boolean indicating if the mouse was above the button when the mouse was pressed
    boolean MouseIsOver() {
        if (mouseX > x && mouseX < (x + w) && mouseY > y && mouseY < (y + h)) {
            pressed = true;
            return true;
        }
        return false;
    }
}
