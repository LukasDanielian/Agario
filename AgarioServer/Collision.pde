//CHECKS COLLISION OF EVERY ONLINE PLAYER AND PART
void checkCollision()
{
  for (int i = 0; i < onlinePlayers.length; i++)
  {
    if (onlinePlayers[i] != null)
    {
      for (int j = 0; j < onlinePlayers.length; j++)
      {
        if (j != i && onlinePlayers[j] != null)
        {
          for (int iPart = 0; iPart < onlinePlayers[i].parts.size(); iPart++)
          {
            for (int jPart = 0; jPart < onlinePlayers[i].parts.size(); jPart++)
            {
              if (onlinePlayers[i].parts.size() > 0 && onlinePlayers[j].parts.size() > 0)
              {
                //CHECKS DISTANCE BETWEEN CELLS
                if (dist(onlinePlayers[i].parts.get(iPart).x, onlinePlayers[i].parts.get(iPart).y, onlinePlayers[j].parts.get(jPart).x, onlinePlayers[j].parts.get(jPart).y) <= onlinePlayers[i].parts.get(iPart).partSize/2 + onlinePlayers[j].parts.get(jPart).partSize/2)
                {
                  //iF I EATS J
                  if (onlinePlayers[i].parts.get(iPart).partSize > onlinePlayers[j].parts.get(jPart).partSize)
                  {
                    onlinePlayers[i].parts.get(iPart).partSize += onlinePlayers[j].parts.get(jPart).partSize;
                    onlinePlayers[j].parts.remove(jPart);
                    String partInfoI = onlinePlayers[i].toString();
                    String partInfoJ = onlinePlayers[j].toString();
                    sendData("PartEaten", new String[]{onlinePlayers[i].id + "", onlinePlayers[j].id + "", partInfoI, partInfoJ});
               
                    //IF J EATS I
                  } else if (onlinePlayers[j].parts.get(jPart).partSize > onlinePlayers[i].parts.get(iPart).partSize)
                  {
                    onlinePlayers[i].parts.get(iPart).partSize += onlinePlayers[j].parts.get(jPart).partSize;
                    onlinePlayers[j].parts.remove(jPart);
                    String partInfoI = onlinePlayers[i].toString();
                    String partInfoJ = onlinePlayers[j].toString();
                    sendData("PartEaten", new String[]{onlinePlayers[j].id + "", onlinePlayers[i].id + "", partInfoJ, partInfoI});
                  }
                }
              }
            }
          }
        }
      }
    }
  }
}
