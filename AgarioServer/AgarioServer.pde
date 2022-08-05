//IMPORTS
import processing.net.*;

//VARIABLES
Server server;
Player[] onlinePlayers;
int id;

void setup()
{
  //SETTINGS
  size(150, 150);
  background(0);
  frameRate(144);
  textAlign(CENTER, CENTER);

  //VARIABLE DECLARATIONS
  server = new Server(this, 1234);
  onlinePlayers  = new Player[10];
  id = 0;
}

void draw()
{
  //WINDOW EFFECTS
  fill(255);
  text("SERVER", width/2, height/2);

  //SENDS ALL PLAYER LOCATIONS
  for (int i = 0; i < onlinePlayers.length; i++)
  {
    if (onlinePlayers[i] != null)
    {
      Player temp = onlinePlayers[i];
      String partInfo = temp.toString();
      sendData("PlayerLoc", new String[]{temp.id + "", temp.r + "", temp.g + "", temp.b + "", temp.score + "", partInfo});
    }
  }
  
  //PLAYER COLLISION
  thread("checkCollision");
  checkCollision();

  //DATA
  thread("recieveData");
  recieveData();
}

//SENDS DATA TO CLIENT
void sendData(String type, String[] info)
{
  server.write(type + "/" + join(info, "/") + "\n");
}

//READS DATA FROM CLIENT
void recieveData()
{
  Client client = server.available();
  if (client != null && client.active())
  {
    String info = client.readString();
    info = info.substring(0, info.indexOf("\n"));
    if (info != null)
    {
      String[] args = split(info, "/");

      //WHEN NEW CLIENT JOINS SERVER
      if (args[0].equals("ClientConnect"))
      {
        ArrayList<Part> temp = new ArrayList<Part>();
        String[] partInfo = split(args[5], "|");
        for (int i = 0; i < partInfo.length -3; i+=3)
        {
          temp.add(new Part(float(partInfo[i]), float(partInfo[i+1]), float(partInfo[i+2])));
        }
        onlinePlayers[id] = new Player(id, float(args[1]), float(args[2]), float(args[3]), int(args[4]), temp);
        sendData("IDNum", new String[]{id + ""});
        id++;
      }
      
      //UPDATING PLAYER INFO
      if (args[0].equals("PlayerLoc") && onlinePlayers[int(args[1])] != null)
      {
        ArrayList<Part> temp = new ArrayList<Part>();
        String[] partInfo = split(args[6], "|");

        for (int i = 0; i < partInfo.length-1; i+=3)
        {
          temp.add(new Part(float(partInfo[i]), float(partInfo[i+1]), float(partInfo[i+2])));
        }
        onlinePlayers[int(args[1])].r = float(args[2]);
        onlinePlayers[int(args[1])].g = float(args[3]);
        onlinePlayers[int(args[1])].b = float(args[4]);
        onlinePlayers[int(args[1])].score = int(args[5]);
        onlinePlayers[int(args[1])].parts = temp;
      }
      //println(info);
    }
  }
}

//GIVES NEW CLIENTS AN ID
void serverEvent(Server s, Client c)
{
  println("New Connection: " + c.ip());
  c.write("IDNum/" + id + "/\n");
}
