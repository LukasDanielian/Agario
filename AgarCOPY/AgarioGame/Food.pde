//REPRESENTS ONE SMALL CIRCLE
class Food
{
  float x, y, xMover, yMover, spawnX, spawnY, r, g, b, size, dist;
  PVector shoot;
  int bigOrSmall;

  public Food()
  {
    x = random(-mapSize, mapSize);
    y = random(-mapSize, mapSize);
    r = random(100, 255);
    g = random(100, 255);
    b = random(100, 255);
    size = 15;
  }
  
  //DRAWS ON SCREEN
  void render()
  {
    stroke(r-50, g-50, b-50);
    strokeWeight(5);
    fill(r, g, b);
    ellipse(x, y, size, size);

    x += xMover * .05;
    y += yMover * .05;

    if (dist(x, y, spawnX, spawnY) > dist)
    {
      xMover = 0;
      yMover = 0;
    }
  }
}
