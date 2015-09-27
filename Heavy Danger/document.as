package  
{
	
	import flash.display.MovieClip;
	import flash.net.SharedObject;
	import flash.net.LocalConnection;
	import flash.system.System;
	
	
	public class document extends MovieClip 
	{
		//MAIN VARS
		public static var init:Boolean = true;
		public static var newG:Boolean = false;
		public static var mute:Boolean = false;
		public static var currentWeapon:Number = 1;
		public static var currentPlayer:Number = 1;
		public static var currentWave:Number = 0;
		public static var score:Number = 0;
		public static var bodyCount:Number = 0;
		public var saveData:SharedObject;
		
		//API
		var GameID;
		var sessid;
		
		//OTHER VARS
		
		{
		public static var normAccel:Number = .5;
		public static var normSpeed:Number = 3;
		public static var normAccHigh:Number = 130;
		public static var normAccLow:Number = 30;
		public static var normAccRise:Number = 20;
		public static var normAccFall:Number = 5;
		public static var normAmmo:Number = 500;
		public static var normPistolAmmo:Number = 20;
		public static var normAmmoCap:Number = 30;
		public static var normHealth:Number = 100;
		public static var normHealthCap:Number = 100;
		public static var normReload:Number = 75;
		public static var normFireRate:Number = 2;
		public static var normDamage:Number = 10;
		} //NORM
		
		{
		public static var carlAccel:Number = .5;
		public static var carlSpeed:Number = 4;
		public static var carlAccHigh:Number = 200;
		public static var carlAccLow:Number = 40;
		public static var carlAccRise:Number = 100;
		public static var carlAccFall:Number = 2;
		public static var carlAmmo:Number = 50;
		public static var carlPistolAmmo:Number = 20;
		public static var carlAmmoCap:Number = 2;
		public static var carlHealth:Number = 100;
		public static var carlHealthCap:Number = 100;
		public static var carlReload:Number = 90;
		public static var carlFireRate:Number = 10;
		public static var carlDamage:Number = 120;
		} //CARL
		
		{
		public static var squeakersAccel:Number = .5;
		public static var squeakersSpeed:Number = 10;
		public static var squeakersAccHigh:Number = 200;
		public static var squeakersAccLow:Number = 100;
		public static var squeakersAccRise:Number = 50;
		public static var squeakersAccFall:Number = 5;
		public static var squeakersAmmo:Number = 70;
		public static var squeakersPistolAmmo:Number = 20;
		public static var squeakersAmmoCap:Number = 4;
		public static var squeakersHealth:Number = 100;
		public static var squeakersHealthCap:Number = 100;
		public static var squeakersReload:Number = 50;
		public static var squeakersFireRate:Number = 6;
		public static var squeakersDamage:Number = 30;
		} //SQUEAKERS
		
		{
		public static var happyAccel:Number = .5;
		public static var happySpeed:Number = 1.5;
		public static var happyAccHigh:Number = 240;
		public static var happyAccLow:Number = 40;
		public static var happyAccRise:Number = 40;
		public static var happyAccFall:Number = 5;
		public static var happyAmmo:Number = 900;
		public static var happyPistolAmmo:Number = 20;
		public static var happyAmmoCap:Number = 80;
		public static var happyHealth:Number = 130;
		public static var happyHealthCap:Number = 130;
		public static var happyReload:Number = 120;
		public static var happyFireRate:Number = 5;
		public static var happyDamage:Number = 25;
		} //HAPPY
		
		{
		public static var tankSpeed:Number = 1.15;
		public static var tankHealth:Number = 0;
		public static var tankFireRate:Number = 60;
		} //TANK
		
		{
		public static var pistolAccHigh:Number = 50;
		public static var pistolAccLow:Number = 20;
		public static var pistolAccRise:Number = 10;
		public static var pistolAccFall:Number = 2;
		public static var pistolAmmoCap:Number = 6;
		public static var pistolReload:Number = 30;
		public static var pistolDamage:Number = 15;
		public static var pistolsUnlocked:Boolean = false;
		} //PISTOL
		
		{
		public static var rocketAccHigh:Number = 30;
		public static var rocketAccLow:Number = 10;
		public static var rocketAccRise:Number = 10;
		public static var rocketAccFall:Number = 5;
		public static var rocketAmmo:Number = 5;
		public static var rocketsUnlocked:Boolean = false;
		} //ROCKET
		
		{
			public static var enemiesOneAcc:Number = 200;
		} //ENEMIES
		
		{
			public static var normX:Number = 309;
			public static var normY:Number = 161;
			public static var carlX:Number = 320;
			public static var carlY:Number = 240;
			public static var squeakersX:Number = 424;
			public static var squeakersY:Number = 157;
			public static var happyX:Number = 196;
			public static var happyY:Number = 143;
			public static var tankX:Number = 320;
			public static var tankY:Number = 344;
		} //OTHER
		
		{
			public static var normDead:Boolean = false;
			public static var carlDead:Boolean = false;
			public static var happyDead:Boolean = false;
			public static var squeakersDead:Boolean = false;
		} //DEATH VARS
		
		{
			public static var tut5Switch:Boolean = false;
			public static var tut6Switch:Boolean = false;
			public static var tut7Switch:Boolean = false;
		} //TUT SWITCHES
		
		public function document() 
		{
			//SAVE DATA--
			saveData = SharedObject.getLocal("HeavyDangerSaveData");
			
			saveData.clear();
			
			if (saveData.data.currentWave == null)
			{
				//MAIN VARS
				{
				saveData.data.currentPlayerD = 2;
				saveData.data.currentWaveD = 0;
				saveData.data.scoreD = 0;
				}
				
				{
				saveData.data.normSpeedD = 3;
				saveData.data.normAccHighD= 130;
				saveData.data.normAccLowD = 30;
				saveData.data.normAccRiseD = 20;
				saveData.data.normAccFallD= 5;
				saveData.data.normAmmoD = 360;
				saveData.data.normPistolAmmoD = 0;
				saveData.data.normAmmoCapD = 30;
				saveData.data.normHealthD = 100;
				saveData.data.normHealthCapD = 100;
				saveData.data.normReloadD = 75;
				saveData.data.normDamageD = 10;
				} //NORM
		
				{
				saveData.data.carlSpeedD = 4;
				saveData.data.carlAccHighD= 200;
				saveData.data.carlAccLowD = 40;
				saveData.data.carlAccRiseD = 100;
				saveData.data.carlAccFallD= 2;
				saveData.data.carlAmmoD = 24;
				saveData.data.carlPistolAmmoD = 0;
				saveData.data.carlAmmoCapD = 2;
				saveData.data.carlHealthD = 100;
				saveData.data.carlHealthCapD = 100;
				saveData.data.carlReloadD = 90;
				saveData.data.carlDamageD = 120;
				} //CARL
				
				{
				saveData.data.squeakersSpeedD = 10;
				saveData.data.squeakersAccHighD= 200;
				saveData.data.squeakersAccLowD = 100;
				saveData.data.squeakersAccRiseD = 50;
				saveData.data.squeakersAccFallD= 5;
				saveData.data.squeakersAmmoD = 48;
				saveData.data.squeakersPistolAmmoD = 0;
				saveData.data.squeakersAmmoCapD = 4;
				saveData.data.squeakersHealthD = 100;
				saveData.data.squeakersHealthCapD = 100;
				saveData.data.squeakersReloadD = 50;
				saveData.data.squeakersDamageD = 30;
				} //SQUEAKERS
				
				{
				saveData.data.happySpeedD = 1.5;
				saveData.data.happyAccHighD= 240;
				saveData.data.happyAccLowD = 40;
				saveData.data.happyAccRiseD = 40;
				saveData.data.happyAccFallD= 5;
				saveData.data.happyAmmoD = 960;
				saveData.data.happyPistolAmmoD = 0;
				saveData.data.happyAmmoCapD = 80;
				saveData.data.happyHealthD = 130;
				saveData.data.happyHealthCapD = 130;
				saveData.data.happyReloadD = 120;
				saveData.data.happyDamageD = 25;
				} //HAPPY
				
				{
				saveData.data.tankHealthD = 0;
				} //TANK
				
				{
				saveData.data.pistolDamageD = 15;
				saveData.data.pistolsUnlockedD= false;
				} //PISTOL
				
				{
				saveData.data.rocketAmmoD= 0;
				saveData.data.rocketsUnlockedD = false;
				} //ROCKET
				
				{
					saveData.data.normDeadD = false;
					saveData.data.carlDeadD = false;
					saveData.data.squeakersDeadD = false;
					saveData.data.happyDeadD = false;
				} //DEATH VARS
				
				{
					saveData.data.tut5SwitchD = false;
					saveData.data.tut6SwitchD = false;
					saveData.data.tut7SwitchD = false;
				} //TUT SWITCHES
				
				saveData.flush();
				
				newG = true;
			}
			//--
			
			//SET VARS
			setVarstoData();
			
		}
		
		public function newGame():void //CREATES A NEW GAME
		{
			//MAIN VARS
				{
				saveData.data.currentPlayerD = 2;
				saveData.data.currentWaveD = 0;
				saveData.data.scoreD = 0;
				}
				
				{
				saveData.data.normSpeedD = 3;
				saveData.data.normAccHighD= 80; //130
				saveData.data.normAccLowD = 30;
				saveData.data.normAccRiseD = 8;
				saveData.data.normAccFallD= 5;
				saveData.data.normAmmoD = 360;
				saveData.data.normPistolAmmoD = 0;
				saveData.data.normAmmoCapD = 30;
				saveData.data.normHealthD = 100;
				saveData.data.normHealthCapD = 100;
				saveData.data.normReloadD = 75;
				saveData.data.normDamageD = 15; //10
				} //NORM
		
				{
				saveData.data.carlSpeedD = 4;
				saveData.data.carlAccHighD= 200;
				saveData.data.carlAccLowD = 40;
				saveData.data.carlAccRiseD = 100;
				saveData.data.carlAccFallD= 2;
				saveData.data.carlAmmoD = 24;
				saveData.data.carlPistolAmmoD = 0;
				saveData.data.carlAmmoCapD = 2;
				saveData.data.carlHealthD = 100;
				saveData.data.carlHealthCapD = 100;
				saveData.data.carlReloadD = 90;
				saveData.data.carlDamageD = 120;
				} //CARL
				
				{
				saveData.data.squeakersSpeedD = 10;
				saveData.data.squeakersAccHighD= 160; //200
				saveData.data.squeakersAccLowD = 100;
				saveData.data.squeakersAccRiseD = 50;
				saveData.data.squeakersAccFallD= 5;
				saveData.data.squeakersAmmoD = 48;
				saveData.data.squeakersPistolAmmoD = 0;
				saveData.data.squeakersAmmoCapD = 4;
				saveData.data.squeakersHealthD = 100;
				saveData.data.squeakersHealthCapD = 100;
				saveData.data.squeakersReloadD = 50;
				saveData.data.squeakersDamageD = 30;
				} //SQUEAKERS
				
				{
				saveData.data.happySpeedD = 1.5;
				saveData.data.happyAccHighD= 180; //240
				saveData.data.happyAccLowD = 40;
				saveData.data.happyAccRiseD = 10; //40
				saveData.data.happyAccFallD= 5;
				saveData.data.happyAmmoD = 960;
				saveData.data.happyPistolAmmoD = 0;
				saveData.data.happyAmmoCapD = 80;
				saveData.data.happyHealthD = 130;
				saveData.data.happyHealthCapD = 130;
				saveData.data.happyReloadD = 120;
				saveData.data.happyDamageD = 30; //25
				} //HAPPY
				
				{
				saveData.data.tankHealthD = 0;
				} //TANK
				
				{
				saveData.data.pistolDamageD = 15;
				saveData.data.pistolsUnlockedD= false;
				} //PISTOL
				
				{
				saveData.data.rocketAmmoD= 0;
				saveData.data.rocketsUnlockedD = false;
				} //ROCKET
				
				saveData.data.normDeadD = false;
				saveData.data.carlDeadD = false;
				saveData.data.squeakersDeadD = false;
				saveData.data.happyDeadD = false;
				
				{
					saveData.data.tut5SwitchD = false;
					saveData.data.tut6SwitchD = false;
					saveData.data.tut7SwitchD = false;
				} //TUT SWITCHES
				
				normX = 309;
				normY = 161;
				carlX = 320;
				carlY = 240;
				squeakersX = 424;
				squeakersY = 157;
				happyX = 196;
				happyY = 143;
				tankX = 320;
				tankY = 344;
				
				
				saveData.flush();
				
				newG = true;
				
				setVarstoData();
		}
		
		public function saveGame():void //SAVES THE GAME
		{
			//MAIN VARS
				{
				saveData.data.currentPlayerD = currentPlayer;
				saveData.data.currentWaveD = currentWave;
				saveData.data.scoreD = score;
				}
				
				{
				saveData.data.normSpeedD = normSpeed;
				saveData.data.normAccHighD = normAccHigh;
				saveData.data.normAccLowD = normAccLow;
				saveData.data.normAccRiseD = normAccRise;
				saveData.data.normAccFallD = normAccFall;
				saveData.data.normAmmoD = normAmmo;
				saveData.data.normPistolAmmoD = normPistolAmmo;
				saveData.data.normAmmoCapD = normAmmoCap;
				saveData.data.normHealthD = normHealth;
				saveData.data.normHealthCapD = normHealthCap;
				saveData.data.normReloadD = normReload;
				saveData.data.normDamageD = normDamage;
				} //NORM
		
				{
				saveData.data.carlSpeedD = carlSpeed;
				saveData.data.carlAccHighD = carlAccHigh;
				saveData.data.carlAccLowD = carlAccLow;
				saveData.data.carlAccRiseD = carlAccRise;
				saveData.data.carlAccFallD = carlAccFall;
				saveData.data.carlAmmoD = carlAmmo;
				saveData.data.carlPistolAmmoD = carlPistolAmmo;
				saveData.data.carlAmmoCapD = carlAmmoCap;
				saveData.data.carlHealthD = carlHealth;
				saveData.data.carlHealthCapD = carlHealthCap;
				saveData.data.carlReloadD = carlReload;
				saveData.data.carlDamageD = carlDamage;
				} //CARL
				
				{
				saveData.data.squeakersSpeedD = squeakersSpeed;
				saveData.data.squeakersAccHighD = squeakersAccHigh;
				saveData.data.squeakersAccLowD = squeakersAccLow;
				saveData.data.squeakersAccRiseD = squeakersAccRise;
				saveData.data.squeakersAccFallD = squeakersAccFall;
				saveData.data.squeakersAmmoD = squeakersAmmo;
				saveData.data.squeakersPistolAmmoD = squeakersPistolAmmo;
				saveData.data.squeakersAmmoCapD = squeakersAmmoCap;
				saveData.data.squeakersHealthD = squeakersHealth;
				saveData.data.squeakersHealthCapD = squeakersHealthCap;
				saveData.data.squeakersReloadD = squeakersReload;
				saveData.data.squeakersDamageD = squeakersDamage;
				} //SQUEAKERS
				
				{
				saveData.data.happySpeedD = happySpeed;
				saveData.data.happyAccHighD = happyAccHigh;
				saveData.data.happyAccLowD = happyAccLow;
				saveData.data.happyAccRiseD = happyAccRise;
				saveData.data.happyAccFallD = happyAccFall;
				saveData.data.happyAmmoD = happyAmmo;
				saveData.data.happyPistolAmmoD = happyPistolAmmo;
				saveData.data.happyAmmoCapD = happyAmmoCap;
				saveData.data.happyHealthD = happyHealth;
				saveData.data.happyHealthCapD = happyHealthCap;
				saveData.data.happyReloadD = happyReload;
				saveData.data.happyDamageD = happyDamage;
				} //HAPPY
				
				{
				saveData.data.tankHealthD = tankHealth;
				} //TANK
				
				{
				saveData.data.pistolDamageD = pistolDamage;
				saveData.data.pistolsUnlockedD = pistolsUnlocked;
				} //PISTOL
				
				{
				saveData.data.rocketAmmoD = rocketAmmo;
				saveData.data.rocketsUnlockedD = rocketsUnlocked;
				} //ROCKET
				
				{
				saveData.data.normDeadD = normDead;
				saveData.data.carlDeadD = carlDead;
				saveData.data.squeakersDeadD = squeakersDead;
				saveData.data.happyDeadD = happyDead;
				}
				
				{
					saveData.data.tut5SwitchD = tut5Switch;
					saveData.data.tut6SwitchD = tut6Switch;
					saveData.data.tut7SwitchD = tut7Switch;
				} //TUT SWITCHES
				
				saveData.flush();
		}
		
		public function setVarstoData():void //SETS VARS EQUAL TO SAVE DATA
		{
			//MAIN VARS
				{
				currentPlayer = saveData.data.currentPlayerD;
				currentWave =  saveData.data.currentWaveD;
				score = saveData.data.scoreD;
				}
				
				{
				normSpeed = saveData.data.normSpeedD;
				normAccHigh = saveData.data.normAccHighD;
				normAccLow = saveData.data.normAccLowD;
				normAccRise = saveData.data.normAccRiseD;
				normAccFall = saveData.data.normAccFallD;
				normAmmo = saveData.data.normAmmoD;
				normPistolAmmo = saveData.data.normPistolAmmoD;
				normAmmoCap = saveData.data.normAmmoCapD;
				normHealth = saveData.data.normHealthD;
				normHealthCap = saveData.data.normHealthCapD;
				normReload = saveData.data.normReloadD;
				normDamage = saveData.data.normDamageD;
				} //NORM
		
				{
				carlSpeed = saveData.data.carlSpeedD;
				carlAccHigh = saveData.data.carlAccHighD;
				carlAccLow = saveData.data.carlAccLowD;
				carlAccRise = saveData.data.carlAccRiseD;
				carlAccFall = saveData.data.carlAccFallD;
				carlAmmo = saveData.data.carlAmmoD;
				carlPistolAmmo = saveData.data.carlPistolAmmoD;
				carlAmmoCap = saveData.data.carlAmmoCapD;
				carlHealth = saveData.data.carlHealthD;
				carlHealthCap = saveData.data.carlHealthCapD;
				carlReload = saveData.data.carlReloadD;
				carlDamage = saveData.data.carlDamageD;
				} //CARL
				
				{
				squeakersSpeed = saveData.data.squeakersSpeedD;
				squeakersAccHigh = saveData.data.squeakersAccHighD;
				squeakersAccLow = saveData.data.squeakersAccLowD;
				squeakersAccRise = saveData.data.squeakersAccRiseD;
				squeakersAccFall = saveData.data.squeakersAccFallD;
				squeakersAmmo = saveData.data.squeakersAmmoD;
				squeakersPistolAmmo = saveData.data.squeakersPistolAmmoD;
				squeakersAmmoCap = saveData.data.squeakersAmmoCapD;
				squeakersHealth = saveData.data.squeakersHealthD;
				squeakersHealthCap = saveData.data.squeakersHealthCapD;
				squeakersReload = saveData.data.squeakersReloadD;
				squeakersDamage = saveData.data.squeakersDamageD;
				} //SQUEAKERS
				
				{
				happySpeed = saveData.data.happySpeedD;
				happyAccHigh = saveData.data.happyAccHighD;
				happyAccLow = saveData.data.happyAccLowD;
				happyAccRise = saveData.data.happyAccRiseD;
				happyAccFall = saveData.data.happyAccFallD;
				happyAmmo = saveData.data.happyAmmoD;
				happyPistolAmmo = saveData.data.happyPistolAmmoD;
				happyAmmoCap = saveData.data.happyAmmoCapD;
				happyHealth = saveData.data.happyHealthD;
				happyHealthCap = saveData.data.happyHealthCapD;
				happyReload = saveData.data.happyReloadD;
				happyDamage = saveData.data.happyDamageD;
				} //HAPPY
				
				{
				tankHealth = saveData.data.tankHealthD;
				} //TANK
				
				{
				pistolDamage = saveData.data.pistolDamageD;
				pistolsUnlocked = saveData.data.pistolsUnlockedD;
				} //PISTOL
				
				{
				rocketAmmo = saveData.data.rocketAmmoD;
				rocketsUnlocked = saveData.data.rocketsUnlockedD;
				} //ROCKET
				
				normDead = saveData.data.normDeadD;
				carlDead = saveData.data.carlDeadD;
				squeakersDead = saveData.data.squeakersDeadD;
				happyDead = saveData.data.happyDeadD;
				
				tut5Switch = saveData.data.tut5SwitchD;
				tut6Switch = saveData.data.tut6SwitchD;
				tut7Switch = saveData.data.tut7SwitchD;
		}
		
		public function forceGC():void //COLLECT GARBAGE
		{
			 
			 System.gc();
			// Displays a text in the screen
		   // displayText("----- Garbage collection triggered -----");
		}
}
	
}
