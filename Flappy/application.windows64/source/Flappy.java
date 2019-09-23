import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class Flappy extends PApplet {

DoublePipes pipes;
DoublePipes pipes2;
Bird bird;

float pipes_xMod = 0;
float pipes2_xMod = 0;
int score = 0;
public void setup()
{
  pipes = new DoublePipes(600.0f,200.0f,55.0f);
  pipes2 = new DoublePipes(1000.0f,400.0f,55.0f);
  bird = new Bird(100.0f,200.0f,30.0f);
  
  textSize(32);
  score = 0;

  
}

public void draw()
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

public void reset()
{
  score = 0;
  pipes = new DoublePipes(600.0f,200.0f,55.0f);
  pipes2 = new DoublePipes(1000.0f,400.0f,55.0f);
  bird = new Bird(100.0f,200.0f,30.0f);
  pipes_xMod = 0;
  pipes2_xMod = 0;
}

public void update()
{
  
  background(80,200,255);
  pipes.drawPipes(pipes_xMod,150.0f);
  pipes2.drawPipes(pipes2_xMod,150.0f);
  bird.drawBird();
  fill(255);
  text(score,750,30);
  
  
  pipes_xMod += 4.0f;
  pipes2_xMod += 4.0f;
  
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

public void updatePipes()
{
  if(pipes.isOffscreen)
  {
    pipes.isOffscreen = false;
    pipes_xMod = 0;
    score += 1;
    float r = random(100,700);
    
    pipes = new DoublePipes(800.0f,r,55.0f);
  }
  
  if(pipes2.isOffscreen)
  {
    pipes2.isOffscreen = false;
    pipes2_xMod = 0;
    score += 1;
    float r = random(100,700);
    
    pipes2 = new DoublePipes(800.0f,r,55.0f);
  }
}


public void collisionCheck2()
{
  
  float radius = bird.birdWidth/2.0f;
  /////
  float pipesL = pipes.xPos - pipes_xMod;
  float pipesR = pipes.xPos - pipes_xMod + pipes.pipeWidth;
  float pipesTopY = pipes.yPos - 75.5f;
  float pipesBottomY = pipes.yPos + 75.5f;
  /////
  float pipes2L = pipes2.xPos - pipes2_xMod;
  float pipes2R = pipes2.xPos - pipes2_xMod + pipes2.pipeWidth;
  float pipes2TopY = pipes2.yPos - 75.5f;
  float pipes2BottomY = pipes2.yPos + 75.5f;
  /////
  float birdX = bird.xPos;
  float birdY = bird.yPos;
  /////
  
    //println(bird.yPos);
  if (bird.yPos >= 800.0f)
  {
    bird.isDead = true;
    println(bird.isDead);
  }
  
  if ((birdX + radius >= pipesL && birdX - radius <= pipesR && birdY - radius <= pipesTopY + 0.5f) || 
  (birdX + radius >= pipesL && birdX - radius <= pipesR && birdY + radius >= pipesBottomY + radius + 4.5f)) //not sure why 4.5 works but it does
  {
    bird.isDead = true;
    //println(b.isDead);
    println(birdY + radius);
    println(pipesBottomY + radius + 4.5f);
  }
  else if((birdX + radius >= pipes2L && birdX - radius <= pipes2R && birdY - radius <= pipes2TopY + 0.5f) || 
  (birdX + radius >= pipes2L && birdX - radius <= pipes2R && birdY + radius >= pipes2BottomY + radius + 4.5f))
  {
    //println("this line called");
    bird.isDead = true;
    println(birdY + radius);
    println(pipes2BottomY + radius + 4.5f);
  }
  else
  {
    bird.isDead = false;
  }
  
  
  
}

public void bottomCheck()
{
  //println(bird.yPos);
  if (bird.yPos >= 800.0f)
  {
    bird.isDead = true;
    //println("dead");
  }
}
class Bird
{
  float xPos, yPos = 0;
  float speed = 0;
  float birdWidth = 0;
  float gravity = 0.7f;
  boolean isDead = false;
  int col = color(255,255,0);
  
  Bird(float x, float y, float w)
  {
    xPos = x;
    yPos = y;
    birdWidth = w;
  }
  
  public void drawBird()
  {
    int yellow = color(255,255,0);
    setColor(yellow);
    
    fill(col);
    ellipse(xPos,yPos,birdWidth,birdWidth);
    yPos = yPos + speed;
    speed = speed + gravity;
    if (yPos > height)
    {
      //speed = -0.95 * speed;
      yPos = height;
    }
    else if (yPos < 0)
    {
      yPos = 0;
    }
    
    //jump
    if (key == 'a')
    {
      speed = -8;
      //aaaaaaaaaaaayPos = height;
      key = 'b';
      //speed = speed + gravity;
      //speed = 0;
    }
    
  }
  
  public void setColor(int c)
  {
    col = c;
  }
  
}
class DoublePipes
{
  float xPos, yPos = 0;
  float pipeWidth = 0;
  float xm = 0;
  boolean isOffscreen = false;
  
  DoublePipes(float x, float y, float w)
  {
    xPos = x;
    yPos = y;
    pipeWidth = w;
  }
  
  public void drawPipes(float xMod, float distance)
  {
    xm = xMod;
    
    fill(60,255,30);
    rect(xPos - xMod,-20.0f,pipeWidth,20.0f + yPos - (distance/2.0f));
    rect(xPos - xMod,20.0f+yPos+(distance/2.0f),pipeWidth,1000.0f);
  }
  
  public void checkOffscreen()
  {
    if(xPos - xm <= (pipeWidth*-1.0f))
    {
      isOffscreen = true;
    }
  }
}
  public void settings() {  size(800,800); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Flappy" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
