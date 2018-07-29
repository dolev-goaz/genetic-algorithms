Population p;
Target t;
Obstacle[] obstacles;
String generation;
float mutationRate;
int minSteps;
int populationSize;
Boolean showBest;
Boolean show;
Boolean trail;
void setup(){
  size(1000,500);
  mutationRate=0.01;
  obstacles= new Obstacle[3];
  t = new Target(new PVector(width/2, height/6), 10);
  PVector middle = new PVector(width/3, 4*height/8);
  obstacles[0]= new Obstacle(middle, width/4, height/20, true);
//  obstacles[1]= new Obstacle(middle.add(width/4,-height/40), width/4, height/20, true);
//  obstacles[2]= new Obstacle(middle.add(-width/2,-height/40), width/4, height/20, true);
  minSteps = 100;
  populationSize = 5000;
  p = new Population(populationSize, t, minSteps, obstacles, mutationRate);
  showBest=false;
  show=true;
  trail=false;
  }
//-------------------------------------------------------------------------------------
void draw(){
  if (show){
    if (!trail)
      background(255);
    generation= "generation " + p.generation+"\nminimun steps- " + p.minSteps+"\nmutation rate- "+ p.population[0].brain.mutationRate*100+"%";
    if (showBest) generation+="\nshowing previous best";
    textSize(32);
    text(generation, 10,30);
    t.show();
  }
  if (p.done()){
    //time for a new generation
    p.calculateFitness();
    p.evolve();
    p.mutate();
    p.goalReached=false;//reset
    background(255);
    }
  if (show){
    if (showBest) p.population[0].show();
    else p.show();
    for(int i=0; i<obstacles.length; i++) if (obstacles[i]!=null) obstacles[i].show();
    }
    p.update();
  
  }
//-------------------------------------------------------------------------------------
void keyPressed(){
  switch(key){
    case 'b'://show best
      if (p.generation!=1)
        showBest=!showBest;
      if (showBest==false) trail=false;
      break;
    case 'd'://double mutation rate
      for (int i=0; i<p.population.length; i++)
        p.population[i].brain.mutationRate*=2;
      break;
    case 'h'://half mutation rate
      for (int i=0; i<p.population.length; i++)
        p.population[i].brain.mutationRate/=2;
      break;
    case 's'://stop drawing for faster computation
      show=!show;
      break;
    case 't':
      trail=!trail;
      break;
      
  }
  println("key");
}
  
