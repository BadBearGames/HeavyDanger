package  {
	
	import flash.display.MovieClip;
	
	
	public class carl extends MovieClip
	{
		public var clip = 0;
		public var pistolClip = 0;
		public var carlCurrentWeapon:Number = 1;
		public var carlFireRate:Number = 0;
		public var reloadTimer:Number = -1;
		
		public function carl() 
		{
			reloadMain();
			reloadPistol();
		}
		
		public function reloadMain():void //MAIN AMMO RELOAD
		{
			if ((document.carlAmmo > document.carlAmmoCap) && (clip == 0))
			{
				clip += document.carlAmmoCap;
				document.carlAmmo -= document.carlAmmoCap;
			}
			else if (document.carlAmmo > (document.carlAmmoCap - clip))
			{
				document.carlAmmo -= (document.carlAmmoCap - clip);
				clip += (document.carlAmmoCap - clip);
			}
			else
			{
				clip += document.carlAmmo;
				document.carlAmmo = 0;
			}
		}
		
		public function reloadPistol():void //RELOAD PISTOL
		{
			/*if ((document.carlPistolAmmo > document.carlAmmoCap) && (pistolClip == 0))
			{
				pistolClip += document.pistolAmmoCap;
				document.carlPistolAmmo -= document.pistolAmmoCap;
			}*/
			if (document.carlPistolAmmo > (document.pistolAmmoCap - pistolClip))
			{
				document.carlPistolAmmo -= (document.pistolAmmoCap - pistolClip);
				pistolClip += (document.pistolAmmoCap - pistolClip);
			}
			else
			{
				pistolClip += document.carlPistolAmmo;
				document.carlPistolAmmo = 0;
			}
		}
		
		public function updateCarl():void
		{
			if (document.currentPlayer != 2) //IF NOT BEING CONTROLLED
			{
				//START RELOAD
				if ((carlCurrentWeapon == 1) && (clip == 0) && (reloadTimer == -1))
				{
					reloadTimer = document.carlReload;
				}
				else if ((carlCurrentWeapon == 2) && (pistolClip == 0) && (reloadTimer == -1))
				{
					reloadTimer = document.pistolReload;
				}
				else if (carlCurrentWeapon == 3) //CHANGE FROM ROCKET
				{
					carlCurrentWeapon = 1;
				}
				else
				{
					if (reloadTimer > 0) //RELOAD
					{
						reloadTimer--;
						if (reloadTimer == 0)
						{
							if (carlCurrentWeapon == 1)
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
					if ((carlCurrentWeapon == 1) && (document.carlAmmo == 0) && (clip == 0))
					{
						if ((document.carlPistolAmmo > 0) || (pistolClip > 0))
						{
							carlCurrentWeapon = 2;
							carlFireRate = 0;
						}
					}
					else if ((carlCurrentWeapon == 2) && ((document.carlAmmo > 0) || (clip > 0)))
					{
						if ((document.carlAmmo > 0) || (clip > 0))
						{
							carlCurrentWeapon = 1;
							carlFireRate = 0;
						}
					}
					
					
					
					if (carlFireRate > 0) //TAKE FIRE RATE TO 0
					{
						carlFireRate--;
					}
				}
			}
			else
			{
				carlCurrentWeapon = document.currentWeapon;
			}
		}
	}
	
}