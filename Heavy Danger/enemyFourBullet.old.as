package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	
	public class enemyFourBullet extends MovieClip
	{
		//Variables
		private var enemyFourBulletSpeed:Number = 40;
		private var delay:Number = 1;
		public var damage:Number = 1;
		public var tag:Boolean = false;
		
		public function enemyFourBullet()
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
			x = (x + Math.cos(rotation/180*Math.PI)* enemyFourBulletSpeed);
			y = (y + Math.sin(rotation/180*Math.PI)* enemyFourBulletSpeed);
		}
	}
	
}
