class Vertex{
    int x, y, label;
    int primsKey;
    
    Vertex(int x, int y, int label){
        this.label = label;
         this.x = x;
         this.y = y;
         
         primsKey = MAX_INT;
    }
    
    void Draw(){
        textSize(12);
        stroke(255);
        if (selected != null && (selected.getStart() == this || selected.getEnd() == this)){
            fill(0);
            ellipse(x, y, 25, 25);
            fill(255);
            text(label, x, y);
        } else {
            fill(255);
            ellipse(x, y, 20, 20);
            fill(0);
            text(label, x, y);
        }
        
        if (mstSet.contains(this)){
            fill(255,0,0);
            ellipse(x, y, 20, 20);
            fill(0);
            text(label, x, y);
        }
    }
    
    int getX(){
        return x;
    }
    
    int getY(){
        return y;
    }
    
    boolean MouseIsOver(){
        return getDistanceBetween(x, y, mouseX, mouseY) < 10;
    }
    
    float getDistanceBetween(int x, int y, int x2, int y2){
        return (float) Math.sqrt(Math.pow(x - x2, 2) + Math.pow(y - y2, 2));
    }
    
    void setKey(int primsKey){
        this.primsKey = primsKey;
    }
    
    int getKey(){
        return primsKey;
    }
}
