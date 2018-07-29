class Player extends Dot{
  PVector vel;//velocity
  PVector acc;//acceleration
  int steps;//steps player took
  int brainSize;
  Brain brain;
  Boolean alive=true;
  Boolean reachedGoal=false;
  Target target;
  double fitness;
  Boolean bestOne=false;
  Obstacle[] obstacles;

//-------------------------------------------------------------------------------------  
  Player(Target t, int brainSize, float mutationRate){
    super();
    this.brainSize=brainSize;
    fitness=0;
    this.target=t;
    steps=0;
    brain= new Brain(brainSize, mutationRate);
    this.vel= new PVector(0,0);
    this.acc= new PVector(0,0);
    }
//-------------------------------------------------------------------------------------    
  void show(){
    if (bestOne){
      fill (0,255,0);//green
      ellipse(pos.x,pos.y, 3*radius, 3*radius);
      }
    else{ 
      fill(0);//black
      ellipse(pos.x,pos.y,radius,radius);
      }
    }
//-------------------------------------------------------------------------------------    
  void move(){
    if (this.brain.instructions.length > this.brain.step){// get instruction from brain if possible
      this.acc=brain.instructions[brain.step];
      this.brain.step++;//next instruction
      }
    else this.alive=false;// ran out of instructions, died
    
    this.vel.add(this.acc);// move
    //this.vel.limit(10);
    this.pos.add(vel);
    steps++;
      }
//-------------------------------------------------------------------------------------
  void update(){
    if (this.alive && !reachedGoal){//if didnt reach target and alive
      if (dist(this.pos.x, this.pos.y, target.pos.x, target.pos.y)<target.radius-2)// if actually did reach the target
        reachedGoal=true;
      
      else// move
        move();
      checkCrash();
      
      }
    }
//-------------------------------------------------------------------------------------    
    void calculateFitness(Boolean someoneReached){
      float dist= dist(this.pos.x, this.pos.y, target.pos.x, target.pos.y);
      if (this.reachedGoal){
        this.fitness = pow(brain.step, -8) + pow(dist, -6);//inverse
        }
        else
          if (someoneReached)
            this.fitness= pow(dist, -6)*pow(2, -100);//punish
          else
            this.fitness= pow(dist, -6);// inverse
    }
//-------------------------------------------------------------------------------------
    Player copy(){
      Player baby= new Player(this.target, this.brainSize, this.brain.mutationRate);
      Brain babyBrain= this.brain.copy();
      baby.brain=babyBrain;
      return baby;
      }
//-------------------------------------------------------------------------------------
  void checkCrash(){
      if (this.pos.x < this.radius/2 || this.pos.x> width-radius/2 || this.pos.y<this.radius/2 || this.pos.y>height-radius/2){// out of bounds
        this.alive=false;
        return;
      }
      Obstacle temp;
      if (this.obstacles!=null)
        for(int i=0; i<this.obstacles.length; i++){
          temp=this.obstacles[i];
          if (temp!=null)
            if (this.pos.x-this.radius+2>temp.pos.x && temp.pos.x+temp.width>this.pos.x-this.radius+2 && this.pos.y-this.radius+2>temp.pos.y && temp.pos.y+temp.height>this.pos.y-radius+2){
                this.alive=false;
                if (bestOne) println("best died!");
                else println("normal died");
                return;
            }
        }
    }
  }
