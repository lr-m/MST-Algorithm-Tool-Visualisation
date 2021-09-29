void drawTitle() {
    fill(255);
    textSize(30);
    text("Minimum Spanning Tree Finder", width / 2, 25);
    textSize(12);
}

void drawBorder() {
    fill(0);
    stroke(255);
    rectMode(CORNER);
    rect(150, 100, width - 175, height - 260);
    rectMode(CENTER);
}

void drawEdges() {
    for (Edge edge: edges) {
        edge.Draw();
    }
}

void drawSolution() {
    for (Edge edge: solution) {
        edge.DrawSolution();
    }
}

void drawVertices() {
    for (Vertex vertex: vertices) {
        vertex.Draw();
    }
}

void drawLabels() {
    if (labelsOn) {
        for (Edge edge: edges) {
            edge.drawWeight();
        }

        for (Edge edge: solution) {
            edge.drawWeight();
        }
    }
}

void drawLabelIndicator() {
    if (labelsOn) {
        fill(0, 255, 0);
    } else {
        fill(255, 0, 0);
    }

    rectMode(CORNER);
    rect(35, (2*height/3)-12, 80, 5);
    rectMode(CENTER);
}

void displaySelected() {
    if (selected != null) {
        textSize(20);
        fill(255);
        text("Weight:", 150, 20);
        fill(100, 100);
        rect(150, 60, 75, 35);
        fill(255);
        text(selected.getWeight(), 150, 60);

        fill(255);
        text("Edge:", 57.5, 20);
        fill(100, 100);
        rect(57.5, 60, 75, 35);
        fill(255);
        text(selected.getStart().label + "-" + selected.getEnd().label, 57.5, 60);
        textSize(12);
    }
}

void drawEntryInstruction() {
    fill(0);
    stroke(255);
    rectMode(CORNER);
    rect(20, height - 80, width - 45, 60);
    rectMode(CENTER);

    fill(255);
    textSize(16);
    text("Instruction:", width / 2, height - 65);
    textSize(12);
    text(entryInstruction, width / 2, height-45, width - 100, 100);
}

void drawStep(String string) {
    textSize(24);
    fill(255);
    if (mode == 0 && string != "") {
        text("Current Step: " + string, width / 2, height - 120);
    } else if (mode == 1 && string != "") {
        text(string, width / 2, height - 120);
    }
}

void drawSliderTitles() {
    fill(255);
    text("Number of Vertices: " + vertexNum, width / 4, height-75);
    text("Number of Random Connections: " + randomConnectionsPervertex, 3 * (width / 4), height-75);
}

void drawButtons() {
    iterate.Draw();
    solve.Draw();
    labels.Draw();
    reset.Draw();
    
    if (algorithm == 0){
        kruskals.drawSelected();
        boruvkas.Draw();
        prims.Draw();
    } else if (algorithm == 1){
        kruskals.Draw();
        boruvkas.Draw();
        prims.drawSelected();
    } else {
        kruskals.Draw();
        boruvkas.drawSelected();
        prims.Draw();
    }
}

void sliders() {
    drawSliderTitles();
    numberOfVertices.update();
    randomConnections.update();
    numberOfVertices.display();
    randomConnections.display();
}
