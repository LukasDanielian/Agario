void keyPressed()
{
  if(keyPressed)
  {
    if(key == ' ')
    {
      player.duplicate();
    }
    else if(key == 'e')
    {
      player.recombine();
    }
  }
}
