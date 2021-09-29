import java.util.*;

ArrayList < Vertex > vertices;
ArrayList < Edge > edges;
Edge selected;

int algorithm = 0;

int mode = 0;
int vertexNum = 25;
int randomConnectionsPervertex = 3;
int minSeperation;

HScrollbar numberOfVertices, randomConnections;

Button iterate, solve;
Button reset, labels, enter;
Button confirmVertices, confirmEdges, solveEntered;
Button kruskals, prims, boruvkas;
String instruction = "";
String entryInstruction = "";

boolean lockSliders = false;
boolean labelsOn = true;

int toSet = 0;
boolean VerticesEntered = false;
boolean edgesEntered = false;

int label = 0;

Vertex firstvertex = null;
Vertex secondvertex = null;

boolean labelEntry = false;
Edge toAdjust = null;

void setup() {
    frameRate(60);
    fullScreen();
    rectMode(CENTER);
    ellipseMode(CENTER);
    textAlign(CENTER, CENTER);
    generateVertices();
    generateEdges();
    strokeWeight(2);
    textSize(12);

    minSeperation = 200 - (2 * vertexNum);

    enter = new Button("Enter A Graph", 15, (height/6)-50, 120, 50);
    iterate = new Button("Iterate Once", 15, (height/3)-50, 120, 50);
    solve = new Button("Solve", 15, (height/2)-50, 120, 50);
    labels = new Button("Labels", 15, ((2*height)/3)-50, 120, 50);
    reset = new Button("Reset", 15, ((5*height)/6)-50, 120, 50);

    kruskals = new Button("Kruskal's", (width/4)-120, 60, 240, 30);
    prims = new Button("Prim's", (width/2)-120, 60, 240, 30);
    boruvkas = new Button("Boruvka's", (3*(width/4))-120, 60, 240, 30);

    confirmVertices = new Button("Confirm Vertices", 15, (height/6)-50, 120, 50);
    confirmEdges = new Button("Confirm Edges ", 15, (height/6)-50, 120, 50);

    numberOfVertices = new HScrollbar(20, height - 50, (width / 2) - 40, 16, 10);
    randomConnections = new HScrollbar((width / 2) + 20, height - 50, (width / 2) - 40, 16, 10);
}

void draw() {
    background(0);

    drawButtons();
    drawTitle();
    drawBorder();
    drawLabelIndicator();

    if (mode == 1) {
        checkForSelected();

        drawEntryInstruction();
        drawEdges();
        drawSolution();
        drawVertices();
        drawLabels();
        drawStep(instruction);

        if (!VerticesEntered) {
            confirmVertices.Draw();
        } else if (VerticesEntered && !edgesEntered) {
            confirmEdges.Draw();
        }

        if (firstvertex != null && secondvertex == null) {
            line(firstvertex.getX(), firstvertex.getY(), mouseX, mouseY);
        }
    } else if (mode == 0) {
        minSeperation = 125 - (4 * vertexNum) + 80;

        checkForSelected();

        drawEdges();
        drawSolution();
        drawLabels();
        drawVertices();
        displaySelected();
        drawStep(instruction);
        enter.Draw();
        sliders();

        int old = vertexNum;
        vertexNum = Math.round(2 * numberOfVertices.getPos() / 30) + 4;

        int oldVertices = randomConnectionsPervertex;
        randomConnectionsPervertex = Math.round(randomConnections.getPos() / 135) - 4;

        if (!lockSliders) {
            if (old != vertexNum) {
                generateVertices();
                generateEdges();
                solution.clear();
            } else if (oldVertices != randomConnectionsPervertex) {
                generateVertices();
                generateEdges();
                solution.clear();
            }
        }
    }
}

void mousePressed() {
    if (reset.MouseIsOver()) {
        reset();
    }

    if (labels.MouseIsOver()) {
        labelsOn = !labelsOn;
    }

    if (solution.isEmpty()) {
        if (kruskals.MouseIsOver()) {
            algorithm = 0;
        } else if (prims.MouseIsOver()) {
            algorithm = 1;
        } else if (boruvkas.MouseIsOver()) {
            algorithm = 2;
        }
    }

    if (labelEntry) {
        return;
    }

    if (mode == 0) {
        if (iterate.MouseIsOver()) {
            instruction = iterate();
            lockSliders = true;
        }

        if (solve.MouseIsOver()) {
            lockSliders = true;
            while (instruction != "Completed") {
                instruction = iterate();
            }
        }

        if (enter.MouseIsOver()) {
            mode = 1;
            vertices.clear();
            edges.clear();
            solution.clear();
            entryInstruction = "Click on the screen to add node, click the node again to remove it. Once all the nodes are added, click the Confirm Vertices button to continue.";
        }
    } else {
        if (VerticesEntered && edgesEntered) {
            if (iterate.MouseIsOver()) {
                instruction = iterate();
            }

            if (solve.MouseIsOver()) {
                while (instruction != "Completed") {
                    instruction = iterateKruskals();
                }
            }
            return;
        }

        if (VerticesEntered && !edgesEntered) {
            for (Edge edge: edges) {
                if (edge.MouseIsOver()) {
                    labelEntry = true;
                    toSet = 0;
                    toAdjust = edge;
                    break;
                }
            }
            boolean oververtex = false;
            for (Vertex vertex: vertices) {
                if (vertex.MouseIsOver()) {
                    if (firstvertex == null) {
                        firstvertex = vertex;
                    } else if (firstvertex != null && secondvertex == null && vertex != firstvertex) {
                        secondvertex = vertex;
                        edges.add(new Edge(firstvertex, secondvertex));
                        firstvertex = null;
                        secondvertex = null;
                    }

                    oververtex = true;
                }
            }

            if (!oververtex) {
                firstvertex = null;
                secondvertex = null;
            }
        }

        if (!VerticesEntered && !confirmVertices.MouseIsOver()) {
            ArrayList < Vertex > toRemove = new ArrayList();

            for (Vertex vertex: vertices) {
                if (vertex.MouseIsOver()) {
                    toRemove.add(vertex);
                }
            }

            if (toRemove.size() == 0 && mouseX > 162.5 && mouseX < width - 25 && mouseY > 112.5 && mouseY < height - 162.5) {
                vertices.add(new Vertex(mouseX, mouseY, label));
                label++;
            }

            for (Vertex vertex: toRemove) {
                vertices.remove(vertex);
            }
        }

        if (!VerticesEntered && confirmVertices.MouseIsOver() && vertices.size() > 1) {
            entryInstruction = "To add an edge, click a start node, next click on the ending node of the edge. To change the weight, enable labels and click the label, then type the weight value and hit enter. Click Confirm Edges once all edges are added.";
            VerticesEntered = true;
        }

        if (confirmEdges.MouseIsOver() && edges.size() > 0 && VerticesEntered && !edgesEntered) {
            entryInstruction = "Click Iterate to perform an iteration of the algorithm, click Solve to find the minimum spanning tree of the input.";
            edgesEntered = true;
        }
    }
}

void reset(){
    generateVertices();
    generateEdges();
    solution.clear();
    trees.clear();
    instruction = "";
    lockSliders = false;
    mode = 0;
    VerticesEntered = false;
    edgesEntered = false;
    label = 0;
    mstSet.clear();
    firstVertexPicked = false;
    i = 0;
    init = false;
}

void keyPressed() {
    if (mode == 0 || (VerticesEntered && edgesEntered)) {
        if (key == ' ') {
            instruction = iterate();
        }
    }
    
    if (key == 'r'){
        reset();
    }

    if (labelEntry) {
        if (key == '1') {
            if (toSet == 0) {
                toSet = 1;
            } else {
                toSet *= 10;
                toSet += 1;
            }
        } else if (key == '2') {
            if (toSet == 0) {
                toSet = 2;
            } else {
                toSet *= 10;
                toSet += 2;
            }
        } else if (key == '3') {
            if (toSet == 0) {
                toSet = 3;
            } else {
                toSet *= 10;
                toSet += 3;
            }
        } else if (key == '4') {
            if (toSet == 0) {
                toSet = 4;
            } else {
                toSet *= 10;
                toSet += 4;
            }
        } else if (key == '5') {
            if (toSet == 0) {
                toSet = 5;
            } else {
                toSet *= 10;
                toSet += 5;
            }
        } else if (key == '6') {
            if (toSet == 0) {
                toSet = 6;
            } else {
                toSet *= 10;
                toSet += 6;
            }
        } else if (key == '7') {
            if (toSet == 0) {
                toSet = 7;
            } else {
                toSet *= 10;
                toSet += 7;
            }
        } else if (key == '8') {
            if (toSet == 0) {
                toSet = 8;
            } else {
                toSet *= 10;
                toSet += 8;
            }
        } else if (key == '9') {
            if (toSet == 0) {
                toSet = 9;
            } else {
                toSet *= 10;
                toSet += 9;
            }
        } else if (key == '0') {
            if (toSet == 0) {
                toSet = 0;
            } else {
                toSet *= 10;
            }
        } else if (key == BACKSPACE) {
            toSet /= 10;
        } else if (key == ENTER && toSet != 0) {
            labelEntry = false;
        }

        toAdjust.setWeight(toSet);
    }
}

String iterate() {
    String toReturn = "";
    if (algorithm == 0) {
        toReturn = iterateKruskals();
    } else if (algorithm == 1) {
        toReturn = iteratePrims();
    } else if (algorithm == 2) {
        toReturn = iterateBoruvkas();
    }
    return toReturn;
}
