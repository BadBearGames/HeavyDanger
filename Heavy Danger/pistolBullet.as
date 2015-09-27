package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	
	public class pistolBullet extends MovieClip
	{
		//Variables
		private var pistolBulletSpeed:Number = 60;
		private var delay:Number = 1;
		public var damage:Number = document.pistolDamage;
		public var tag:Number = 0;
		public var kick:Number = 3;
		
		public function pistolBullet()
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
			x = (x + Math.cos(rotation/180*Math.PI)* pistolBulletSpeed);
			y = (y + Math.sin(rotation/180*Math.PI)* pistolBulletSpeed);
		}
	}
	
}
