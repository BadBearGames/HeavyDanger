package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	
	public class carlBullet extends MovieClip
	{
		//Variables
		private var carlBulletSpeed:Number = 70;
		private var delay:Number = 2;
		public var damage:Number = document.carlDamage;
		public var tag:Number = 2;
		public var kick:Number = 10;
		
		public function carlBullet()
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
			x = (x + Math.cos(rotation/180*Math.PI)* carlBulletSpeed);
			y = (y + Math.sin(rotation/180*Math.PI)* carlBulletSpeed);
		}
	}
	
}
