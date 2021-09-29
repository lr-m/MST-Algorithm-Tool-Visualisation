void generateVertices(){
    vertices = new ArrayList();
    int label = 0;
    while(vertices.size() < vertexNum){
        Vertex newvertex = new Vertex(Math.round(random(162.5, width - 35)), Math.round(random(112.5, height - 200)), label);
        if (checkVerticesForProximity(newvertex)){
            vertices.add(newvertex);
            label++;
        }
    }
}

void addEdge(Edge edge){
    if (!edgeExists(edge)){
        edges.add(edge);
    }
}

boolean edgeExists(Edge testEdge){
    for (Edge edge : edges){
        if (testEdge.getStart() == edge.getStart() || testEdge.getStart() == edge.getEnd()){
            if (testEdge.getEnd() == edge.getStart() || testEdge.getEnd() == edge.getEnd()){
                return true;
            }
        }
    }
    return false;
}

void generateEdges(){
    edges = new ArrayList();
    for (Vertex vertex : vertices){
        
        addEdge(new Edge(vertex, getClosestvertex(vertex)));
        
        for (int i = 0; i < randomConnectionsPervertex; i++){
            int rand1 = Math.round(random(0, vertices.size()-1));
            Vertex vertex1 = vertices.get(rand1);
            
            if (vertex1 != vertex){
                addEdge(new Edge(vertex, vertex1));
            }
        }
    }
    
    ArrayList<Edge> toRemove = new ArrayList();
    
    for (Edge edge : edges){
        if (edge.getWeight() == 0){
            toRemove.add(edge);
        }
    }
    
    for (Edge edge : toRemove){
        edges.remove(edge);
    }
}

void checkForSelected(){
    for (Edge edge : edges){
        if (edge.MouseIsOver()){
            selected = edge;
            return;
        }
    }
    selected = null;
}

boolean checkVerticesForProximity(Vertex newvertex){
    int minDistance = MAX_INT;
    for (Vertex vertex : vertices){
        int toCheck = getDistanceBetweenVertices(newvertex, vertex);
        if (toCheck < minDistance){
            minDistance = toCheck;
        }
    }
    
    if (minDistance < minSeperation){
        return false;
    }
    return true;
}

int getDistanceBetweenVertices(Vertex vertex1, Vertex vertex2){
    int xDiff = Math.abs(vertex1.getX() - vertex2.getX());
    int yDiff = Math.abs(vertex1.getY() - vertex2.getY());
    
    return (int) Math.sqrt(Math.pow(xDiff, 2) + Math.pow(yDiff, 2));
}

Vertex getClosestvertex(Vertex inputvertex){
    Vertex toReturn = vertices.get(0);
    for (Vertex vertex : vertices){
        if (getDistanceBetweenVertices(inputvertex, vertex) < getDistanceBetweenVertices(inputvertex, toReturn) && vertex != inputvertex){
            toReturn = vertex;
        }
    }
    return toReturn;
}
