package  
{
	
	import flash.display.MovieClip;
	
	
	public class enemyThree extends MovieClip 
	{
		public var targeted:Number;
		public var targetTimer:Number = 300;
		public var fireRate:Number = (Math.floor(Math.random() * (40 - 10 + 1)) + 10);
		public var hor:Number = 0;
		public var vert:Number = 0;
		public var inbounds:Boolean = false;
		public var tag:Boolean = false;
		
		public var health:Number = 2000;
		
		
		public function enemyThree() 
		{
			//SPAWN IN RANDOM POSITION
			{
				if ((Math.floor(Math.random() * (2 - 1 + 1)) + 1) == 2)
				{
					x = (Math.floor(Math.random() * (650 - (-10) + 1)) + (-10))
					if ((Math.floor(Math.random() * (2 - 1 + 1)) + 1) == 1)
					{
						y = -10;
					}
					else
					{
						y = 560;
					}
				}
				else
				{
					y = (Math.floor(Math.random() * (560 - (-10) + 1)) + (-10))
					if ((Math.floor(Math.random() * (2 - 1 + 1)) + 1) == 1)
					{
						x = -10;
					}
					else
					{
						x = 650;
					}
				}
			}
			
			targeted = 0;
		}
		
		
		public function updateEnemy(xt:Number, yt:Number)
		{
			if ((targeted != 0) && (health > 0) && (vert == 0) && (hor == 0))
			{
				{
				var c3y:Number = yt - (this.y);
				var c3x:Number = xt - this.x;
						
				// find out the angle
				var rotRadians3:Number = Math.atan2(c3y,c3x);
						
				// convert to degrees to rotate
				var rotDegrees3:Number = rotRadians3 * 180 / Math.PI;
				
				this.rotation = rotDegrees3 + 90;
				} //ROTATION
				
				if ((this.x < xt + 150) && (this.x > xt - 150) && (this.y < yt + 150) && (this.y > yt - 150))
				{
					if (fireRate > 0) //FIRE
					{
						fireRate--;
					}
					if (((this.x > xt + 80) || (this.x < xt - 80)) || ((this.y > yt + 80) || (this.y < yt - 80)))
					{
						//MOVE
						x = (x + Math.cos((rotation - 90)/180*Math.PI)* 1);
						y = (y + Math.sin((rotation - 90)/180*Math.PI)* 1);
					}
				}
				else
				{
					x = (x + Math.cos((rotation - 90)/180*Math.PI)* 1);
					y = (y + Math.sin((rotation - 90)/180*Math.PI)* 1);
				}
				
			}
			else //KNOCKED AROUND
			{
				if (vert != 0)
				{
					if (vert > 0)
					{
						vert -= .5;
						if (vert < 0)
						{
							vert = 0;
						}
					}
					else if (vert < 0)
					{
						vert += .5;
						if (vert > 0)
						{
							vert = 0;
						}
					}
				}
				
				if (hor != 0)
				{
					if (hor > 0)
					{
						hor -= .5;
						if (hor < 0)
						{
							hor = 0;
						}
					}
					else if (hor < 0)
					{
						hor += .5;
						if (hor > 0)
						{
							hor = 0;
						}
					}
				}
				
				this.x += hor;
				this.y += vert;
			}
			
			if (health < 0)
			{
				health = 0;
			}
			
			
			if ((this.x > 15) && (this.x < 625) && (this.y > 15) && (this.y < 465))
			{
				inbounds = true;
			}
			else
			{
				if (inbounds)
				{
					if (this.x < 15)
					{
						this.x = 15;
					}
					if (this.x > 625)
					{
						this.x = 625;
					}
					if (this.y < 15)
					{
						this.y = 15;
					}
					if (this.y > 465)
					{
						this.y = 465;
					}
				}
			}
		}
	}
	
}