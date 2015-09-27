package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	
	public class tankRocket extends MovieClip
	{
		//Variables
		private var tankRocketSpeed:Number = 20;
		private var delay:Number = 2;
		public var damage:Number = 2000;
		public var tag:Number = 5;
		public var kick:Number = 10;
		
		public function tankRocket()
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
			tankRocketSpeed *= 1.05;
			x = (x + Math.cos(rotation/180*Math.PI)* tankRocketSpeed);
			y = (y + Math.sin(rotation/180*Math.PI)* tankRocketSpeed);
		}
	}
	
}