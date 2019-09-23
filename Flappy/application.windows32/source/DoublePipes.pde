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
  
  void drawPipes(float xMod, float distance)
  {
    xm = xMod;
    
    fill(60,255,30);
    rect(xPos - xMod,-20.0,pipeWidth,20.0 + yPos - (distance/2.0));
    rect(xPos - xMod,20.0+yPos+(distance/2.0),pipeWidth,1000.0);
  }
  
  void checkOffscreen()
  {
    if(xPos - xm <= (pipeWidth*-1.0))
    {
      isOffscreen = true;
    }
  }
}
