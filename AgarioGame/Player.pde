//REPRESENTS A COMPLETE PLAYER
class Player
{
  float pR, pG, pB;
  int score;
  ArrayList<Part> parts = new ArrayList<Part>();

  public Player()
  {
    pR = random(100, 255);
    pG = random(100, 255);
    pB = random(100, 255);
    parts.add(new Part(100));
  }
  
  public Player(float pR, float pG, float pB, int score, ArrayList<Part> parts)
  {
    this.pR = pR;
    this.pG = pG;
    this.pB = pB;
    this.parts  = parts;
    this.score = score;
  }

  //RENDERS ALL PARTS OF PLAYER
  void render()
  {
    score = 0;
    for (int i = 0; i < parts.size(); i++)
    {
      parts.get(i).render(pR,pG,pB);
      score += parts.get(i).partSize;
    }
  }

  //SPLITS A PLAYER INTO DOUBLE PARTS
  void duplicate()
  {
    if (parts.size() < 8)
    {
      float amount = parts.size();
      for (int i = 0; i < amount; i++)
      {
        if (parts.get(i).partSize >= 50)
        {
          Part temp = parts.get(i);
          temp.partSize *= .5;
          parts.add(new Part(temp.partSize, temp.x, temp.y, mouseX - width/2 - temp.x, mouseY - height/2 - temp.y, dist(temp.x, temp.y, mouseX - width/2, mouseY - height/2)));
        }
      }
    }
  }

  //RECOMBINES ALL PARTS
  void recombine()
  {
    float totalSize = 0;
    for (int i = 0; i < parts.size(); i++)
    {
      totalSize += parts.get(i).partSize;
    }
    parts.clear();
    parts.add(new Part(totalSize));
  }

  //CHECKS IF ANY PART ATE FOOD
  boolean didEat(Food food)
  {
    for (int i = 0; i < parts.size(); i++)
    {
      if (dist(parts.get(i).x - centerX, parts.get(i).y - centerY, food.x, food.y) <= parts.get(i).partSize/2 + food.size/2)
      {
        parts.get(i).partSize += 1;
        if (scale > .25)
        {
          scale -= .001;
        }
        return true;
      }
    }
    return false;
  }
  
  //RETURNS STRING OF INFORMATION REGARDING ALL PARTS
  String toString()
  {
    String toReturn = "";
    for(int i = 0; i < parts.size(); i++)
    {
      toReturn += parts.get(i).toString();
    }
    return toReturn;
  }
}

//REPRESENTS ONE PART OF A PLAYER
  class Part
  {
    float partSize;
    float x, y, xMover, yMover;
    PVector dir;
    float spawnX, spawnY;
    float dist;

    public Part(float size)
    {
      partSize = size;
    }
    
    public Part(float partSize, float x, float y)
    {
      this.partSize = partSize;
      this.x = x;
      this.y = y;
    }
    
    public Part(float size, float x, float y, float xMover, float yMover, float dist)
    {
      partSize = size;
      this.x = x;
      this.y = y;
      this.xMover = xMover;
      this.yMover = yMover;
      spawnX = x;
      spawnY = y;
      this.dist = dist;
    }

    //RENDERS ONE PART
    void render(float pR, float pG, float pB)
    {
      fill(pR, pG, pB);
      strokeWeight(10);
      stroke(pR-50, pG-50, pB-50);
      ellipse(x, y, partSize, partSize);

      x += xMover * .05;
      y += yMover * .05;

      if (dist(x, y, spawnX, spawnY) > dist)
      {
        xMover = 0;
        yMover = 0;
      }
    }
    
    
    //RETURNS STRING REGARDING INFO ABOUT A PART
    String toString()
    {
      return partSize + "|" + (x - centerX) + "|" + (y - centerY) + "|";
    }
  }
