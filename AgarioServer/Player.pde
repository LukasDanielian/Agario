//REPRESENTS A COMPLETE PLAYER
class Player
{
  float r, g, b;
  int score, id;
  ArrayList<Part> parts;

  public Player(int id, float r, float g, float b, int score, ArrayList<Part> parts)
  {
    this.id = id;
    this.r = r;
    this.g = g;
    this.b = b;
    this.score = score;
    this.parts = parts;
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
  float x, y;

  public Part(float size, float x, float y)
  {
    partSize = size;
    this.x = x;
    this.y = y;
  }

  //RETURNS STRING REGARDING INFO ABOUT A PART
  String toString()
  {
    return partSize + "|" + x + "|" + y + "|";
  }
}
