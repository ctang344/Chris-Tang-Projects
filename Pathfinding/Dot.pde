class Dot
{
  PVector pos;
  PVector vel;
  PVector acc;
  Brain brain;
  boolean dead = false;
  ArrayList<PVector> history;
  
  float fitness = 0;
  boolean reachedGoal = false;
  boolean isBest = false;
  int maxSteps = 1000;

  Dot()
  {
    brain = new Brain(maxSteps);
    
    pos = new PVector(width/2,height-10);
    vel = new PVector(0,0);
    acc = new PVector(0,0);
    
    
    history = new ArrayList<PVector>();
  }


  void show()
  {
    
    if (isBest)
    {
      fill(0,255,0);
      ellipse(pos.x,pos.y,8,8);
    }
    else
    {
      
      fill(0);
      stroke(0);
      ellipse(pos.x,pos.y,4,4);
    }
    
    
    /*
    for (int i = 0; i < history.size()-1; i++)
    {
      PVector current = history.get(i);
      fill(0);
      stroke(0);
      ellipse(current.x,current.y,6,6);
    }
    */
    
  }
  
  void move()
  {
    if (brain.directions.length > brain.step)
    {
      acc = brain.directions[brain.step];
      brain.step++;
    }
    else
    {
      dead = true;
    }
    vel.add(acc);
    vel.limit(5);
    pos.add(vel);
    
    
    PVector v = new PVector(pos.x,pos.y);
    history.add(v);
    
    
  }
  
  void update()
  {
    if (!dead && !reachedGoal)
    {
      //println(test.history.size());
      move();
      if (pos.x<2 || pos.y<2 || pos.x > width-2 || pos.y > height-2)
      {
        dead = true;
      }
      else if (dist(pos.x,pos.y,goal.x,goal.y) < 5)
      {
        reachedGoal = true;
      }
    }
    
  }
  
  
  void calculateFitness()
  {
    if (reachedGoal)
    {
      fitness = 1.0/16.0 + 10000.0/(float)(brain.step*brain.step);
    }
    else
    {
      float distanceToGoal = dist(pos.x,pos.y,goal.x,goal.y);
    
      fitness = 1.0/(distanceToGoal*distanceToGoal);
    }
    
    
  }
  
  
  Dot getBaby()
  {
    Dot baby = new Dot();
    baby.brain = brain.clone();//babies have the same brain as their parents
    return baby;
  }
}
