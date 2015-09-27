package  {
	
	import flash.display.MovieClip;
	
	
	public class happy extends MovieClip
	{
		public var clip = 0;
		public var pistolClip = 0;
		public var happyCurrentWeapon:Number = 1;
		public var happyFireRate:Number = 0;
		public var reloadTimer:Number = -1;
		public var steps:Number = 0;
		
		public function happy() 
		{
			reloadMain();
			reloadPistol();
		}
		
		public function reloadMain():void //MAIN AMMO RELOAD
		{
			if ((document.happyAmmo > document.happyAmmoCap) && (clip == 0))
			{
				clip += document.happyAmmoCap;
				document.happyAmmo -= document.happyAmmoCap;
			}
			else if (document.happyAmmo > (document.happyAmmoCap - clip))
			{
				document.happyAmmo -= (document.happyAmmoCap - clip);
				clip += (document.happyAmmoCap - clip);
			}
			else
			{
				clip += document.happyAmmo;
				document.happyAmmo = 0;
			}
		}
		
		public function reloadPistol():void //RELOAD PISTOL
		{
			/*if ((document.happyPistolAmmo > document.happyAmmoCap) && (pistolClip == 0))
			{
				pistolClip += document.pistolAmmoCap;
				document.happyPistolAmmo -= document.pistolAmmoCap;
			}*/
			if (document.happyPistolAmmo > (document.pistolAmmoCap - pistolClip))
			{
				document.happyPistolAmmo -= (document.pistolAmmoCap - pistolClip);
				pistolClip += (document.pistolAmmoCap - pistolClip);
			}
			else
			{
				pistolClip += document.happyPistolAmmo;
				document.happyPistolAmmo = 0;
			}
		}
		
		public function updateHappy():void
		{
			if (document.currentPlayer != 4) //IF NOT BEING CONTROLLED
			{
				//START RELOAD
				if ((happyCurrentWeapon == 1) && (clip == 0) && (reloadTimer == -1))
				{
					reloadTimer = document.happyReload;
				}
				else if ((happyCurrentWeapon == 2) && (pistolClip == 0) && (reloadTimer == -1))
				{
					reloadTimer = document.pistolReload;
				}
				else if (happyCurrentWeapon == 3) //CHANGE FROM ROCKET
				{
					happyCurrentWeapon = 1;
				}
				else
				{
					if (reloadTimer > 0) //RELOAD
					{
						reloadTimer--;
						if (reloadTimer == 0)
						{
							if (happyCurrentWeapon == 1)
							{
								reloadMain();
							}
							else
							{
								reloadPistol();
							}
							reloadTimer = -1;
						}
					}
					
					//SWAP WEAPONS
					if ((happyCurrentWeapon == 1) && (document.happyAmmo == 0) && (clip == 0))
					{
						if ((document.happyPistolAmmo > 0) || (pistolClip > 0))
						{
							happyCurrentWeapon = 2;
							happyFireRate = 0;
						}
					}
					else if ((happyCurrentWeapon == 2) && ((document.happyAmmo > 0) || (clip > 0)))
					{
						if ((document.happyAmmo > 0) || (clip > 0))
						{
							happyCurrentWeapon = 1;
							happyFireRate = 0;
						}
					}
					
					
					
					if (happyFireRate > 0) //TAKE FIRE RATE TO 0
					{
						happyFireRate--;
					}
				}
				
				if (steps > 0)
				{
					steps--;
				}
			}
			else
			{
				happyCurrentWeapon = document.currentWeapon;
			}
		}
	}
	
}