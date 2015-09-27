package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	
	public class enemyOneBullet extends MovieClip
	{
		//Variables
		private var enemyOneBulletSpeed:Number = 25;
		private var delay:Number = 1;
		public var damage:Number = 1;
		public var tag:Boolean = false;
		
		public function enemyOneBullet()
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
			x = (x + Math.cos(rotation/180*Math.PI)* enemyOneBulletSpeed);
			y = (y + Math.sin(rotation/180*Math.PI)* enemyOneBulletSpeed);
		}
	}
	
}
