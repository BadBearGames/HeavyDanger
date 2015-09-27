package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	
	public class squeakersBullet extends MovieClip
	{
		//Variables
		private var squeakersBulletSpeed:Number = 40;
		private var delay:Number = 1;
		public var damage:Number = document.squeakersDamage;
		public var tag:Number = 3;
		public var kick:Number = 3;
		
		public function squeakersBullet()
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
				damage -= 3;
			}
			
			if (kick > 0)
			{
				kick -= .5;
			}
			
			x = (x + Math.cos(rotation/180*Math.PI)* squeakersBulletSpeed);
			y = (y + Math.sin(rotation/180*Math.PI)* squeakersBulletSpeed);
		}
	}
	
}