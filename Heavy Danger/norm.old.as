package  {
	
	import flash.display.MovieClip;
	
	
	public class norm extends MovieClip
	{
		public var clip = 0;
		public var pistolClip = 0;
		public var normCurrentWeapon:Number = 1;
		public var normFireRate:Number = 0;
		public var reloadTimer:Number = -1;
		
		public function norm() 
		{
			reloadMain();
			reloadPistol();
		}
		
		public function reloadMain():void //MAIN AMMO RELOAD
		{
			if ((document.normAmmo > document.normAmmoCap) && (clip == 0))
			{
				clip += document.normAmmoCap;
				document.normAmmo -= document.normAmmoCap;
			}
			else if (document.normAmmo > (document.normAmmoCap - clip))
			{
				document.normAmmo -= (document.normAmmoCap - clip);
				clip += (document.normAmmoCap - clip);
			}
			else
			{
				clip += document.normAmmo;
				document.normAmmo = 0;
			}
		}
		
		public function reloadPistol():void //RELOAD PISTOL
		{
			/*if ((document.normPistolAmmo > document.normAmmoCap) && (pistolClip == 0))
			{
				pistolClip += document.pistolAmmoCap;
				document.normPistolAmmo -= document.pistolAmmoCap;
			}*/
			if (document.normPistolAmmo > (document.pistolAmmoCap - pistolClip))
			{
				document.normPistolAmmo -= (document.pistolAmmoCap - pistolClip);
				pistolClip += (document.pistolAmmoCap - pistolClip);
			}
			else
			{
				pistolClip += document.normPistolAmmo;
				document.normPistolAmmo = 0;
			}
		}
		
		public function updateNorm():void
		{
			if (document.currentPlayer != 1) //IF NOT BEING CONTROLLED
			{
				//START RELOAD
				if ((normCurrentWeapon == 1) && (clip == 0) && (reloadTimer == -1))
				{
					reloadTimer = document.normReload;
				}
				else if ((normCurrentWeapon == 2) && (pistolClip == 0) && (reloadTimer == -1))
				{
					reloadTimer = document.pistolReload;
				}
				else if (normCurrentWeapon == 3) //CHANGE FROM ROCKET
				{
					normCurrentWeapon = 1;
				}
				else
				{
					if (reloadTimer > 0) //RELOAD
					{
						reloadTimer--;
						if (reloadTimer == 0)
						{
							if (normCurrentWeapon == 1)
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
					if ((normCurrentWeapon == 1) && (document.normAmmo == 0) && (clip == 0))
					{
						if ((document.normPistolAmmo > 0) || (pistolClip > 0))
						{
							normCurrentWeapon = 2;
							normFireRate = 0;
						}
					}
					else if ((normCurrentWeapon == 2) && ((document.normAmmo > 0) || (clip > 0)))
					{
						if ((document.normAmmo > 0) || (clip > 0))
						{
							normCurrentWeapon = 1;
							normFireRate = 0;
						}
					}
					
					
					
					if (normFireRate > 0) //TAKE FIRE RATE TO 0
					{
						normFireRate--;
					}
				}
			}
			else
			{
				normCurrentWeapon = document.currentWeapon;
			}
		}
	}
	
}
