package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	
	public class enemyTwoBullet extends MovieClip
	{
		//Variables
		private var enemyTwoBulletSpeed:Number = 50;
		private var delay:Number = 2;
		public var damage:Number = 5;
		public var tag:Boolean = false;
		
		public function enemyTwoBullet()
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
			x = (x + Math.cos(rotation/180*Math.PI)* enemyTwoBulletSpeed);
			y = (y + Math.sin(rotation/180*Math.PI)* enemyTwoBulletSpeed);
		}
	}
	
}
