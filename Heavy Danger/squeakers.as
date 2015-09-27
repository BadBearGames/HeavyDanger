package  {
	
	import flash.display.MovieClip;
	
	
	public class squeakers extends MovieClip
	{
		public var clip = 0;
		public var pistolClip = 0;
		public var squeakersCurrentWeapon:Number = 1;
		public var squeakersFireRate:Number = 0;
		public var reloadTimer:Number = -1;
		
		public function squeakers() 
		{
			reloadMain();
			reloadPistol();
		}
		
		public function reloadMain():void //MAIN AMMO RELOAD
		{
			if ((document.squeakersAmmo > document.squeakersAmmoCap) && (clip == 0))
			{
				clip += document.squeakersAmmoCap;
				document.squeakersAmmo -= document.squeakersAmmoCap;
			}
			else if (document.squeakersAmmo > (document.squeakersAmmoCap - clip))
			{
				document.squeakersAmmo -= (document.squeakersAmmoCap - clip);
				clip += (document.squeakersAmmoCap - clip);
			}
			else
			{
				clip += document.squeakersAmmo;
				document.squeakersAmmo = 0;
			}
		}
		
		public function reloadPistol():void //RELOAD PISTOL
		{
			/*if ((document.squeakersPistolAmmo > document.squeakersAmmoCap) && (pistolClip == 0))
			{
				pistolClip += document.pistolAmmoCap;
				document.squeakersPistolAmmo -= document.pistolAmmoCap;
			}*/
			if (document.squeakersPistolAmmo > (document.pistolAmmoCap - pistolClip))
			{
				document.squeakersPistolAmmo -= (document.pistolAmmoCap - pistolClip);
				pistolClip += (document.pistolAmmoCap - pistolClip);
			}
			else
			{
				pistolClip += document.squeakersPistolAmmo;
				document.squeakersPistolAmmo = 0;
			}
		}
		
		public function updateSqueakers():void
		{
			if (document.currentPlayer != 3) //IF NOT BEING CONTROLLED
			{
				//START RELOAD
				if ((squeakersCurrentWeapon == 1) && (clip == 0) && (reloadTimer == -1))
				{
					reloadTimer = document.squeakersReload;
				}
				else if ((squeakersCurrentWeapon == 2) && (pistolClip == 0) && (reloadTimer == -1))
				{
					reloadTimer = document.pistolReload;
				}
				else if (squeakersCurrentWeapon == 3) //CHANGE FROM ROCKET
				{
					squeakersCurrentWeapon = 1;
				}
				else
				{
					if (reloadTimer > 0) //RELOAD
					{
						reloadTimer--;
						if (reloadTimer == 0)
						{
							if (squeakersCurrentWeapon == 1)
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
					if ((squeakersCurrentWeapon == 1) && (document.squeakersAmmo == 0) && (clip == 0))
					{
						if ((document.squeakersPistolAmmo > 0) || (pistolClip > 0))
						{
							squeakersCurrentWeapon = 2;
							squeakersFireRate = 0;
						}
					}
					else if ((squeakersCurrentWeapon == 2) && ((document.squeakersAmmo > 0) || (clip > 0)))
					{
						if ((document.squeakersAmmo > 0) || (clip > 0))
						{
							squeakersCurrentWeapon = 1;
							squeakersFireRate = 0;
						}
					}
					
					
					
					if (squeakersFireRate > 0) //TAKE FIRE RATE TO 0
					{
						squeakersFireRate--;
					}
				}
			}
			else
			{
				squeakersCurrentWeapon = document.currentWeapon;
			}
		}
	}
	
}