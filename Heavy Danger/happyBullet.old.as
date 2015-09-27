package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	
	public class happyBullet extends MovieClip
	{
		//Variables
		private var happyBulletSpeed:Number = 50;
		private var delay:Number = 1;
		public var damage:Number = document.happyDamage;
		public var tag:Number = 4;
		public var kick:Number = 4;
		
		public function happyBullet()
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
			x = (x + Math.cos(rotation/180*Math.PI)* happyBulletSpeed);
			y = (y + Math.sin(rotation/180*Math.PI)* happyBulletSpeed);
		}
	}
	
}