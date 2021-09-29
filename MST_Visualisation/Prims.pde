ArrayList<Vertex> mstSet = new ArrayList();

boolean firstVertexPicked = false;

String iteratePrims(){
    if (!firstVertexPicked){
        int rand = Math.round(random(0, vertices.size()-1));
        
        Vertex firstVertex = vertices.get(rand);
        
        firstVertex.setKey(0);
        
        firstVertexPicked = true;
    }
    
    if (mstSet.size() != vertices.size()){
        Vertex min = getMinKey();
        
        Edge addedEdge = null;
        for (Vertex vertex : mstSet){
            addedEdge = getEdge(vertex, min);
            if (addedEdge != null){
                if (addedEdge.getWeight() == min.getKey()){
                    solution.add(addedEdge);
                    edges.remove(addedEdge);
                    break;
                }
            }
        }
        
        mstSet.add(min);
        
        ArrayList<Vertex> possibleVertices = getPossibleVertices(min, edges);
        
        for (Vertex vertex : possibleVertices){
            if (!mstSet.contains(vertex)){
                if (getEdge(min, vertex).getWeight() < vertex.getKey()){
                    vertex.setKey(getEdge(min, vertex).getWeight());
                }
            }
        }
        
        if (addedEdge == null){
            return "Added vertex " + min.label + " to main set.";
        } else {
            return "Added vertex " + min.label + " to main set, also added edge " + addedEdge.getStart().label + "-" + addedEdge.getEnd().label + " (Weight: " + addedEdge.getWeight() + ") to the solution.";
        }
    } else {
        edges.clear();
        mstSet.clear();
        return "Completed";
    }
}

Edge getEdge(Vertex vert1, Vertex vert2){
    for (Edge edge : edges){
        if (vert1 == edge.getStart() || vert1 == edge.getEnd()){
            if (vert2 == edge.getStart() || vert2 == edge.getEnd()){
                return edge;
            }
        }
    }
    return null;
}

Vertex getMinKey(){
    Vertex toReturn = null;
    
    int minKey = MAX_INT;
    
    for (Vertex vertex : vertices){
        if (vertex.getKey() < minKey && !mstSet.contains(vertex)){
            toReturn = vertex;
            minKey = vertex.getKey();
        }
    }
    
    return toReturn;
}
