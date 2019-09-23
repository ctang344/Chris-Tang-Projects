class Bird
{
  float xPos, yPos = 0;
  float speed = 0;
  float birdWidth = 0;
  float gravity = 0.7;
  boolean isDead = false;
  color col = color(255,255,0);
  
  Bird(float x, float y, float w)
  {
    xPos = x;
    yPos = y;
    birdWidth = w;
  }
  
  void drawBird()
  {
    color yellow = color(255,255,0);
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
  
  void setColor(color c)
  {
    col = c;
  }
  
}
