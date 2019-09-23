Population test;
PVector goal = new PVector(400,10);
String msg = "No dot finished";

void setup()
{
  size(800,800);
  test = new Population(1000);
  
  println("Generation: 1");

}

void draw()
{
  //println(test.history.size());
  background(255);
  fill(255,0,0);
  ellipse(goal.x,goal.y,10,10);
  
  if(test.firstFinish)
  {
    test.findShortestPath();
    msg = "Shortest path: " + test.firstFinishPath;
  }

  
  
  if (test.allDotsDead())
  {
    
    
    println(msg);
    println("Generation: " + (test.gen + 1));
    
    test.calculateFitness();
    test.naturalSelection();
    test.mutateBabies();
  }
  
  
  
  test.update();
  test.show();
  //println(test.history.size());
}
