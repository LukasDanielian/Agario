//SENDS DATA TO SERVER
void sendData(String type, String[] info)
{
  client.write(type + "/" + join(info, "/") + "\n");
}

//READS DATA FROM SERVER
void clientEvent(Client client)
{
  if (client.available() > 0)
  {
    String info = client.readString();
    
    println(info);
    if (info != null)
    {
      info = info.substring(0, info.indexOf("\n"));
      String[] args = split(info, "/");
      //SETTING ID
      if (args[0].equals("IDNum"))
      {
        if (id == -1)
        {
          id = int(args[1]);
          String partInfo = player.toString();
          sendData("ClientConnect", new String[]{player.pR + "", player.pG + "", player.pB + "", player.score + "", partInfo});
        }
      }

      //STORE DATA FOR OTHER PLAYERS
      if (args[0].equals("PlayerLoc") && int(args[1]) != id)
      {
        ArrayList<Part> temp = getPartList(args[6]);
        onlinePlayers[int(args[1])] = new Player(float(args[2]), float(args[3]), float(args[4]), int(args[5]), temp);
      }

      //UPDATES PLAYERS PARTS AFTER COLLISION
      if (args[0].equals("PartEaten"))
      {
        ArrayList<Part> eater = getPartList(args[3]);
        ArrayList<Part> eaten = getPartList(args[4]);
        onlinePlayers[int(args[1])].parts = eater;
        onlinePlayers[int(args[2])].parts = eaten;
      }
    }
  }
}

//DECRIPTS PARTLIST DATA INTO ARRAYLIST
ArrayList<Part> getPartList(String data)
{
  ArrayList<Part> temp = new ArrayList<Part>();
  String[] partInfo = split(data, "|");
  for (int i = 0; i < partInfo.length -1; i+=3)
  {
    temp.add(new Part(float(partInfo[i]), float(partInfo[i+1]), float(partInfo[i+2])));
  }
  return temp;
}
