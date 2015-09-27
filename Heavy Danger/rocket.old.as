package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	
	public class rocket extends MovieClip
	{
		//Variables
		private var rocketSpeed:Number = 7;
		private var delay:Number = 1;
		public var damage:Number = 5000;
		public var tag:Number = 0;
		public var kick:Number = 20;
		
		public function rocket()
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
			rocketSpeed *= 1.05;
			x = (x + Math.cos(rotation/180*Math.PI)* rocketSpeed);
			y = (y + Math.sin(rotation/180*Math.PI)* rocketSpeed);
		}
	}
	
}