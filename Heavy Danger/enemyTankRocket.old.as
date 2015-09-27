package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	
	public class enemyTankRocket extends MovieClip
	{
		//Variables
		private var enemyTankRocketSpeed:Number = 20;
		private var delay:Number = 2;
		public var damage:Number = 10;
		public var tag:Number = 0;
		public var kick:Number = 20;
		
		public function enemyTankRocket()
		{
			this.visible = false;
		}
		public function updateBullet():void
		{
			if (delay > 0)
			{
				this.visible = false;
				delay--;
			}
			else
			{
				this.visible = true;
			}
			enemyTankRocketSpeed *= 1.05;
			x = (x + Math.cos(rotation/180*Math.PI)* enemyTankRocketSpeed);
			y = (y + Math.sin(rotation/180*Math.PI)* enemyTankRocketSpeed);
		}
	}
	
}