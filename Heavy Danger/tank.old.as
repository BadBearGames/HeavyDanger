package  {
	
	import flash.display.MovieClip;
	
	
	public class tank extends MovieClip
	{
		public var tankCurrentWeapon:Number = 1;
		public var tankFireRate:Number = 0;
		
		public function tank() 
		{
			tankCurrentWeapon = 1;
		}
		
		public function updateTank():void
		{
			if (document.currentPlayer != 5) //IF NOT BEING CONTROLLED
			{
					
					if (tankFireRate > 0) //TAKE FIRE RATE TO 0
					{
						tankFireRate--;
					}
			}
		}
	}
	
}