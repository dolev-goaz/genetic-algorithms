class Obstacle{
  int width;
  int height;
  PVector pos;
  Boolean rectangle;
  Obstacle(PVector pos, int width, int height, Boolean rectangle){
    this.pos=pos.copy();
    this.width=width;
    this.height=height;
    this.rectangle=rectangle;
    }
  void show(){
      fill(0,0,255);//blue
      if(rectangle)
        rect(pos.x,pos.y, width, height);
      else
        ellipse(pos.x,pos.y, width, height);
    }
  }
