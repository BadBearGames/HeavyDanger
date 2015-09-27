package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	
	public class normBullet extends MovieClip
	{
		//Variables
		private var normBulletSpeed:Number = 40;
		private var delay:Number = 1;
		public var damage:Number = document.normDamage;
		public var tag:Number = 1;
		public var kick:Number = 2;
		
		public function normBullet()
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
			x = (x + Math.cos(rotation/180*Math.PI)* normBulletSpeed);
			y = (y + Math.sin(rotation/180*Math.PI)* normBulletSpeed);
		}
	}
	
}
