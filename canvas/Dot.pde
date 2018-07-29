class Dot{
  PVector pos;
  int radius;
  Dot(){
    this.radius=4;
    this.pos= new PVector(width/2, 7*height/8);
    }
  Dot(PVector pos, int radius){
    this.radius=radius;
    this.pos= pos.copy();
    }


  }
