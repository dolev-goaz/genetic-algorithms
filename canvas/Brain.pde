class Brain{
  PVector[] instructions;
  int step;
  float mutationRate;

  Brain(int size, float mutationRate){
    this.step=0;
    this.instructions= new PVector[size];
    randomize();
    this.mutationRate=mutationRate;
    }
//-------------------------------------------------------------------------------------    
  void randomize(){
      for(int i=0; i<instructions.length; i++){
        instructions[i]= PVector.fromAngle(random(2*PI));//random angle to move to
        }
    }
//-------------------------------------------------------------------------------------
  Brain copy(){
    Brain output= new Brain(this.instructions.length, this.mutationRate);
    for(int i=0; i<this.instructions.length; i++){
      output.instructions[i]=this.instructions[i];
      }
    return output;
    }
//-------------------------------------------------------------------------------------
  void mutate(){
    for(int i=0; i<this.instructions.length; i++){
      float rand= random(1);
      if (rand<this.mutationRate)
        this.instructions[i]= PVector.fromAngle(random(2*PI));// random movement
    }

  }
}
