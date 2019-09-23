DoublePipes pipes;
DoublePipes pipes2;
Bird bird;

float pipes_xMod = 0;
float pipes2_xMod = 0;
int score = 0;
void setup()
{
  pipes = new DoublePipes(600.0,200.0,55.0);
  pipes2 = new DoublePipes(1000.0,400.0,55.0);
  bird = new Bird(100.0,200.0,30.0);
  size(800,800);
  textSize(32);
  score = 0;

  
}

void draw()
{
  if(!bird.isDead)
  {
    update();
  }
  else
  {
    reset();
    update();
  }
}

void reset()
{
  score = 0;
  pipes = new DoublePipes(600.0,200.0,55.0);
  pipes2 = new DoublePipes(1000.0,400.0,55.0);
  bird = new Bird(100.0,200.0,30.0);
  pipes_xMod = 0;
  pipes2_xMod = 0;
}

void update()
{
  
  background(80,200,255);
  pipes.drawPipes(pipes_xMod,150.0);
  pipes2.drawPipes(pipes2_xMod,150.0);
  bird.drawBird();
  fill(255);
  text(score,750,30);
  
  
  pipes_xMod += 4.0;
  pipes2_xMod += 4.0;
  
  pipes.checkOffscreen();
  pipes2.checkOffscreen();
  //collisionCheck(bird,pipes2,pipes2_xMod);
  //collisionCheck(bird,pipes,pipes_xMod);
  
  collisionCheck2();
  bottomCheck();
  //println();
  updatePipes();
  
  //xPos, yPos, pipeWidth, 
  //midpoint between (r1startingpoint + r1height) and
  //r2startingpoint
  //midpoint Y is 192.5
  
}

void updatePipes()
{
  if(pipes.isOffscreen)
  {
    pipes.isOffscreen = false;
    pipes_xMod = 0;
    score += 1;
    float r = random(100,700);
    
    pipes = new DoublePipes(800.0,r,55.0);
  }
  
  if(pipes2.isOffscreen)
  {
    pipes2.isOffscreen = false;
    pipes2_xMod = 0;
    score += 1;
    float r = random(100,700);
    
    pipes2 = new DoublePipes(800.0,r,55.0);
  }
}


void collisionCheck2()
{
  
  float radius = bird.birdWidth/2.0;
  /////
  float pipesL = pipes.xPos - pipes_xMod;
  float pipesR = pipes.xPos - pipes_xMod + pipes.pipeWidth;
  float pipesTopY = pipes.yPos - 75.5;
  float pipesBottomY = pipes.yPos + 75.5;
  /////
  float pipes2L = pipes2.xPos - pipes2_xMod;
  float pipes2R = pipes2.xPos - pipes2_xMod + pipes2.pipeWidth;
  float pipes2TopY = pipes2.yPos - 75.5;
  float pipes2BottomY = pipes2.yPos + 75.5;
  /////
  float birdX = bird.xPos;
  float birdY = bird.yPos;
  /////
  
    //println(bird.yPos);
  if (bird.yPos >= 800.0)
  {
    bird.isDead = true;
    println(bird.isDead);
  }
  
  if ((birdX + radius >= pipesL && birdX - radius <= pipesR && birdY - radius <= pipesTopY + 0.5) || 
  (birdX + radius >= pipesL && birdX - radius <= pipesR && birdY + radius >= pipesBottomY + radius + 4.5)) //not sure why 4.5 works but it does
  {
    bird.isDead = true;
    //println(b.isDead);
    println(birdY + radius);
    println(pipesBottomY + radius + 4.5);
  }
  else if((birdX + radius >= pipes2L && birdX - radius <= pipes2R && birdY - radius <= pipes2TopY + 0.5) || 
  (birdX + radius >= pipes2L && birdX - radius <= pipes2R && birdY + radius >= pipes2BottomY + radius + 4.5))
  {
    //println("this line called");
    bird.isDead = true;
    println(birdY + radius);
    println(pipes2BottomY + radius + 4.5);
  }
  else
  {
    bird.isDead = false;
  }
  
  
  
}

void bottomCheck()
{
  //println(bird.yPos);
  if (bird.yPos >= 800.0)
  {
    bird.isDead = true;
    //println("dead");
  }
}
