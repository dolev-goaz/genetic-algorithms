class Target extends Dot{
  Target(PVector pos, int radius){
    super(pos, radius);
    }
  void show(){
    fill(255,0,0);
    ellipse(pos.x,pos.y,radius,radius);
    }

  }
