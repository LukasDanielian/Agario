//IMPORTS
import processing.net.*;

//GLOBAL VARIABLES
Client client;
Player player;
float mapSize;
float gridSize;
float centerX, centerY;
float scale;
ArrayList<Food> allFood = new ArrayList<Food>();
Player[] onlinePlayers = new Player[10];
int id = -1;

void setup()
{
  //SETTINGS
  //fullScreen();
  size(1920, 1080);
  rectMode(CENTER);
  shapeMode(CENTER);
  textAlign(CENTER, CENTER);
  frameRate(144);

  //VARIABLE DECLARATION
  client = new Client(this, "192.168.50.54", 1234);//SERVER IP
  player = new Player();
  mapSize = 5000;
  centerX = width/2;
  centerY = height/2;
  gridSize = 50;
  scale = 1;

  //STARTING FOOD
  for (int i = 0; i < 1000; i++)
  {
    allFood.add(new Food());
  }
}

void draw()
{
  //DATA
  clientEvent(client);
  String partInfo = player.toString();
  if (id != -1)
  {
    sendData("PlayerLoc", new String[]{id + "", player.pR + "", player.pG + "", player.pB + "", player.score + "", partInfo});
  }


  //BACKGROUND EFFECTS
  background(255);
  translate(width/2, height/2);
  scale(scale);

  //GRID AND BORDER
  noFill();
  strokeWeight(1);
  stroke(0);
  for (float row = centerX % gridSize - width; row < width + gridSize; row += gridSize)
  {
    for (float col = centerY % gridSize - height; col < height + gridSize; col += gridSize)
    {
      rect(row, col, gridSize, gridSize);
    }
  }
  stroke(255, 0, 0);
  strokeWeight(50);
  noFill();
  rect(centerX, centerY, mapSize * 2, mapSize * 2);


  //RENDER FOOD
  pushMatrix();
  translate(centerX, centerY);
  for (int i = 0; i < allFood.size(); i++)
  {
    allFood.get(i).render();
    if (player.didEat(allFood.get(i)))
    {
      allFood.remove(i);
      allFood.add(new Food());
    }
  }
  popMatrix();

  //ALL PLAYERS RENDER
  player.render();
  for (int i = 0; i < onlinePlayers.length; i++)
  {
    if(onlinePlayers[i] != null)
    {
      translate(centerX,centerY);
      onlinePlayers[i].render();
    }
  }

  //MOVEMENT
  centerX -= constrain((mouseX - width/2) * .01, -5, 5);
  centerY -= constrain((mouseY - height/2) * .01, -5, 5);
  checkBounds();

  //ON SCREEN VISUALS
  textSize(25);
  fill(0);
  noStroke();
  text("Points: " + (int)player.score, 0, height/2 - 25);
}

//CHECKS IF PLAYER IS IN BORDER
void checkBounds()
{
  //LEFT + RIGHT
  if (centerX <= -mapSize)
  {
    centerX = -mapSize;
  }
  if (centerX >= mapSize)
  {
    centerX = mapSize;
  }

  //UP + DOWN
  if (centerY >= mapSize)
  {
    centerY = mapSize;
  }
  if (centerY <= -mapSize)
  {
    centerY = -mapSize;
  }
}
