class Edge{
    Vertex start, end;
    color edgeColour;
    int weight;
    int midX, midY;
    
    Edge(Vertex start, Vertex end){
        this.start = start;
        this.end = end;
        
        edgeColour = color(random(100, 255), 0,random(100, 255));
        
        weight = getDistanceBetweenVertices(start, end);

        if (start.getX() < end.getX()){
            midX = start.getX() + ((end.getX() - start.getX())/2);
        } else {
            midX = end.getX() + ((start.getX() - end.getX())/2);
        }
        
        if (start.getY() < end.getY()){
            midY = start.getY() + ((end.getY() - start.getY())/2);
        } else {
            midY = end.getY() + ((start.getY() - end.getY())/2);
        }
    }
    
    void setWeight(int weightInp){
        this.weight = weightInp;
    }
    
    void Draw(){
        stroke(edgeColour);
        line(start.getX(), start.getY(), end.getX(), end.getY());
    }
    
    void DrawSolution(){
        strokeWeight(4);
        stroke(0,255,0);
        line(start.getX(), start.getY(), end.getX(), end.getY());
        strokeWeight(2);
    }
    
    void drawWeight(){
        textSize(12);
        if (!solution.contains(this)){
            stroke(edgeColour);
        } else {
            stroke(0,255,0);
        }
        
        fill(0, 150);
        rect(midX, midY, 40, 20);
        fill(255);
        text(weight, midX, midY);
    }
    
    boolean MouseIsOver(){
        if (mouseX > midX - 20 && mouseX < midX + 20 && mouseY > midY - 10 && mouseY < midY + 10){
            return true;
        }
        return false;
    }
    
    int getWeight(){
        return weight;
    }
    
    Vertex getStart(){
        return start;
    }
    
    Vertex getEnd(){
        return end;
    }
}
