class Population{
  Player[] population;
  int brainSize;
  int generation;
  int minSteps;
  Boolean goalReached=false;
  Obstacle[] obstacles;
//-------------------------------------------------------------------------------------  
  Population(int size, Target t, int brainSize, Obstacle[] obstacles, float mutationRate){
    population= new Player[size];
    goalReached=false;
    minSteps=brainSize;
    this.obstacles=obstacles;
    for(int i=0; i<size; i++) {
      population[i]= new Player(t,brainSize, mutationRate);
      population[i].obstacles= obstacles;
    }
    generation=1;
  }
//-------------------------------------------------------------------------------------
  void show(){
    for(int i=0; i<population.length; i++)
        population[i].show();
  }
//-------------------------------------------------------------------------------------
  void update(){
    for(int i=0; i<population.length; i++){
      if (this.population[i].brain.step>minSteps)
        this.population[i].alive=false;
      if (population[i].reachedGoal) this.goalReached=true;
      population[i].update();
    }
  }
//-------------------------------------------------------------------------------------
  Boolean done(){
    for(int i=0; i<population.length; i++){
      if (population[i].alive && !population[i].reachedGoal)
        return false;
      }
      return true;
    }
//-------------------------------------------------------------------------------------
  void calculateFitness(){
    for(int i=0; i<population.length; i++){
      population[i].calculateFitness(goalReached);
      }
    }
//-------------------------------------------------------------------------------------
  float fitnessSum(){
    float output=0.0;
    for(int i=0; i<population.length; i++){
      output+=population[i].fitness;
      }
      return output;
    }
//-------------------------------------------------------------------------------------
  void evolve(){
    if (someoneFinished()) minStep();
    Player[] newPopulation= new Player[population.length];
    newPopulation[0]=champion().copy();
    newPopulation[0].bestOne=true;
    for(int i=1; i<newPopulation.length; i++){
      newPopulation[i]= pickParent().copy();
      newPopulation[i].obstacles=this.obstacles;
      }
      
    this.population=newPopulation;
    generation++;
    }
//-------------------------------------------------------------------------------------
  Player pickParent(){
    float rand= random(fitnessSum());
    float carrySum=0;// for probability
    for(int i=0; i<this.population.length; i++){
      carrySum+=this.population[i].fitness;
      if (rand<carrySum) 
        return this.population[i];
      }
    //will never get here
    return null;
    }
//-------------------------------------------------------------------------------------
  void mutate(){
  for(int i=1; i<this.population.length; i++){
    this.population[i].brain.mutate();
    }
  }
//-------------------------------------------------------------------------------------
  Player champion(){
    double max=0;//max fitness
    int maxIndex=0;
    for(int i=0; i<this.population.length; i++){
      if (this.population[i].fitness>max){
        max=this.population[i].fitness;
        maxIndex=i;
        }
      }
      return this.population[maxIndex];
    }
//-------------------------------------------------------------------------------------
  void minStep(){
    for(int i=0; i<this.population.length; i++){
      if (this.population[i].brain.step<this.minSteps && this.population[i].reachedGoal)
        this.minSteps= this.population[i].brain.step;
      }
      println(this.minSteps);
    }
//-------------------------------------------------------------------------------------
  Boolean someoneFinished(){
    for (int i=0; i<this.population.length; i++){
      if (this.population[i].reachedGoal) return true;
      }
      return false;
      
    }
}
