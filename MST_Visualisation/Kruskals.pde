ArrayList<Edge> solution = new ArrayList();
ArrayList<ArrayList<Vertex>> trees = new ArrayList();

String iterateKruskals(){
        String instruction = "";
    
        if (edges.size() == 0){
            return "Completed";
        }
    
        Edge edge = getSmallestEdge();
        
        if (!checkForCycle(edge)){
            instruction = "Adding edge " + edge.getStart().label + "-" + edge.getEnd().label + " (Weight: " + edge.getWeight() + ") to solution.";
            solution.add(edge);
            edges.remove(edge);
        } else {
            instruction = "Tried to add edge " + edge.getStart().label + "-" + edge.getEnd().label + " (Weight: " + edge.getWeight() + ") to solution, but it formed a cycle.";
            edges.remove(edge);
        }
        
        getTrees();
        
        if (trees.get(0).size() == vertices.size()){
            edges.clear();
            return "All nodes found in minimum spanning tree, completed.";
        }
        
        return instruction;
}

Edge getSmallestEdge(){
    Edge min = edges.get(0);
    for (Edge edge : edges){
        if (min.getWeight() > edge.getWeight() && !solution.contains(edge)){
            min = edge;
        }
    }
    return min;
}

void getTrees(){   
    for (Edge edge : solution){
        Vertex start = edge.getStart();
        Vertex end = edge.getEnd();
        
        if (trees.size() == 0){
            trees.add(new ArrayList(Arrays.asList(start, end)));
            continue;
        }
        
        boolean cont = false;
        
        for (ArrayList<Vertex> tree : trees){
            if (tree.contains(start)){
                if (!tree.contains(end)){
                    tree.add(end);
                }
                cont = true;
                break;
            } else if (tree.contains(end)){
                if (!tree.contains(start)){
                    tree.add(start);
                }
                cont = true;
                break;
            }
        }
        
        if (cont){
            cont = false;
            continue;
        }
        
        trees.add(new ArrayList(Arrays.asList(start, end)));
    }
    
    ArrayList<Vertex> toDelete = new ArrayList();
    for (ArrayList<Vertex> tree : trees){
        for (ArrayList<Vertex> toCompare : trees){
            if (tree != toCompare){
                for (Vertex vertex : toCompare){
                    if (tree.contains(vertex)){
                        for (Vertex vertexAdd : toCompare){
                            if (vertexAdd != vertex && !tree.contains(vertexAdd)){
                                tree.add(vertexAdd);
                            }
                        }
                        toDelete = toCompare;
                    } 
                }
            }
        }
    }
    trees.remove(toDelete);
}

boolean checkForCycle(Edge edge){
    for (ArrayList<Vertex> tree : trees){
        if (tree.contains(edge.getStart()) && tree.contains(edge.getEnd())){
            return true;
        }
    }
    return false;
}

ArrayList<Vertex> getPossibleVertices(Vertex vertex, ArrayList<Edge> edges){
    ArrayList<Vertex> toReturn = new ArrayList();
    for (Edge edge : edges){
        if (edge.getStart() == vertex && !toReturn.contains(edge.getEnd())){
            toReturn.add(edge.getEnd());
        } else if (edge.getEnd() == vertex && !toReturn.contains(edge.getStart())){
            toReturn.add(edge.getStart());
        }
    }
    
    return toReturn;
}
