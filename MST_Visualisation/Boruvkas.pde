boolean init = false;
int i = 0;

String iterateBoruvkas(){    
    if (trees.size() == 1){
        edges.clear();
        return "Completed";
    }
    
    if (!init){
        if (i < vertices.size()){
            Edge cheapest = getCheapestEdge(vertices.get(i));
            if (!solution.contains(cheapest)){
                solution.add(cheapest);
                i++;
                return "Added edge: " + cheapest.getStart().label + "-" + cheapest.getEnd().label + " to the solution.";
            } else {
                i++;
                return "Tried to add edge: " + cheapest.getStart().label + "-" + cheapest.getEnd().label + ", but it was already in the solution.";
            }
        } else {
            getTrees();
            init = true;
            return "Connecting Trees."; 
        }
    } else {
        if(trees.size() > 1){
            for (ArrayList<Vertex> tree : trees){
                if (getCheapestEdge(tree) == null){
                    break;
                }
                else {
                    solution.add(getCheapestEdge(tree));
                }
            }
            getTrees();
        }
        return "Connecting Trees.";
    }
}

Edge getCheapestEdge(ArrayList<Vertex> tree){
    ArrayList<Edge> possibleEdges = new ArrayList();
    
    for (Vertex vert : tree){
        ArrayList<Vertex> possibleVerticesElement = getPossibleVertices(vert, edges);
        
        for (Vertex possible : possibleVerticesElement){
            if (!tree.contains(possible)){
                possibleEdges.add(getEdge(possible, vert));
            }
        }
    }
    
    int minWeight = MAX_INT;
    Edge min = null;
    for (Edge possibleEdge : possibleEdges){
        if (possibleEdge.getWeight() < minWeight){
            min = possibleEdge;
            minWeight = possibleEdge.getWeight();
        }
    }

    return min;
}

Edge getCheapestEdge(Vertex vert){
    ArrayList<Vertex> possibleVertices = getPossibleVertices(vert, edges);
    ArrayList<Edge> possibleEdges = new ArrayList();
    
    for (Vertex vertex : possibleVertices){
        possibleEdges.add(getEdge(vert, vertex));
    }
    
    int minWeight = MAX_INT;
    Edge min = null;
    for (Edge possibleEdge : possibleEdges){
        if (possibleEdge.getWeight() < minWeight){
            min = possibleEdge;
            minWeight = possibleEdge.getWeight();
        }
    }
    
    return min;
}
