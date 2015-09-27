package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	
	public class enemyThreeBullet extends MovieClip
	{
		//Variables
		private var enemyThreeBulletSpeed:Number = 40;
		private var delay:Number = 1;
		public var damage:Number = 3;
		public var tag:Number = 3;
		public var kick:Number = 3;
		
		public function enemyThreeBullet()
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
			
			this.alpha -= .1;
			
			if (damage > 0)
			{
				damage -= 1;
			}
			else
			{
				damage = 0;
			}
			
			if (kick > 0)
			{
				kick -= .5;
			}
			
			x = (x + Math.cos(rotation/180*Math.PI)* enemyThreeBulletSpeed);
			y = (y + Math.sin(rotation/180*Math.PI)* enemyThreeBulletSpeed);
		}
	}
	
}