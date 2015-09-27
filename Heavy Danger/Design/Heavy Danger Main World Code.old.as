import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.ui.Mouse;
import flash.media.Sound;
import flash.filters.BitmapFilter;
import flash.filters.BitmapFilterQuality;
import flash.filters.BlurFilter;
import flash.events.TimerEvent;
import flash.utils.Timer;
import flash.display.BlendMode;
import flash.display.MovieClip;
import flash.geom.ColorTransform;
import flash.events.MouseEvent;
import flash.display.DisplayObject;
import flash.media.SoundChannel;
import flash.utils.getTimer;
import flash.filters.DropShadowFilter; 

stage.focus = this;

//HEAVY DANGER MAIN GAME WORLD CODE
//MADE BY BAD BEAR GAMES
//CODED BY MARK SCOTT


//INIT
if (init)
{
	//KEYS
	{
	var leftKeyDown:Boolean = false;
	var rightKeyDown:Boolean = false;
	var upKeyDown:Boolean = false;
	var downKeyDown:Boolean = false;
	var eKeyDown:Boolean = false;
	var qKeyDown:Boolean = false;
	var rKeyDown:Boolean = false;
	var mouseIsDown:Boolean = false;
	var oneKeyDown:Boolean = false;
	var twoKeyDown:Boolean = false;
	var threeKeyDown:Boolean = false;
	var fourKeyDown:Boolean = false;
	var fiveKeyDown:Boolean = false;
	var pKeyDown:Boolean = false;
	}
	
	//KEY SWITCHES
	var qSwitch:Boolean = true;
	var eSwitch:Boolean = true;
	var rSwitch:Boolean = true;
	
	//PLAYER
	currentPlayer = 2;
	var playerHor:Number = 0;
	var playerVert:Number = 0;
	
	//WEAPON VARS
	var accuracy:Number = 30;
	var fireRate:Number = 0;
	currentWeapon = 1;
	
	//SOUNDS
	{
	var assaultShot:Sound = new assaultShotSound;
	var pistolShot:Sound = new pistolShotSound;
	var ex1:Sound = new ex1Sound;
	var rifleReload:Sound = new rifleReloadSound;
	var reloadPistol:Sound = new pistolReloadSound;
	var emptyGunIsPlaying:Boolean = false;
	var enemyShot:Sound = new enemyShotSound;
	var rocketLaunch:Sound = new rocketLaunchSound;
	var shotgunReload:Sound = new shotgunReloadSound;
	var sniperReload:Sound = new sniperReloadSound;
	var lmgReload:Sound = new lmgReloadSound;
	var shotgunShot:Sound = new shotgunShotSound;
	var lmgShot:Sound = new lmgShotSound;
	var pickup:Sound = new pickupSound;
	var earnPoint:Sound = new earnPointSound;
	var tankShot:Sound = new tankShotSound;
	var tankExplode:Sound = new tankExplodeSound;
	var buy:Sound = new buySound;
	var revive:Sound = new reviveSound;
	var downed:Sound = new downedSound;
	var tankReload:Sound = new tankReloadSound;
	
	calmTrackChannel = calmTrack.play(0, 1);
	
	var sn:SoundTransform = new SoundTransform();
	
	if (mute)
	{
		sn.volume = 0;
	}
	else
	{
		sn.volume = 1;
	}
	}
	
	//FILTERS
	{
	var blurFilter1:BlurFilter = new BlurFilter(70,70,1);
	blurFilter1.quality = 1;
	var dropShadow:DropShadowFilter = new DropShadowFilter();
	dropShadow.distance = 3;
	dropShadow.angle = 45;
	dropShadow.color = 0x000000;
	dropShadow.alpha = 1;
	dropShadow.blurX = 15;
	dropShadow.blurY = 15;
	dropShadow.strength = 1;
	dropShadow.quality = 1;
	dropShadow.inner = false;
	dropShadow.knockout = false;
	dropShadow.hideObject = false;
	}
	
	//ARRAYS
	{
	var bullets:Array;
	bullets = new Array();
	var enemyBullets:Array;
	enemyBullets = new Array();
	var bulletHits:Array;
	bulletHits = new Array();
	var gunFlashes:Array;
	gunFlashes = new Array();
	var ammo:Array;
	ammo = new Array();
	var points:Array;
	points = new Array();
	
	var enemiesOne:Array;
	enemiesOne = new Array();
	}
	
	//TIMERS
	{
		var waveTimer = new Timer(4000, 0);
		var tutTimer = new Timer(8000, 0);
		var exciteTimer = new Timer(14360, 0);
	}
	
	//MISC
	var reload:Number = 0;
	var tutStage:Number = 0;
	var waveDone:Boolean = true;
	var gameOver:Boolean = false;
	var addedAmmo:Number = 0;
	
	if (currentWave == 0)
	{
		hud_mc.tutBox_mc.visible = false;
		hud_mc.tutBox_mc.gotoAndStop(1);
		tutStage = 0;
		normHealth = 0;
		happyHealth = 0;
		squeakersHealth = 0;
		
		nextWaveButton_btn.visible = false;
		shopButton_btn.visible = false;
		waveDone = false;
	}
	else
	{
		hud_mc.tutBox_mc.visible = false;
	}
	
	//OTHER---
	{
		if (normDead)
		{
			norm_mc.visible = false;
			norm_mc.alpha =0;
		}
		if (carlDead)
		{
			carl_mc.visible = false;
			carl_mc.alpha = 0;
		}
		if (squeakersDead)
		{
			squeakers_mc.visible = false;
			squeakers_mc.alpha = 0;
		}
		if (happyDead)
		{
			happy_mc.visible = false;
			happy_mc.alpha = 0;
		}
	} //IF DEAD, STAY DEAD
	
	{
		norm_mc.x = normX;
		norm_mc.y = normY;
		carl_mc.x = carlX;
		carl_mc.y = carlY;
		squeakers_mc.x = squeakersX;
		squeakers_mc.y = squeakersY;
		happy_mc.x = happyX;
		happy_mc.y = happyY;
		tank_mc.x = tankX;
		tank_mc.y = tankY;
	} //SET Ys
	
	fade_mc.gotoAndPlay(2);
	//---
	
	//OPTIMIZATION VARS
	var pb; //PLAYER BULLETS
	var e1b; //ENEMY BULLETS
	var guf2; //GUN FLASH
	var guf;
	var pt1; //POINT TEXT
	var bh1; //BULLETS HITS
	var bh12; //EX HITS
	var am; //AMMO
	var ame:Number; //ADDED AMMO NUMBER
	var tempR2:Number; //AMMO RANDOM NUMBER
	
	var pauseGame:Boolean = false;
	var pauseClick:Boolean = true;
	
	addEventListeners();
	init = false;
}
else
{
	//KEYS
	{
	leftKeyDown = false;
	rightKeyDown = false;
	upKeyDown = false;
	downKeyDown = false;
	eKeyDown = false;
	qKeyDown = false;
	rKeyDown = false;
	mouseIsDown = false;
	oneKeyDown = false;
	twoKeyDown = false;
	threeKeyDown = false;
	fourKeyDown = false;
	fiveKeyDown = false;
	pKeyDown = false;
	}
	
	//KEY SWITCHES
	qSwitch = true;
	eSwitch = true;
	rSwitch = true;
	
	//PLAYER
	playerHor = 0;
	playerVert = 0;
	
	//WEAPON VARS
	accuracy = 30;
	fireRate = 0;
	currentWeapon = 1;
	
	//SOUNDS
	emptyGunIsPlaying = true;
	
	if (mute)
	{
		sn.volume = 0;
	}
	else
	{
		sn.volume = 1;
	}
	//calmTrackChannel = calmTrack.play(0, 1);
	
	//MISC
	reload = 0;
	tutStage = 0;
	waveDone = true;
	gameOver = false;
	
	/*if (currentWave == 0)
	{
		waveDone = false;
		hud_mc.tutBox_mc.visible = false;
		hud_mc.tutBox_mc.gotoAndStop(1);
		tutStage = 0;
		normHealth = 0;
		happyHealth = 0;
		squeakersHealth = 0;
		fade_mc.gotoAndPlay(2);
	}
	else
	{
		hud_mc.tutBox_mc.visible = false;
	}*/
	
	if (currentWave == 0)
	{
		hud_mc.tutBox_mc.visible = false;
		hud_mc.tutBox_mc.gotoAndStop(1);
		tutStage = 0;
		normHealth = 0;
		happyHealth = 0;
		squeakersHealth = 0;
		fade_mc.gotoAndPlay(2);
		
		nextWaveButton_btn.visible = false;
		shopButton_btn.visible = false;
		waveDone = false;
	}
	else
	{
		hud_mc.tutBox_mc.visible = false;
	}
	
	//OTHER---
	{
		if (normDead) 
		{
			norm_mc.visible = false;
			norm_mc.alpha = 0;
		}
		if (carlDead)
		{
			carl_mc.visible = false;
			carl_mc.alpha = 0;
		}
		if (squeakersDead)
		{
			squeakers_mc.visible = false;
			squeakers_mc.alpha = 0;
		}
		if (happyDead)
		{
			happy_mc.visible = false;
			happy_mc.alpha = 0;
		}
	} //IF DEAD, STAY DEAD
	
	{
		norm_mc.x = normX;
		norm_mc.y = normY;
		carl_mc.x = carlX;
		carl_mc.y = carlY;
		squeakers_mc.x = squeakersX;
		squeakers_mc.y = squeakersY;
		happy_mc.x = happyX;
		happy_mc.y = happyY;
		tank_mc.x = tankX;
		tank_mc.y = tankY;
	} //SET Ys
	//---
	bodyCount = 0;
	
	pauseGame = false;
	pauseClick = true;
	
	addEventListeners();
}

function addEventListeners():void //ADDS ALL EVENT LISTENERS
{
	//INPUT
	stage.addEventListener(KeyboardEvent.KEY_DOWN, checkKeysDown);
	stage.addEventListener(KeyboardEvent.KEY_UP, checkKeysUp);
	stage.addEventListener(MouseEvent.MOUSE_DOWN, mouseDowns);
	stage.addEventListener(MouseEvent.MOUSE_UP, mouseUps);
	
	//addEventListener(Event.ENTER_FRAME, animPlayer);
	addEventListener(Event.ENTER_FRAME, animPlayer, false, 0, true);
	//addEventListener(Event.ENTER_FRAME, animations);
	addEventListener(Event.ENTER_FRAME, animations, false, 0, true);
	addEventListener(Event.ENTER_FRAME, animMouse);
	addEventListener(Event.ENTER_FRAME, useWeapon, false, 0, true);
	//addEventListener(Event.ENTER_FRAME, useWeapon);
	addEventListener(Event.ENTER_FRAME, afterWeapon);
	addEventListener(Event.ENTER_FRAME, updateObjects, false, 0, true);
	//addEventListener(Event.ENTER_FRAME, updateObjects);
	//addEventListener(Event.ENTER_FRAME, updateHUD);
	addEventListener(Event.ENTER_FRAME, updateHUD, false, 0, true);
	addEventListener(MouseEvent.CLICK, clickButtons);
	addEventListener(MouseEvent.MOUSE_OVER, buttonsRoll);
	
	waveTimer.addEventListener(TimerEvent.TIMER, wave);
	tutTimer.addEventListener(TimerEvent.TIMER, nextTut);
	exciteTimer.addEventListener(TimerEvent.TIMER, startExciteFix);
	
	exciteTrackChannel.addEventListener(Event.SOUND_COMPLETE, exciteTrackComplete);
	actionTrackChannel.addEventListener(Event.SOUND_COMPLETE, actionTrackComplete);
	calmTrackChannel.addEventListener(Event.SOUND_COMPLETE, calmTrackComplete);
	//addEventListener(Event.ENTER_FRAME, exciteTrackFix);
}

function removeEventListeners():void //REMOVES ALL EVENT LISTENERS
{
	//INPUT
	stage.removeEventListener(KeyboardEvent.KEY_DOWN, checkKeysDown);
	stage.removeEventListener(KeyboardEvent.KEY_UP, checkKeysUp);
	stage.removeEventListener(MouseEvent.MOUSE_DOWN, mouseDowns);
	stage.removeEventListener(MouseEvent.MOUSE_UP, mouseUps);
	
	//removeEventListener(Event.ENTER_FRAME, animPlayer);
	removeEventListener(Event.ENTER_FRAME, animPlayer);
	//removeEventListener(Event.ENTER_FRAME, animations);
	removeEventListener(Event.ENTER_FRAME, animations);
	removeEventListener(Event.ENTER_FRAME, animMouse);
	//removeEventListener(Event.ENTER_FRAME, useWeapon);
	removeEventListener(Event.ENTER_FRAME, useWeapon);
	removeEventListener(Event.ENTER_FRAME, afterWeapon);
	//removeEventListener(Event.ENTER_FRAME, updateObjects);
	removeEventListener(Event.ENTER_FRAME, updateObjects);
	//removeEventListener(Event.ENTER_FRAME, updateHUD);
	removeEventListener(Event.ENTER_FRAME, updateHUD);
	removeEventListener(MouseEvent.CLICK, clickButtons);
	removeEventListener(MouseEvent.MOUSE_OVER, buttonsRoll);
	
	waveTimer.removeEventListener(TimerEvent.TIMER, wave);
	tutTimer.removeEventListener(TimerEvent.TIMER, nextTut);
	exciteTimer.removeEventListener(TimerEvent.TIMER, startExciteFix);
	//exciteTimer.stop(); //KEEP EXCITE TIMER RUNNING
	waveTimer.stop();
	tutTimer.stop();
	
	exciteTrackChannel.removeEventListener(Event.SOUND_COMPLETE, exciteTrackComplete);
	actionTrackChannel.removeEventListener(Event.SOUND_COMPLETE, actionTrackComplete);
	calmTrackChannel.removeEventListener(Event.SOUND_COMPLETE, calmTrackComplete);
	//removeEventListener(Event.ENTER_FRAME, exciteTrackFix);
}

function removeObjects():void //REMOVES ALL OBJECTS AND STOPS ALL TIMERS
{
	//REMOVE CHARACTERS
	if (norm_mc != null)
	{
		removeChild(norm_mc);
		norm_mc = null;
	}
	if (carl_mc != null)
	{
		removeChild(carl_mc);
		carl_mc = null;
	}
	if (squeakers_mc != null)
	{
		removeChild(squeakers_mc);
		squeakers_mc = null;
	}
	if (happy_mc != null)
	{
		removeChild(happy_mc);
		happy_mc  = null;
	}
	if (tank_mc != null)
	{
		removeChild(tank_mc);
		tank_mc = null;
	}
	
	if (hud_mc != null)
	{
		removeChild(hud_mc);
		hud_mc = null;
	}
	
	removeChild(shopButton_btn);
	removeChild(nextWaveButton_btn);
	removeChild(muteButton2_btn);
	removeChild(quitButton_btn);
	removeChild(quitButtonP_btn);
	removeChild(controlsButton_btn);
	
	
	for (var bi:Number = bullets.length - 1; bi >= 0; bi--)
	{
		removeChild(bullets[bi]);
		bullets[bi] = null;
		bullets.splice(bi, 1);
	}
	
	for (var ar:Number = ammo.length - 1; ar >= 0; ar--)
	{
		removeChild(ammo[ar]);
		ammo[ar] = null;
		ammo.splice(ar, 1);
	}
	
	for (var er:Number = enemiesOne.length - 1; er >= 0; er--)
	{
		removeChild(enemiesOne[er]);
		enemiesOne[er] = null;
		enemiesOne.splice(er, 1);
	}
	
	for (var ev:Number = bulletHits.length - 1; ev >= 0; ev--)
	{
		removeChild(bulletHits[ev]);
		bulletHits[ev] = null;
		bulletHits.splice(ev, 1);
	}
	
	for (var ev2:Number = gunFlashes.length - 1; ev2 >= 0; ev2--)
	{
		if (black_mc.contains(gunFlashes[ev2]))

		{
			black_mc.removeChild(gunFlashes[ev2]);
		}
		else
		{
			removeChild(gunFlashes[ev2]);
		}
		gunFlashes[ev2] = null;
		gunFlashes.splice(ev2, 1);
	}
	
	removeChild(black_mc);
	
	forceGC();
}

function checkKeysDown(evt:KeyboardEvent):void //CHECK KEYS DOWN
{
	if (evt.keyCode == 87)
	{
		upKeyDown = true;
	}
	if (evt.keyCode == 83)
	{
		downKeyDown = true;
	}
	if (evt.keyCode == 65)
	{
		leftKeyDown = true;
	}
	if (evt.keyCode == 68)
	{
		rightKeyDown = true;
	}
	if (evt.keyCode == 69)
	{
		eKeyDown = true;
	}
	if (evt.keyCode == 81)
	{
		qKeyDown = true;
	}
	if (evt.keyCode == 82)
	{
		rKeyDown = true;
	}
	if (evt.keyCode == 49)
	{
		oneKeyDown = true;
	}
	if (evt.keyCode == 50)
	{
		twoKeyDown = true;
	}
	if (evt.keyCode == 51)
	{
		threeKeyDown = true;
	}
	if (evt.keyCode == 52)
	{
		fourKeyDown = true;
	}
	if (evt.keyCode == 53)
	{
		fiveKeyDown = true;
	}
	if (evt.keyCode == 80)
	{
		pKeyDown = true;
	}
}

function checkKeysUp(evt:KeyboardEvent):void //CHECK KEYS UP
{
	if (evt.keyCode == 87)
	{
		upKeyDown = false;
	}
	if (evt.keyCode == 83)
	{
		downKeyDown = false;
	}
	if (evt.keyCode == 65)
	{
		leftKeyDown = false;
	}
	if (evt.keyCode == 68)
	{
		rightKeyDown = false;
	}
	if (evt.keyCode == 69)
	{
		eKeyDown = false;
	}
	if (evt.keyCode == 81)
	{
		qKeyDown = false;
	}
	if (evt.keyCode == 82)
	{
		rKeyDown = false;
	}
	if (evt.keyCode == 49)
	{
		oneKeyDown = false;
	}
	if (evt.keyCode == 50)
	{
		twoKeyDown = false;
	}
	if (evt.keyCode == 51)
	{
		threeKeyDown = false;
	}
	if (evt.keyCode == 52)
	{
		fourKeyDown = false;
	}
	if (evt.keyCode == 53)
	{
		fiveKeyDown = false;
	}
	if (evt.keyCode == 80)
	{
		pKeyDown = false;
	}
}

function checkEnemiesDown():Number
{
	var tempCed:Number = 0;
	for (var ced:Number = enemiesOne.length - 1; ced >= 0; ced--)
	{
		if (enemiesOne[ced].currentFrame == 1)
		{
			tempCed++;
		}
	}
	return tempCed;
}

function wave(evt:TimerEvent):void //WAVES
{
	hud_mc.eventText_mc.visible = false;
	hud_mc.eventText_mc.eventText_txt.text = "";
	
	switch (currentWave)
	{
		//TUTORIAL
		case 0:
		if (bodyCount < 20) //POINT TOTAL: 200
		{
			if (bodyCount < 6)
			{
				enemyOnes(1);
			}
			else
			{
				enemyOnes(2);
			}
			waveTimer.stop();
			waveTimer.start();
		}
		else
		{
			if (checkEnemiesDown() == 0)
			{
				bodyCount = 0;
				currentWave++;
				forceGC();
				waveDone = true;
				waveTimer.stop();
				saveGame();
			}
			else
			{
				waveTimer.stop();
				waveTimer.start();
			}
		}
		break;
		
		//WAVE 1
		case 1:
		if (bodyCount < 23) //POINT TOTAL: 230
		{
			if (bodyCount < 5)
			{
				enemyOnes(5);
			}
			else
			{
				enemyOnes(3);
			}
			waveTimer.stop();
			waveTimer.start();
		}
		else
		{
			if (checkEnemiesDown() == 0)
			{
				bodyCount = 0;
				currentWave++;
				forceGC();
				waveDone = true;
				waveTimer.stop();
				saveGame();
			}
			else
			{
				waveTimer.stop();
				waveTimer.start();
			}
		}
		break;
		
		//WAVE 2
		case 2:
		if (bodyCount < 30) //POINT TOTAL: 340
		{
			if (bodyCount < 5)
			{
				enemyOnes(5);
			}
			else if (bodyCount < 9)
			{
				enemyTwos(4);
			}
			else
			{
				enemyOnes(3);
			}
			waveTimer.stop();
			waveTimer.start();
		}
		else
		{
			if (checkEnemiesDown() == 0)
			{
				bodyCount = 0;
				currentWave++;
				forceGC();
				waveDone = true;
				waveTimer.stop();
				saveGame();
			}
			else
			{
				waveTimer.stop();
				waveTimer.start();
			}
		}
		break;
		
		//WAVE 3 
		case 3:
		if (bodyCount < 29) //POINT TOTAL: 360
		{
			if (bodyCount < 8)
			{
				enemyOnes(8);
			}
			else if (bodyCount < 12)
			{
				enemyTwos(4);
			}
			else if (bodyCount < 17)
			{
				enemyOnes(5);
			}
			else
			{
				enemyTwos(1);
				enemyOnes(3);
			}
			waveTimer.stop();
			waveTimer.start();
		}
		else
		{
			if (checkEnemiesDown() == 0)
			{
				bodyCount = 0;
				currentWave++;
				forceGC();
				waveDone = true;
				waveTimer.stop();
				saveGame();
			}
			else
			{
				waveTimer.stop();
				waveTimer.start();
			}
		}
		break;
		
		//WAVE 4
		case 4:
		if (bodyCount < 45) //POINT TOTAL:  520
		{
			if (bodyCount < 8) //120
			{
				enemyTwos(2);
				enemyOnes(2);
			}
			else if (bodyCount < 18) //100
			{
				enemyOnes(5);
			}
			else if (bodyCount < 30) //150
			{
				enemyOnes(3);
				enemyTwos(1);
			}
			else
			{
				enemyOnes(5); //150
			}
			waveTimer.stop();
			waveTimer.start();
		}
		else
		{
			if (checkEnemiesDown() == 0)
			{
				bodyCount = 0;
				currentWave++;
				forceGC();
				waveDone = true;
				waveTimer.stop();
				saveGame();
			}
			else
			{
				waveTimer.stop();
				waveTimer.start();
			}
		}
		break;
		
		//WAVE 5
		case 5:
		if (bodyCount < 10) //POINT TOTAL: 160
		{
			if (bodyCount < 4) //80
			{
				enemyThrees(4);
			}
			else
			{
				enemyOnes(1); //80
			}
			waveTimer.stop();
			waveTimer.start();
		}
		else
		{
			if (checkEnemiesDown() == 0)
			{
				bodyCount = 0;
				currentWave++;
				forceGC();
				waveDone = true;
				waveTimer.stop();
				saveGame();
			}
			else
			{
				waveTimer.stop();
				waveTimer.start();
			}
		}
		break;
		
		//WAVE 6
		case 6:
		if (bodyCount < 22) //POINT TOTAL: 310
		{
			if (bodyCount < 7) //70
			{
				enemyOnes(7);
			}
			else if (bodyCount < 11) //80
			{
				enemyTwos(4);
			}
			else if (bodyCount < 12) //40
			{
				enemyThrees(1);
			}
			else if (bodyCount < 17) //50
			{
				enemyOnes(5);
			}
			else if (bodyCount < 19) //40
			{
				enemyTwos(2);
			}
			else
			{
				enemyOnes(3);
			}
			waveTimer.stop();
			waveTimer.start();
		}
		else
		{
			if (checkEnemiesDown() == 0)
			{
				bodyCount = 0;
				currentWave++;
				forceGC();
				waveDone = true;
				waveTimer.stop();
				saveGame();
			}
			else
			{
				waveTimer.stop();
				waveTimer.start();
			}
		}
		break;
		
		//WAVE 7
		case 7:
		if (bodyCount < 20) //POINT TOTAL: 360
		{
			if (bodyCount < 4) //100
			{
				enemyTwos(3);
				enemyThrees(1);
			}
			else if (bodyCount < 10) //160
			{
				enemyOnes(6);
			}
			else //360
			{
				enemyTwos(2);
			}
			waveTimer.stop();
			waveTimer.start();
		}
		else
		{
			if (checkEnemiesDown() == 0)
			{
				bodyCount = 0;
				currentWave++;
				forceGC();
				waveDone = true;
				waveTimer.stop();
				saveGame();
			}
			else
			{
				waveTimer.stop();
				waveTimer.start();
			}
		}
		break;
		
		//WAVE 8 - FLOOD OF ENEMY ONES
		case 8:
		if (bodyCount < 40) //POINT TOTAL: 400
		{
			if (bodyCount < 10) //100
			{
				enemyOnes(10);
			}
			else if (bodyCount < 30) //200
			{
				enemyOnes(5);
			}
			else //100
			{
				enemyOnes(10);
			}
			waveTimer.stop();
			waveTimer.start();
		}
		else
		{
			if (checkEnemiesDown() == 0)
			{
				bodyCount = 0;
				currentWave++;
				forceGC();
				waveDone = true;
				waveTimer.stop();
				saveGame();
			}
			else
			{
				waveTimer.stop();
				waveTimer.start();
			}
		}
		break;
		
		//WAVE 9 - NINJA SQUAD APPEARS, BIG GUYS W/ FLOOD
		case 9:
		if (bodyCount < 23) //POINT TOTAL: 410
		{
			if (bodyCount < 3) //90
			{
				enemyFours(3);
			}
			else if (bodyCount < 9) //120
			{
				enemyTwos(2);
			}
			else if (bodyCount < 11) //80
			{
				enemyThrees(2);
			}
			else //120
			{
				enemyOnes(3);
			}
			waveTimer.stop();
			waveTimer.start();
		}
		else
		{
			if (checkEnemiesDown() == 0)
			{
				bodyCount = 0;
				currentWave++;
				forceGC();
				waveDone = true;
				waveTimer.stop();
				saveGame();
			}
			else
			{
				waveTimer.stop();
				waveTimer.start();
			}
		}
		break;
		
		//WAVE 10 - TANK, IT GETS REAL
		case 10:
		if (bodyCount < 10) //POINT TOTAL: 170
		{
			if (bodyCount < 2) //70
			{
				enemyTanks(2);
			}
			else //100
			{
				enemyOnes(2);
			}
			waveTimer.stop();
			waveTimer.start();
		}
		else
		{
			if (checkEnemiesDown() == 0)
			{
				bodyCount = 0;
				currentWave++;
				forceGC();
				waveDone = true;
				waveTimer.stop();
				saveGame();
			}
			else
			{
				waveTimer.stop();
				waveTimer.start();
			}
		}
		break;
		
		//WAVE 11 - MAJOR FLOOD
		case 11:
		if (bodyCount < 36) //POINT TOTAL: 510
		{
			if (bodyCount < 9) //150
			{
				enemyOnes(9);
			}
			else if (bodyCount < 21) //80
			{
				enemyOnes(2);
				enemyTwos(1);
			}
			else if (bodyCount < 23) //80
			{
				enemyThrees(2);
			}
			else if (bodyCount < 35) //160
			{
				enemyOnes(2);
				enemyTwos(1);
			}
			else 
			{
				enemyThrees(1);
			}
			waveTimer.stop();
			waveTimer.start();
		}
		else
		{
			if (checkEnemiesDown() == 0)
			{
				bodyCount = 0;
				currentWave++;
				forceGC();
				waveDone = true;
				waveTimer.stop();
				saveGame();
			}
			else
			{
				waveTimer.stop();
				waveTimer.start();
			}
		}
		break;
		
		//WAVE 12 - NINJAS
		case 12:
		if (bodyCount < 36) //POINT TOTAL: 700
		{
			if (bodyCount < 5) //150
			{
				enemyFours(5);
			}
			else if (bodyCount < 10) //50
			{
				enemyOnes(5);
			}
			else if (bodyCount < 12) //80
			{
				enemyThrees(2);
			}
			else if (bodyCount < 15) //120
			{
				enemyFours(3);
			}
			else if (bodyCount < 20) //60
			{
				enemyTwos(2);
				enemyOnes(3);
			}
			else //240
			{
				enemyOnes(3);
				enemyFours(1);
			}
			waveTimer.stop();
			waveTimer.start();
		}
		else
		{
			if (checkEnemiesDown() == 0)
			{
				bodyCount = 0;
				currentWave++;
				forceGC();
				waveDone = true;
				waveTimer.stop();
				saveGame();
			}
			else
			{
				waveTimer.stop();
				waveTimer.start();
			}
		}
		break;
		
		//WAVE 13 - TANK AND ANNOYING FRIENDS
		case 13:
		if (bodyCount < 29) //POINT TOTAL: 560
		{
			if (bodyCount < 1) //70
			{
				enemyTanks(1);
			}
			else if (bodyCount < 16) //150
			{
				enemyOnes(3);
			}
			else if (bodyCount < 20) //160
			{
				enemyThrees(4);
			}
			else //180
			{
				enemyTwos(1);
				enemyFours(1);
				enemyOnes(1);
			}
			
			waveTimer.stop();
			waveTimer.start();
		}
		else
		{
			if (checkEnemiesDown() == 0)
			{
				bodyCount = 0;
				currentWave++;
				forceGC();
				waveDone = true;
				waveTimer.stop();
				saveGame();
			}
			else
			{
				waveTimer.stop();
				waveTimer.start();
			}
		}
		break;
		
		//WAVE 14 - MIX OF EVERYTHING
		case 14:
		if (bodyCount < 31)
		{
			if (bodyCount < 5)
			{
				enemyFours(5);
			}
			else if (bodyCount < 6)
			{
				enemyTanks(1);
			}
			else if (bodyCount < 13)
			{
				enemyOnes(7);
			}
			else if (bodyCount < 17)
			{
				enemyTwos(4);
			}
			else if (bodyCount < 20)
			{
				enemyThrees(3);
			}
			else if (bodyCount < 21)
			{
				enemyTanks(1);
			}
			else
			{
				enemyOnes(5);
			}
			waveTimer.stop();
			waveTimer.start();
		}
		else
		{
			if (checkEnemiesDown() == 0)
			{
				bodyCount = 0;
				currentWave++;
				forceGC();
				waveDone = true;
				waveTimer.stop();
				saveGame();
			}
			else
			{
				waveTimer.stop();
				waveTimer.start();
			}
		}
		break;
		
		//WAVE 15 - TOO MANY SNIPERS
		case 15:
		if (bodyCount < 32)  //POINT TOTAL: 640
		{
			if (bodyCount < 5) //100
			{
				enemyTwos(5);
			}
			else if (bodyCount < 8) //30
			{
				enemyOnes(3);
			}
			else if (bodyCount < 10) //80
			{
				enemyThrees(2);
			}
			else if (bodyCount < 15) //100
			{
				enemyTwos(5);
			}
			else if (bodyCount < 24) //150
			{
				enemyTwos(2);
				enemyOnes(1);
			}
			else if (bodyCount < 26) //50
			{
				enemyFours(1);
				enemyTwos(1);
			}
			else //120
			{
				enemyTwos(3);
			}
			waveTimer.stop();
			waveTimer.start();
		}
		else
		{
			if (checkEnemiesDown() == 0)
			{
				bodyCount = 0;
				currentWave++;
				forceGC();
				waveDone = true;
				waveTimer.stop();
				saveGame();
			}
			else
			{
				waveTimer.stop();
				waveTimer.start();
			}
		}
		break;
		
		//WAVE 16 - TANK WARFARE
		case 16:
		if (bodyCount < 25)  //POINT TOTAL: 770
		{
			if (bodyCount < 2) //140
			{
				enemyTanks(2);
			}
			else if (bodyCount < 8) //60
			{
				enemyOnes(6);
			}
			else if (bodyCount < 10) //40
			{
				enemyTwos(2);
			}
			else if (bodyCount < 12) //80
			{
				enemyThrees(2);
			}
			else if (bodyCount < 16) //80
			{
				enemyTwos(4);
			}
			else if (bodyCount < 17) //70
			{
				enemyTanks(1);
			}
			else if (bodyCount < 20) //120
			{
				enemyThrees(3);
			}
			else if (bodyCount < 24) //40
			{
				enemyOnes(4);
			}
			else //140
			{
				enemyTanks(1);
			}
			waveTimer.stop();
			waveTimer.start();
		}
		else
		{
			if (checkEnemiesDown() == 0)
			{
				bodyCount = 0;
				currentWave++;
				forceGC();
				waveDone = true;
				waveTimer.stop();
				saveGame();
			}
			else
			{
				waveTimer.stop();
				waveTimer.start();
			}
		}
		break;
		
		//WAVE 17 - UP HILL
		case 17:
		if (bodyCount < 54)  //POINT TOTAL:  1180
		{
			if (bodyCount < 25) //250
			{
				enemyOnes(5);
			}
			else if (bodyCount < 37) //240
			{
				enemyTwos(4);
			}
			else if (bodyCount < 43) //240
			{
				enemyThrees(3);
			}
			else if (bodyCount < 51) //240
			{
				enemyFours(4);
			}
			else if (bodyCount < 54) //210
			{
				enemyTanks(1);
			}
			waveTimer.stop();
			waveTimer.start();
		}
		else
		{
			if (checkEnemiesDown() == 0)
			{
				bodyCount = 0;
				currentWave++;
				forceGC();
				waveDone = true;
				waveTimer.stop();
				saveGame();
			}
			else
			{
				waveTimer.stop();
				waveTimer.start();
			}
		}
		break;
		
		//WAVE 18 - UP HILL
		case 18:
		if (bodyCount < 50)  //POINT TOTAL:  1180
		{
			if (bodyCount < 3) //210
			{
				enemyTanks(1);
			}
			else if (bodyCount < 11) //180
			{
				enemyFours(4);
			}
			else if (bodyCount < 17) //240
			{
				enemyThrees(3);
			}
			else if (bodyCount < 29) //240
			{
				enemyTwos(4);
			}
			else if (bodyCount < 50) //210
			{
				enemyOnes(7);
			}
			waveTimer.stop();
			waveTimer.start();
		}
		else
		{
			if (checkEnemiesDown() == 0)
			{
				bodyCount = 0;
				currentWave++;
				forceGC();
				waveDone = true;
				waveTimer.stop();
				saveGame();
			}
			else
			{
				waveTimer.stop();
				waveTimer.start();
			}
		}
		break;
		
		//WAVE 19 - BIG BADS COME OUT AND PLAY
		case 19:
		if (bodyCount < 28)  //POINT TOTAL:  1210
		{
			if (bodyCount < 5) //200
			{
				enemyThrees(5);
			}
			else if (bodyCount < 10) //150
			{
				enemyFours(5);
			}
			else if (bodyCount < 12) //140
			{
				enemyTanks(1);
			}
			else if (bodyCount < 15) //120
			{
				enemyThrees(3);
			}
			else if (bodyCount < 16) //70
			{
				enemyTanks(1);
			}
			else if (bodyCount < 20) //120
			{
				enemyFours(4);
			}
			else if (bodyCount < 25) //200
			{
				enemyThrees(3);
			}
			else if (bodyCount < 28) //210
			{
				enemyTanks(3);
			}
			waveTimer.stop();
			waveTimer.start();
		}
		else
		{
			if (checkEnemiesDown() == 0)
			{
				bodyCount = 0;
				currentWave++;
				forceGC();
				waveDone = true;
				waveTimer.stop();
				saveGame();
			}
			else
			{
				waveTimer.stop();
				waveTimer.start();
			}
		}
		break;
		
		//WAVE 20 - SWARM OF ONES
		case 20:
		if (bodyCount < 200)  //POINT TOTAL:  2000
		{
			enemyOnes(10);
			waveTimer.stop();
			waveTimer.start();
		}
		else
		{
			if (checkEnemiesDown() == 0)
			{
				bodyCount = 0;
				currentWave++;
				forceGC();
				waveDone = true;
				waveTimer.stop();
				saveGame();
			}
			else
			{
				waveTimer.stop();
				waveTimer.start();
			}
		}
		break;
		
		//WAVE 21 - OVER THE EDGE
		case 21:
		if (bodyCount < 200000)  //POINT TOTAL:  INFINITE
		{
			if (bodyCount < 10)
			{
				enemyOnes(10);
			}
			else if (bodyCount < 15) //150
			{
				enemyTwos(5);
			}
			else if (bodyCount < 20) //140
			{
				enemyThrees(3);
			}
			else if (bodyCount < 28) //120
			{
				enemyFours(5);
			}
			else if (bodyCount < 31) //70
			{
				enemyTanks(1);
			}
			else
			{
				enemyOnes(3);
				enemyTwos(1);
				enemyThrees(1);
				enemyFours(1);
			}
			waveTimer.stop();
			waveTimer.start();
		}
		else
		{
			if (checkEnemiesDown() == 0)
			{
				bodyCount = 0;
				currentWave++;
				forceGC();
				waveDone = true;
				waveTimer.stop();
				saveGame();
			}
			else
			{
				waveTimer.stop();
				waveTimer.start();
			}
		}
		break;
	}
	
}

//ENEMY SPAWN FUNCTIONS
{
	var newE:DisplayObject;
	
	function enemyOnes(tr:Number):void //SPAWN FIVE ENEMY ONES
	{
		for (var t:Number = 0; t < tr; t++)
		{
		newE = new enemyOne;
		addChild(newE);
		newE.width = 25;
		newE.height = 33.15;
		enemiesOne.push(newE);
		newE.filters = [dropShadow];
		newE.cacheAsBitmap = true;
		}
		bodyCount += tr;
	}
	
	function enemyFours(tr4:Number):void //SPAWN FIVE ENEMY ONES
	{
		for (var t4:Number = 0; t4 < tr4; t4++)
		{/*
		var newE4 = new enemyFour;
		addChild(newE4);
		newE4.width = 25;
		newE4.height = 33.15;
		enemiesOne.push(newE4);
		newE4.filters = [dropShadow];
		newE4.cacheAsBitmap = true;
		*/
		newE = new enemyFour;
		addChild(newE);
		newE.width = 25;
		newE.height = 33.15;
		enemiesOne.push(newE);
		newE.filters = [dropShadow];
		newE.cacheAsBitmap = true;
		}
		bodyCount += tr4;
	}
	
	function enemyTwos(tr2:Number):void //SPAWN FOUR SNIPERS
	{
		for (var ts:Number = 0; ts < tr2; ts++)
		{
		/*var newEs = new enemyTwo;
		addChild(newEs);
		newEs.width = 25;
		newEs.height = 33.15;
		enemiesOne.push(newEs);
		newEs.filters = [dropShadow];
		newEs.cacheAsBitmap = true;*/
		newE = new enemyTwo;
		addChild(newE);
		newE.width = 25;
		newE.height = 33.15;
		enemiesOne.push(newE);
		newE.filters = [dropShadow];
		newE.cacheAsBitmap = true;
		}
		bodyCount += tr2;
	}
	
	function enemyTanks(trt:Number):void //SPAWN A TANK
	{
		for (var trtr:Number = 0; trtr < trt; trtr++)
		{
		/*var newEst = new enemyTank;
		addChild(newEst);
		enemiesOne.push(newEst);
		newEst.filters = [dropShadow];
		newEst.cacheAsBitmap = true;*/
		newE = new enemyTank;
		addChild(newE);
		enemiesOne.push(newE);
		newE.filters = [dropShadow];
		newE.cacheAsBitmap = true;
		}
		bodyCount += trt;
	}
	
	function enemyThrees(tr3:Number):void //SPAWN TWO ENEMY THREES
	{
		for (var ts3:Number = 0; ts3 < tr3; ts3++)
		{
		/*var newEsg = new enemyThree;
		addChild(newEsg);
		newEsg.width = 25;
		newEsg.height = 33.15;
		newEsg.width *= 1.2;
		newEsg.height *= 1.2;
		enemiesOne.push(newEsg);
		newEsg.filters = [dropShadow];
		newEsg.cacheAsBitmap = true;*/
		var newE = new enemyThree;
		addChild(newE);
		newE.width = 25;
		newE.height = 33.15;
		newE.width *= 1.2;
		newE.height *= 1.2;
		enemiesOne.push(newE);
		newE.filters = [dropShadow];
		newE.cacheAsBitmap = true;
		}
		bodyCount += tr3;
	}
}

function animPlayer(evt:Event):void //ANIM THOSE PLAYERS
{
	//PAUSE GAME
	if (pKeyDown)
	{
		if ((pauseClick) && (shopButton_btn.visible == false))
		{
			if (pauseGame)
			{
				pauseGame = false;
			}
			else
			{
				pauseGame = true;
			}
			pauseClick = false;
		}
	}
	else
	{
		pauseClick = true;
	}
	
	if (!pauseGame)
	{
	//KEYS
	{
		if (upKeyDown)
		{
			if (currentPlayer == 1)
			{
				if (playerVert > (-normSpeed))
				{
					playerVert -= normAccel;
				}
				else
				{
					playerVert = (-normSpeed);
				}
			}
			else if (currentPlayer == 2)
			{
				if (playerVert > (-carlSpeed))
				{
					playerVert -= carlAccel;
				}
				else
				{
					playerVert = (-carlSpeed);
				}
			}
			else if (currentPlayer == 3)
			{
				if (playerVert > (-squeakersSpeed))
				{
					playerVert -= squeakersAccel;
				}
				else
				{
					playerVert = (-squeakersSpeed);
				}
			}
			else if (currentPlayer == 4)
			{
				if (playerVert > (-happySpeed))
				{
					playerVert -= happyAccel;
				}
				else
				{
					playerVert = (-happySpeed);
				}
			}
			else if (currentPlayer == 5)
			{
				if (tankHealth > 0)
				{
				tank_mc.x = (tank_mc.x + Math.cos((tank_mc.rotation - 90)/180*Math.PI)* tankSpeed);
				tank_mc.y = (tank_mc.y + Math.sin((tank_mc.rotation - 90)/180*Math.PI)* tankSpeed);
				}
			}
		}
		if (downKeyDown)
		{
			if (currentPlayer == 1)
			{
				if (playerVert < normSpeed)
				{
					playerVert += normAccel;
				}
				else
				{
					playerVert = normSpeed;
				}
			}
			if (currentPlayer == 2)
			{
				if (playerVert < carlSpeed)
				{
					playerVert += carlAccel;
				}
				else
				{
					playerVert = carlSpeed;
				}
			}
			if (currentPlayer == 3)
			{
				if (playerVert < squeakersSpeed)
				{
					playerVert += squeakersAccel;
				}
				else
				{
					playerVert = squeakersSpeed;
				}
			}
			if (currentPlayer == 4)
			{
				if (playerVert < happySpeed)
				{
					playerVert += happyAccel;
				}
				else
				{
					playerVert = happySpeed;
				}
			}
			if (currentPlayer == 5)
			{
				if (tankHealth > 0)
				{
				tank_mc.x = (tank_mc.x - Math.cos((tank_mc.rotation - 90)/180*Math.PI)* tankSpeed);
				tank_mc.y = (tank_mc.y - Math.sin((tank_mc.rotation - 90)/180*Math.PI)* tankSpeed);
				}
			}
		}
		if (rightKeyDown)
		{
			if (currentPlayer == 1)
			{
				if (playerHor < normSpeed)
				{
					playerHor += normAccel;
				}
				else
				{
					playerHor = normSpeed;
				}
			}
			if (currentPlayer == 2)
			{
				if (playerHor < carlSpeed)
				{
					playerHor += carlAccel;
				}
				else
				{
					playerHor = carlSpeed;
				}
			}
			if (currentPlayer == 3)
			{
				if (playerHor < squeakersSpeed)
				{
					playerHor += squeakersAccel;
				}
				else
				{
					playerHor = squeakersSpeed;
				}
			}
			if (currentPlayer == 4)
			{
				if (playerHor < happySpeed)
				{
					playerHor += happyAccel;
				}
				else
				{
					playerHor = happySpeed;
				}
			}
			if (currentPlayer == 5)
			{
				if (tankHealth > 0)
				{
				tank_mc.rotation += tankSpeed;
				}
			}
		}
		if (leftKeyDown)
		{
			if (currentPlayer == 1)
			{
				if (playerHor > (-normSpeed))
				{
					playerHor -= normAccel;
				}
				else
				{
					playerHor = (-normSpeed);
				}
			}
			if (currentPlayer == 2)
			{
				if (playerHor > (-carlSpeed))
				{
					playerHor -= carlAccel;
				}
				else
				{
					playerHor = (-carlSpeed);
				}
			}
			if (currentPlayer == 3)
			{
				if (playerHor > (-squeakersSpeed))
				{
					playerHor -= squeakersAccel;
				}
				else
				{
					playerHor = (-squeakersSpeed);
				}
			}
			if (currentPlayer == 4)
			{
				if (playerHor > (-happySpeed))
				{
					playerHor -= happyAccel;
				}
				else
				{
					playerHor = (-happySpeed);
				}
			}
			if (currentPlayer == 5)
			{
				if (tankHealth > 0)
				{
				tank_mc.rotation -= tankSpeed;
				}
			}
		}
		
		if (eKeyDown) //SWITCH WEAPON
		{
			if (eSwitch)
			{
				eSwitch = false;
				
				if (currentWeapon < 3)
				{
					currentWeapon++;
					
					if ((currentWeapon == 2) && (pistolsUnlocked))
					{
						accuracy = pistolAccLow;
						reload = 0;
					}
					else
					{
						currentWeapon = 3;
					}
					if ((currentWeapon == 3) && (rocketsUnlocked))
					{
						accuracy = rocketAccLow;
						reload = 0;
					}
					else if (currentWeapon != 2)
					{
						currentWeapon = 1;
						switch (currentPlayer) //WHICH PLAYER
						{
							case 1:
							accuracy = normAccLow;
							break;
							
							case 2:
							accuracy = carlAccLow;
							break;
							
							case 3:
							accuracy = squeakersAccLow;
							break;
							
							case 4:
							accuracy = happyAccLow;
							break;
						}
					}
					
				}
				else
				{
					currentWeapon = 1;
					
					switch (currentPlayer) //WHICH PLAYER
					{
						case 1:
						accuracy = normAccLow;
						break;
						
						case 2:
						accuracy = carlAccLow;
						break;
						
						case 3:
						accuracy = squeakersAccLow;
						break;
						
						case 4:
						accuracy = happyAccLow;
						break;
					}
					reload = 0;
				}
			}
		}
		else
		{
			if (!eSwitch)
			{
				eSwitch = true;
			}
		}
		
		if (qKeyDown) //SWITCH WEAPON
		{
			if (qSwitch)
			{
				qSwitch = false;
				
				if (currentWeapon > 1)
				{
					currentWeapon--;
					
					if (currentWeapon == 1)
					{
						switch (currentPlayer) //WHICH PLAYER
						{
							case 1:
							accuracy = normAccLow;
							break;
							
							case 2:
							accuracy = carlAccLow;
							break;
							
							case 3:
							accuracy = squeakersAccLow;
							break;
							
							case 4:
							accuracy = happyAccLow;
							break;
						}
					}
					if ((currentWeapon == 2) && (pistolsUnlocked))
					{
						accuracy = pistolAccLow;
					}
					else
					{
						currentWeapon = 1;
						switch (currentPlayer) //WHICH PLAYER
						{
							case 1:
							accuracy = normAccLow;
							break;
							
							case 2:
							accuracy = carlAccLow;
							break;
							
							case 3:
							accuracy = squeakersAccLow;
							break;
							
							case 4:
							accuracy = happyAccLow;
							break;
						}
						reload = 0;
					}
					
					reload = 0;
				}
				else
				{
					if (rocketsUnlocked)
					{
					currentWeapon = 3;
					
					accuracy = rocketAccLow;
					
					reload = 0;
					}
					else if (pistolsUnlocked)
					{
						currentWeapon = 2;
						
						accuracy = pistolAccLow;
						
						reload = 0;
					}
					else
					{
						currentWeapon = 1;
						
						switch (currentPlayer) //WHICH PLAYER
						{
							case 1:
							accuracy = normAccLow;
							break;
							
							case 2:
							accuracy = carlAccLow;
							break;
							
							case 3:
							accuracy = squeakersAccLow;
							break;
							
							case 4:
							accuracy = happyAccLow;
							break;
						}
						reload = 0;
					}
				}
			}
		}
		else
		{
			if (!qSwitch)
			{
				qSwitch = true;
			}
		}
		
		//SWITCH PLAYER
		if (oneKeyDown)
		{
			if ((currentPlayer != 1) && (normHealth > 0))
			{
				currentPlayer = 1;
				currentWeapon = 1;
				accuracy = normAccLow;
				reload = 0;
			}
		}
		else if (twoKeyDown)
		{
			if ((currentPlayer != 2) && (carlHealth > 0))
			{
				currentPlayer = 2;
				currentWeapon = 1;
				accuracy = carlAccLow;
				reload = 0;
			}
		}
		else if (threeKeyDown)
		{
			if ((currentPlayer != 3) && (squeakersHealth > 0))
			{
				currentPlayer = 3;
				currentWeapon = 1;
				accuracy = squeakersAccLow;
				reload = 0;
			}
		}
		else if (fourKeyDown)
		{
			if ((currentPlayer != 4) && (happyHealth > 0))
			{
				currentPlayer = 4;
				currentWeapon = 1;
				accuracy = happyAccLow;
				reload = 0;
			}
		}
		else if (fiveKeyDown)
		{
			if ((currentPlayer != 5) && (tankHealth > 0))
			{
				currentPlayer = 5;
				currentWeapon = 1;
				accuracy = 10;
				reload = 0;
			}
		}
		//--
		
		if (rKeyDown) //RELOAD
		{
			if (rSwitch)
			{
				rSwitch = false;
				
				switch (currentPlayer)
				{
					case 1:
					if (currentWeapon == 1)
					{
						if ((reload == 0) && (norm_mc.clip < normAmmoCap) && (normAmmo > 0))
						{
							reload = normReload;
							rifleReload.play();
						}
					}
					else if (currentWeapon == 2)
					{
						if ((reload == 0) && (norm_mc.pistolClip < pistolAmmoCap) && (normPistolAmmo > 0))
						{
							reloadPistol.play();
							reload = pistolReload;
						}
					}
					break;
					
					case 2:
					if (currentWeapon == 1)
					{
						if ((reload == 0) && (carl_mc.clip < carlAmmoCap) && (carlAmmo > 0))
						{
							reload = carlReload;
							sniperReload.play();
						}
					}
					else if (currentWeapon == 2)
					{
						if ((reload == 0) && (carl_mc.pistolClip < pistolAmmoCap) && (carlPistolAmmo > 0))
						{
							reloadPistol.play();
							reload = pistolReload;
						}
					}
					break;
					
					case 3:
					if (currentWeapon == 1)
					{
						if ((reload == 0) && (squeakers_mc.clip < squeakersAmmoCap) && (squeakersAmmo > 0))
						{
							reload = squeakersReload;
							shotgunReload.play();
						}
					}
					else if (currentWeapon == 2)
					{
						if ((reload == 0) && (squeakers_mc.pistolClip < pistolAmmoCap) && (squeakersPistolAmmo > 0))
						{
							reloadPistol.play();
							reload = pistolReload;
						}
					}
					break;
					
					case 4:
					if (currentWeapon == 1)
					{
						if ((reload == 0) && (happy_mc.clip < happyAmmoCap) && (happyAmmo > 0))
						{
							reload = happyReload;
							lmgReload.play();
						}
					}
					else if (currentWeapon == 2)
					{
						if ((reload == 0) && (happy_mc.pistolClip < pistolAmmoCap) && (happyPistolAmmo > 0))
						{
							reloadPistol.play();
							reload = pistolReload;
						}
					}
					break;
				}
			}
		}
		else
		{
			if (!rSwitch)
			{
				rSwitch = true;
			}
		}
	}
	
	//ROTATION
	if (!gameOver)
	{
		if (currentPlayer == 1) //NORM
		{
			var c2y:Number = mouseY - (norm_mc.y); 
			var c2x:Number = mouseX - norm_mc.x;
					
			// find out the angle
			var rotRadians2:Number = Math.atan2(c2y,c2x);
					
			// convert to degrees to rotate
			var rotDegrees2:Number = rotRadians2 * 180 / Math.PI;
						
			norm_mc.rotation = rotDegrees2 + 90;
		}
		else if (currentPlayer == 2) //CARL
		{
			var c3y:Number = mouseY - (carl_mc.y); 
			var c3x:Number = mouseX - carl_mc.x;
					
			// find out the angle
			var rotRadians3:Number = Math.atan2(c3y,c3x);
					
			// convert to degrees to rotate
			var rotDegrees3:Number = rotRadians3 * 180 / Math.PI;
						
			carl_mc.rotation = rotDegrees3 + 90;
		}
		else if (currentPlayer == 3) //SQUEAKERS
		{
			var c33y:Number = mouseY - (squeakers_mc.y); 
			var c33x:Number = mouseX - squeakers_mc.x;
					
			// find out the angle
			var rotRadians33:Number = Math.atan2(c33y,c33x);
					
			// convert to degrees to rotate
			var rotDegrees33:Number = rotRadians33 * 180 / Math.PI;
						
			squeakers_mc.rotation = rotDegrees33 + 90;
		}
		else if (currentPlayer == 4) //HAPPY
		{
			var c3ay:Number = mouseY - (happy_mc.y); 
			var c3ax:Number = mouseX - happy_mc.x;
					
			// find out the angle
			var rotRadians3a:Number = Math.atan2(c3ay,c3ax);
					
			// convert to degrees to rotate
			var rotDegrees3a:Number = rotRadians3a * 180 / Math.PI;
						
			happy_mc.rotation = rotDegrees3a + 90;
		}
		else if (currentPlayer == 5) //TANK
		{
			if (tankHealth > 0)
			{
				var c3aym:Number = mouseY - (tank_mc.y); 
				var c3axm:Number = mouseX - tank_mc.x;
						
				// find out the angle
				var rotRadians3am:Number = Math.atan2(c3aym,c3axm);
						
				// convert to degrees to rotate
				var rotDegrees3am:Number = rotRadians3am * 180 / Math.PI;
				
				rotDegrees3am -= tank_mc.rotation;
					
				tank_mc.cannon_mc.rotation =rotDegrees3am + 90;
			}
		}
	}
	
	//CHANGE POSITIONS
	if (!gameOver)
	{
		//FRICTION
		if (currentPlayer == 1)
		{
			if ((playerVert < (0)) && (!upKeyDown))
			{
				playerVert += normAccel;
			}
			if ((playerVert > (0)) && (!downKeyDown))
			{
				playerVert -= normAccel;
			}
			if ((playerHor > (0)) && (!rightKeyDown))
			{
				playerHor -= normAccel;
			}
			if ((playerHor < (0)) && (!leftKeyDown))
			{
				playerHor += normAccel;
			}
		}
		else if (currentPlayer == 2)
		{
			if ((playerVert < (0)) && (!upKeyDown))
			{
				playerVert += carlAccel;
			}
			if ((playerVert > (0)) && (!downKeyDown))
			{
				playerVert -= carlAccel;
			}
			if ((playerHor > (0)) && (!rightKeyDown))
			{
				playerHor -= carlAccel;
			}
			if ((playerHor < (0)) && (!leftKeyDown))
			{
				playerHor += carlAccel;
			}
		}
		else if (currentPlayer == 3)
		{
			if ((playerVert < (0)) && (!upKeyDown))
			{
				playerVert += squeakersAccel;
			}
			if ((playerVert > (0)) && (!downKeyDown))
			{
				playerVert -= squeakersAccel;
			}
			if ((playerHor > (0)) && (!rightKeyDown))
			{
				playerHor -= squeakersAccel;
			}
			if ((playerHor < (0)) && (!leftKeyDown))
			{
				playerHor += squeakersAccel;
			}
		}
		else if (currentPlayer == 4)
		{
			if ((playerVert < (0)) && (!upKeyDown))
			{
				playerVert += happyAccel;
			}
			if ((playerVert > (0)) && (!downKeyDown))
			{
				playerVert -= happyAccel;
			}
			if ((playerHor > (0)) && (!rightKeyDown))
			{
				playerHor -= happyAccel;
			}
			if ((playerHor < (0)) && (!leftKeyDown))
			{
				playerHor += happyAccel;
			}
		}
		
		switch (currentPlayer) //DECIDE WHICH PLAYER TO MOVE
		{
			case 1:
			norm_mc.y += playerVert;
			norm_mc.x += playerHor;
			
			if (norm_mc.x < 20)
			{
				norm_mc.x = 20;
				playerHor = 0;
			}
			if (norm_mc.x > 620)
			{
				norm_mc.x = 620;
				playerHor = 0;
			}
			if (norm_mc.y < 20)
			{
				norm_mc.y = 20;
				playerVert = 0;
			}
			if (norm_mc.y > 460)
			{
				norm_mc.y = 460;
				playerVert = 0;
			}
			break;
			
			case 2:
			carl_mc.y += playerVert;
			carl_mc.x += playerHor;
			
			if (carl_mc.x < 20)
			{
				carl_mc.x = 20;
				playerHor = 0;
			}
			if (carl_mc.x > 620)
			{
				carl_mc.x = 620;
				playerHor = 0;
			}
			if (carl_mc.y < 20)
			{
				carl_mc.y = 20;
				playerVert = 0;
			}
			if (carl_mc.y > 460)
			{
				carl_mc.y = 460;
				playerVert = 0;
			}
			break;
			
			case 3:
			squeakers_mc.y += playerVert;
			squeakers_mc.x += playerHor;
			
			if (squeakers_mc.x < 20)
			{
				squeakers_mc.x = 20;
				playerHor = 0;
			}
			if (squeakers_mc.x > 620)
			{
				squeakers_mc.x = 620;
				playerHor = 0;
			}
			if (squeakers_mc.y < 20)
			{
				squeakers_mc.y = 20;
				playerVert = 0;
			}
			if (squeakers_mc.y > 460)
			{
				squeakers_mc.y = 460;
				playerVert = 0;
			}
			break;
			
			case 4:
			happy_mc.y += playerVert;
			happy_mc.x += playerHor;
			
			if (happy_mc.x < 20)
			{
				happy_mc.x = 20;
				playerHor = 0;
			}
			if (happy_mc.x > 620)
			{
				happy_mc.x = 620;
				playerHor = 0;
			}
			if (happy_mc.y < 20)
			{
				happy_mc.y = 20;
				playerVert = 0;
			}
			if (happy_mc.y > 460)
			{
				happy_mc.y = 460;
				playerVert = 0;
			}
			break;
			
			case 5:
			if (tank_mc.x < 40)
			{
				tank_mc.x = 40;
			}
			if (tank_mc.x > 600)
			{
				tank_mc.x = 600;
			}
			if (tank_mc.y < 40)
			{
				tank_mc.y = 40;
			}
			if (tank_mc.y > 440)
			{
				tank_mc.y = 440;
			}
			break;
		}
	}
	
	
	//RELOAD
	{
		if (reload > 0) //EXECUTE RELOAD
		{
			reload--;
			if (reload == 0)
			{
				switch (currentPlayer)
				{
					case 1:
					if (currentWeapon == 1)
					{
						norm_mc.reloadMain();
					}
					else if (currentWeapon == 2)
					{
						norm_mc.reloadPistol();
					}
					break;
					
					case 2:
					if (currentWeapon == 1)
					{
						carl_mc.reloadMain();
					}
					else if (currentWeapon == 2)
					{
						carl_mc.reloadPistol();
					}
					break;
					
					case 3:
					if (currentWeapon == 1)
					{
						squeakers_mc.reloadMain();
					}
					else if (currentWeapon == 2)
					{
						squeakers_mc.reloadPistol();
					}
					break;
					
					case 4:
					if (currentWeapon == 1)
					{
						happy_mc.reloadMain();
					}
					else if (currentWeapon == 2)
					{
						happy_mc.reloadPistol();
					}
					break;
				}
			}
		}
		
		if (reload == 0) //START RELOAD IF ON EMPTY
		{
		switch (currentPlayer) 
		{
			case 1:
			if ((currentWeapon == 1) && (norm_mc.clip == 0))
			{
				if (normAmmo > 0)
				{
					reload = normReload;
					rifleReload.play();
				}
			}
			else if ((currentWeapon == 2) && (norm_mc.pistolClip == 0))
			{
				if (normPistolAmmo > 0)
				{
					reloadPistol.play();
					reload = pistolReload;
				}
			}
			break;
			
			case 2:
			if ((currentWeapon == 1) && (carl_mc.clip == 0))
			{
				if (carlAmmo > 0)
				{
					reload = carlReload;
					sniperReload.play();
				}
			}
			else if ((currentWeapon == 2) && (carl_mc.pistolClip == 0))
			{
				if (carlPistolAmmo > 0)
				{
					reloadPistol.play();
					reload = pistolReload;
				}
			}
			break;
			
			case 3:
			if ((currentWeapon == 1) && (squeakers_mc.clip == 0))
			{
				if (squeakersAmmo > 0)
				{
					reload = squeakersReload;
					shotgunReload.play();
				}
			}
			else if ((currentWeapon == 2) && (squeakers_mc.pistolClip == 0))
			{
				if (squeakersPistolAmmo > 0)
				{
					reloadPistol.play();
					reload = pistolReload;
				}
			}
			break;
			
			case 4:
			if ((currentWeapon == 1) && (happy_mc.clip == 0))
			{
				if (happyAmmo > 0)
				{
					reload = happyReload;
					lmgReload.play();
				}
			}
			else if ((currentWeapon == 2) && (happy_mc.pistolClip == 0))
			{
				if (happyPistolAmmo > 0)
				{
					reloadPistol.play();
					reload = pistolReload;
				}
			}
			break;
		}
		}
	}
	
	switch (currentPlayer) //SWITCH PLAYER IF INJURED
	{
		case 1:
		if (normHealth <= 0)
		{
			if (carlHealth > 0)
			{
				currentPlayer = 2;
			}
			else if (squeakersHealth > 0)
			{
				currentPlayer = 3;
			}
			else if (happyHealth > 0)
			{
				currentPlayer = 4;
			}
			else if (tankHealth > 0)
			{
				currentPlayer = 5;
			}
			else
			{
				//GAME OVER
			}
		}
		break;
		
		case 2:
		if (carlHealth <= 0)
		{
			if (squeakersHealth > 0)
			{
				currentPlayer = 3;
			}
			else if (happyHealth > 0)
			{
				currentPlayer = 4;
			}
			else if (tankHealth > 0)
			{
				currentPlayer = 5;
			}
			else if (normHealth > 0)
			{
				currentPlayer = 1;
			}
			else
			{
				//GAME OVER
			}
		}
		break;
		
		case 3:
		if (squeakersHealth <= 0)
		{
			if (happyHealth > 0)
			{
				currentPlayer = 4;
			}
			else if (tankHealth > 0)
			{
				currentPlayer = 5;
			}
			else if (normHealth > 0)
			{
				currentPlayer = 1;
			}
			else if (carlHealth > 0)
			{
				currentPlayer = 2;
			}
			else
			{
				//GAME OVER
			}
		}
		break;
		
		case 4:
		if (happyHealth <= 0)
		{
			if (tankHealth > 0)
			{
				currentPlayer = 5;
			}
			else if (normHealth > 0)
			{
				currentPlayer = 1;
			}
			else if (carlHealth > 0)
			{
				currentPlayer = 2;
			}
			else if (squeakersHealth > 0)
			{
				currentPlayer = 3;
			}
			else
			{
				//GAME OVER
			}
		}
		break;
		
		case 5:
		if (tankHealth <= 0)
		{
			if (normHealth > 0)
			{
				currentPlayer = 1;
			}
			else if (carlHealth > 0)
			{
				currentPlayer = 2;
			}
			else if (squeakersHealth > 0)
			{
				currentPlayer = 3;
			}
			else if (happyHealth > 0)
			{
				currentPlayer = 4;
			}
			else
			{
				//GAME OVER
			}
		}
		break;
	}
	
	if (currentPlayer == 5) //TANK THEM WEAPON 1
	{
		currentWeapon = 1;
		accuracy = 30;
	}
	
	if ((normHealth <= 0) && (carlHealth <= 0) && (squeakersHealth <= 0) && (happyHealth <= 0) && (tankHealth <= 0))
	{
		if (gameOver == false)
		{
			gameOver = true;
			fadeOut_mc.gotoAndPlay(2);
		}
	}
	}
}

function animations(evt:Event):void //ANIMATE ALL OBJECTS
{
	if (currentPlayer == 1)
	{
		if (normHealth <= 0)
		{
			norm_mc.gotoAndStop(5);
		}
		else
		{
			switch (currentWeapon)
			{
				case 1:
				norm_mc.gotoAndStop(1);
				break;
				
				case 2:
				norm_mc.gotoAndStop(2);
				break;
				
				case 3:
				norm_mc.gotoAndStop(3);
				break;
			}
		}
	}
	else if (currentPlayer == 2)
	{
		if (carlHealth <= 0)
		{
			carl_mc.gotoAndStop(5);
		}
		else
		{
			switch (currentWeapon)
			{
				case 1:
				carl_mc.gotoAndStop(1);
				break;
				
				case 2:
				carl_mc.gotoAndStop(2);
				break;
				
				case 3:
				carl_mc.gotoAndStop(3);
				break;
			}
		}
	}
	else if (currentPlayer == 3)
	{
		if (squeakersHealth <= 0)
		{
			squeakers_mc.gotoAndStop(5);
		}
		else
		{
			switch (currentWeapon)
			{
				case 1:
				squeakers_mc.gotoAndStop(1);
				break;
				
				case 2:
				squeakers_mc.gotoAndStop(2);
				break;
				
				case 3:
				squeakers_mc.gotoAndStop(3);
				break;
			}
		}
	}
	else if (currentPlayer == 4)
	{
		if (happyHealth <= 0)
		{
			happy_mc.gotoAndStop(5);
		}
		else
		{
			switch (currentWeapon)
			{
				case 1:
				happy_mc.gotoAndStop(1);
				break;
				
				case 2:
				happy_mc.gotoAndStop(2);
				break;
				
				case 3:
				happy_mc.gotoAndStop(3);
				break;
			}
		}
	}
	
	for (var e1a:Number = enemiesOne.length - 1; e1a >= 0; e1a--) //UPDATE ENEMYONES
	{
		if ((enemiesOne[e1a].health <= 0) && (enemiesOne[e1a].currentFrame == 1))
		{
			if (enemiesOne[e1a].inbounds) //DROP AMMO
			{
				if ((Math.floor(Math.random() * (4 - 1 + 1)) + 1) == 1)
				{
					if (pistolsUnlocked)
					{
						tempR2 = (Math.floor(Math.random() * (2 - 1 + 1)) + 1);
					}
					else
					{
						tempR2 = 1;
					}
					
					if (tempR2 == 1)
					{
						am = new ammoSymbol;
						addChild(am);
						am.x = enemiesOne[e1a].x;
						am.y = enemiesOne[e1a].y;
						am.filters = [dropShadow];
						ammo.push(am);
					}
					else
					{
						am = new pistolAmmoSymbol;
						addChild(am);
						am.x = enemiesOne[e1a].x;
						am.y = enemiesOne[e1a].y;
						am.filters = [dropShadow];
						ammo.push(am);
					}
				}
			}
			
			if (enemiesOne[e1a] is enemyTank) //SPLODE
			{
				tankExplode.play();
				addBigFlash(enemiesOne[e1a].x, enemiesOne[e1a].y);
				_largeExplosion.create(enemiesOne[e1a].x, enemiesOne[e1a].y);
			}
			
			enemiesOne[e1a].gotoAndPlay(2);
		}
		else if (enemiesOne[e1a].currentFrame == 105)
		{
			removeChild(enemiesOne[e1a]);
			enemiesOne[e1a] = null;
			enemiesOne.splice(e1a, 1);
		}
	}
	
	if (carl_mc != null) //ANIMATE CARL IF NOT CONTROLLED
	{
		if (currentPlayer != 2)
		{
			if (carlHealth <= 0)
			{
				carl_mc.gotoAndStop(5);
			}
			else
			{
				switch (carl_mc.carlCurrentWeapon)
				{
					case 1:
					carl_mc.gotoAndStop(1);
					break;
					
					case 2:
					carl_mc.gotoAndStop(2);
					break;
				}
			}
		}
	}
	
	if (norm_mc != null) //ANIMATE NORM IF NOT CONTROLLED
	{
		if (currentPlayer != 1)
		{
			if (normHealth <= 0)
			{
				norm_mc.gotoAndStop(5);
			}
			else
			{
				switch (norm_mc.normCurrentWeapon)
				{
					case 1:
					norm_mc.gotoAndStop(1);
					break;
					
					case 2:
					norm_mc.gotoAndStop(2);
					break;
				}
			}
		}
	}
	
	if (squeakers_mc != null) //ANIMATE SQUEAKERS IF NOT CONTROLLED
	{
		if (currentPlayer != 3)
		{
			if (squeakersHealth <= 0)
			{
				squeakers_mc.gotoAndStop(5);
			}
			else
			{
				switch (squeakers_mc.squeakersCurrentWeapon)
				{
					case 1:
					squeakers_mc.gotoAndStop(1);
					break;
					
					case 2:
					squeakers_mc.gotoAndStop(2);
					break;
				}
			}
		}
	}
	
	if (happy_mc != null) //ANIMATE HAPPY IF NOT CONTROLLED
	{
		if (currentPlayer != 4)
		{
			if (happyHealth <= 0)
			{
				happy_mc.gotoAndStop(5);
			}
			else
			{
				switch (happy_mc.happyCurrentWeapon)
				{
					case 1:
					happy_mc.gotoAndStop(1);
					break;
					
					case 2:
					happy_mc.gotoAndStop(2);
					break;
				}
			}
		}
	}
	
	if (tank_mc != null) //TANK
	{
		if (tank_mc.currentFrame == 105)
		{
			tank_mc.visible = false;
		}
	}
	
	if ((fade_mc.currentFrame == 119) && (currentWave == 0)) //START TUTORIAL
	{
		tutTimer.start();
		waveTimer.start();
	}
	
	if (fadeOut_mc.currentFrame == 119)
	{
		if (!mute)
		{
			bs.volume = 1;
			SoundMixer.soundTransform = bs;
		}
		if ((quitButton_btn.visible == true) || (pauseGame))
		{
			calmTrackChannel.stop();
			actionTrackChannel.stop();
			exciteTrackChannel.stop();
			saveGame();
			removeEventListeners();
			removeObjects();
			exciteTimer.stop();
			gotoAndStop(4);
		}
		else if (gameOver)
		{
			if (currentWave == 21)
			{
				calmTrackChannel.stop();
				actionTrackChannel.stop();
				exciteTrackChannel.stop();
				removeEventListeners();
				removeObjects();
				exciteTimer.stop();
				gotoAndStop(8);
			}
			else
			{
				calmTrackChannel.stop();
				actionTrackChannel.stop();
				exciteTrackChannel.stop();
				removeEventListeners();
				removeObjects();
				exciteTimer.stop();
				gotoAndStop(9);
			}
		}
	}
	else if (fadeOut_mc.currentFrame != 1)
	{
		if ((bs.volume > 0) && (!mute))
		{
			bs.volume -= .02;
			SoundMixer.soundTransform = bs;
		}
	}
	
	// update the explosion instance every frame
	_smallExplosion.update();
	_mediumExplosion.update();
	_largeExplosion.update();
}

function animMouse(evt:Event):void //HANDLES ALL MOUSE RELATED ACTIVITIES
{
	cursor_mc.x = mouseX;
	cursor_mc.y = mouseY;
	cursor_mc.mouseEnabled = false;
	Mouse.hide();
	
	//Controls each individual crosshair using var accuracy
	cursor_mc.crossHair1_mc.x = (accuracy * -1);
	cursor_mc.crossHair1_mc.y = 0;
	cursor_mc.crossHair2_mc.x = accuracy;
	cursor_mc.crossHair2_mc.y = 0;
	cursor_mc.crossHair3_mc.y = accuracy;
	cursor_mc.crossHair3_mc.x = 0;
	cursor_mc.crossHair4_mc.y = (accuracy * -1);
	cursor_mc.crossHair4_mc.x = 0;
}

function addGunFlash(xg:Number, yg:Number):void //MAKES GUN FLASH AT LOCATION
{
	guf2 = new gunFlash;
	guf2.x = xg;
	guf2.y = yg;
	
	
	guf2.alpha = .4;
	guf2.filters = [blurFilter1];
	addChild(guf2);
	gunFlashes.push(guf2);
	
	guf = new gunFlash;
	black_mc.addChild(guf);
	guf.x = xg;
	guf.y = yg;
	guf.blendMode = "erase";
	guf.filters = [blurFilter1];
	gunFlashes.push(guf);
}

function addBigFlash(xg:Number, yg:Number):void //MAKES GUN FLASH AT LOCATION
{
	guf2 = new gunFlash;
	guf2.x = xg;
	guf2.y = yg;
	guf2.alpha = .4;
	guf2.filters = [blurFilter1];
	guf2.width *= 7;
	guf2.height *= 7;
	addChild(guf2);
	gunFlashes.push(guf2);
	
	guf = new gunFlash;
	black_mc.addChild(guf);
	guf.x = xg;
	guf.y = yg;
	guf.width *= 7;
	guf.height *= 7;
	guf.filters = [blurFilter1];
	guf.blendMode = "erase";
	gunFlashes.push(guf);
}

function useWeapon(evt:Event):void //USE WEAPONS
{
	if ((mouseIsDown) && (nextWaveButton_btn.visible == false) && (!gameOver) && (!pauseGame))
	{
		if (fireRate > 0)
		{
			fireRate--;
		}
		else
		{
			if ((currentWeapon == 1) && (reload == 0)) //FIRE PRIMARY
			{
				switch (currentPlayer)
				{
					case 1:
					{
						if (norm_mc.clip > 0)
						{
						pb = new normBullet;
						pb.cacheAsBitmap = true;
						addChild(pb);
						
						addGunFlash(norm_mc.x, norm_mc.y);
						
						if((Math.floor(Math.random() * (1 - 0 + 1)) + 0) == 0)
						{
							pb.rotation = (norm_mc.rotation - 90) + (Math.floor(Math.random() * (accuracy - (-1 * accuracy) + 1)) + (-1 * accuracy))/22;
						}
						else
						{
							pb.rotation = ((norm_mc.rotation - 90) + ((Math.floor(Math.random() * (accuracy - (-1 * accuracy) + 1)) + (-1 * accuracy))/22) * -1);
						}
						
						pb.x = norm_mc.x;
						pb.y = norm_mc.y;
						bullets.push(pb);
						
						if (accuracy < normAccHigh)
						{
							accuracy += normAccRise;
						}
						
						norm_mc.rifle_mc.gotoAndPlay(2);
						assaultShot.play();
						fireRate = normFireRate;
						norm_mc.clip--;
						}
						else
						{
							if (normAmmo > 0)
							{
								reload = normReload;
								rifleReload.play();
							}
							else
							{
								if (!emptyGunIsPlaying) //PLAY SOUND ON EMPTY
								{
									emptyGun.play();
									emptyGunIsPlaying = true;
								}
							}
						}
					}
					break;
					
					case 2:
					{
						if (carl_mc.clip > 0)
						{
						pb = new carlBullet;
						pb.cacheAsBitmap = true;
						addChild(pb);
						pb.x = carl_mc.x;
						pb.y = carl_mc.y;
						
						addGunFlash(carl_mc.x, carl_mc.y);
						
						if((Math.floor(Math.random() * (1 - 0 + 1)) + 0) == 0)
						{
							pb.rotation = (carl_mc.rotation - 90) + (Math.floor(Math.random() * (accuracy - (-1 * accuracy) + 1)) + (-1 * accuracy))/22;
						}
						else
						{
							pb.rotation = ((carl_mc.rotation - 90) + ((Math.floor(Math.random() * (accuracy - (-1 * accuracy) + 1)) + (-1 * accuracy))/22) * -1);
						}
						
						bullets.push(pb);
						
						if (accuracy < carlAccHigh)
						{
							accuracy += carlAccRise;
						}
						
						carl_mc.rifle_mc.gotoAndPlay(2);
						sniperShot.play();
						fireRate = carlFireRate;
						carl_mc.clip--;
						}
						else
						{
							if (carlAmmo > 0)
							{
								reload = carlReload;
								sniperReload.play();
							}
							else
							{
								if (!emptyGunIsPlaying) //PLAY SOUND ON EMPTY
								{
									emptyGun.play();
									emptyGunIsPlaying = true;
								}
							}
						}
					}
					break;
					
					case 3:
					{
						if (squeakers_mc.clip > 0)
						{
						
						for (var hg:Number = 5; hg >= 0; hg--)
						{
							pb = new squeakersBullet;
							addChild(pb);
							pb.cacheAsBitmap = true;
							pb.x = squeakers_mc.x;
							pb.y = squeakers_mc.y;
							
							if((Math.floor(Math.random() * (1 - 0 + 1)) + 0) == 0)
							{
								pb.rotation = (squeakers_mc.rotation - 90) + (Math.floor(Math.random() * (accuracy - (-1 * accuracy) + 1)) + (-1 * accuracy))/22;
							}
							else
							{
								pb.rotation = ((squeakers_mc.rotation - 90) + ((Math.floor(Math.random() * (accuracy - (-1 * accuracy) + 1)) + (-1 * accuracy))/22) * -1);
							}
							bullets.push(pb);
						}
						addGunFlash(squeakers_mc.x, squeakers_mc.y);
						
						if (accuracy < squeakersAccHigh)
						{
							accuracy += squeakersAccRise;
						}
						
						squeakers_mc.rifle_mc.gotoAndPlay(2);
						shotgunShot.play();
						fireRate = squeakersFireRate;
						squeakers_mc.clip--;
						}
						else
						{
							if (squeakersAmmo > 0)
							{
								reload = squeakersReload;
								shotgunReload.play();
							}
							else
							{
								if (!emptyGunIsPlaying) //PLAY SOUND ON EMPTY
								{
									emptyGun.play();
									emptyGunIsPlaying = true;
								}
							}
						}
					}
					break;
					
					case 4:
					{
						if (happy_mc.clip > 0)
						{
						pb = new happyBullet;
						addChild(pb);
						pb.cacheAsBitmap = true;
						
						addGunFlash(happy_mc.x, happy_mc.y);
						
						if((Math.floor(Math.random() * (1 - 0 + 1)) + 0) == 0)
						{
							pb.rotation = (happy_mc.rotation - 90) + (Math.floor(Math.random() * (accuracy - (-1 * accuracy) + 1)) + (-1 * accuracy))/22;
						}
						else
						{
							pb.rotation = ((happy_mc.rotation - 90) + ((Math.floor(Math.random() * (accuracy - (-1 * accuracy) + 1)) + (-1 * accuracy))/22) * -1);
						}
						
						pb.x = happy_mc.x;
						pb.y = happy_mc.y;
						bullets.push(pb);
						
						if (accuracy < happyAccHigh)
						{
							accuracy += happyAccRise;
						}
						
						happy_mc.rifle_mc.gotoAndPlay(2);
						lmgShot.play();
						fireRate = happyFireRate;
						happy_mc.clip--;
						}
						else
						{
							if (happyAmmo > 0)
							{
								reload = happyReload;
								lmgReload.play();
							}
							else
							{
								if (!emptyGunIsPlaying) //PLAY SOUND ON EMPTY
								{
									emptyGun.play();
									emptyGunIsPlaying = true;
								}
							}
						}
					}
					break;
					
					case 5:
					{
						pb = new tankRocket;
						addChild(pb);
						pb.cacheAsBitmap = true;
						
						addGunFlash(tank_mc.x, tank_mc.y);
						
						pb.rotation = tank_mc.cannon_mc.rotation + tank_mc.rotation - 90;
						
						pb.x = tank_mc.x;
						pb.y = tank_mc.y;
						bullets.push(pb);
						
						tank_mc.cannon_mc.gotoAndPlay(2);
						tankShot.play();
						tankReload.play();
						fireRate = tankFireRate;
					}
					break;
				}
			}
			if ((currentWeapon == 2) && (reload == 0)) //FIRE PISTOL
			{
				switch (currentPlayer)
				{
					case 1:
					{
						if (norm_mc.pistolClip > 0)
						{
						pb = new pistolBullet;
						pb.tag = currentPlayer;
						addChild(pb);
						pb.cacheAsBitmap = true;
						addGunFlash(norm_mc.x, norm_mc.y);
						
						if((Math.floor(Math.random() * (1 - 0 + 1)) + 0) == 0)
						{
							pb.rotation = (norm_mc.rotation - 90) + (Math.floor(Math.random() * (accuracy - (-1 * accuracy) + 1)) + (-1 * accuracy))/22;
						}
						else
						{
							pb.rotation = ((norm_mc.rotation - 90) + ((Math.floor(Math.random() * (accuracy - (-1 * accuracy) + 1)) + (-1 * accuracy))/22) * -1);
						}
						
						pb.x = norm_mc.x;
						pb.y = norm_mc.y;
						bullets.push(pb);
						
						if (accuracy < pistolAccHigh)
						{
							accuracy += pistolAccRise;
						}
						
						
						norm_mc.pistol_mc.gotoAndPlay(2);
						pistolShot.play();
						fireRate = 15;
						norm_mc.pistolClip--;
						}
						else
						{
							if (normPistolAmmo > 0)
							{
								reloadPistol.play();
								reload = pistolReload;
							}
							else
							{
								if (!emptyGunIsPlaying) //PLAY SOUND ON EMPTY
								{
									emptyGun.play();
									emptyGunIsPlaying = true;
								}
							}
						}
					}
					break;
					
					case 2:
					{
						if (carl_mc.pistolClip > 0)
						{
						pb = new pistolBullet;
						pb.tag = currentPlayer;
						addChild(pb);
						pb.cacheAsBitmap = true;
						
						addGunFlash(carl_mc.x, carl_mc.y);
						
						if((Math.floor(Math.random() * (1 - 0 + 1)) + 0) == 0)
						{
							pb.rotation = (carl_mc.rotation - 90) + (Math.floor(Math.random() * (accuracy - (-1 * accuracy) + 1)) + (-1 * accuracy))/22;
						}
						else
						{
							pb.rotation = ((carl_mc.rotation - 90) + ((Math.floor(Math.random() * (accuracy - (-1 * accuracy) + 1)) + (-1 * accuracy))/22) * -1);
						}
						
						pb.x = carl_mc.x;
						pb.y = carl_mc.y;
						bullets.push(pb);
						
						if (accuracy < pistolAccHigh)
						{
							accuracy += pistolAccRise;
						}
						
						carl_mc.pistol_mc.gotoAndPlay(2);
						pistolShot.play();
						fireRate = 15;
						carl_mc.pistolClip--;
						}
						else
						{
							if (carlPistolAmmo > 0)
							{
								reloadPistol.play();
								reload = pistolReload;
							}
							else
							{
								if (!emptyGunIsPlaying) //PLAY SOUND ON EMPTY
								{
									emptyGun.play();
									emptyGunIsPlaying = true;
								}
							}
						}
					}
					break;
					
					case 3:
					{
						if (squeakers_mc.pistolClip > 0)
						{
						pb = new pistolBullet;
						pb.tag = currentPlayer;
						addChild(pb);
						pb.cacheAsBitmap = true;
						
						addGunFlash(squeakers_mc.x, squeakers_mc.y);
						
						if((Math.floor(Math.random() * (1 - 0 + 1)) + 0) == 0)
						{
							pb.rotation = (squeakers_mc.rotation - 90) + (Math.floor(Math.random() * (accuracy - (-1 * accuracy) + 1)) + (-1 * accuracy))/22;
						}
						else
						{
							pb.rotation = ((squeakers_mc.rotation - 90) + ((Math.floor(Math.random() * (accuracy - (-1 * accuracy) + 1)) + (-1 * accuracy))/22) * -1);
						}
						
						pb.x = squeakers_mc.x;
						pb.y = squeakers_mc.y;
						bullets.push(pb);
						
						if (accuracy < pistolAccHigh)
						{
							accuracy += pistolAccRise;
						}
						
						squeakers_mc.pistol_mc.gotoAndPlay(2);
						pistolShot.play();
						fireRate = 15;
						squeakers_mc.pistolClip--;
						}
						else
						{
							if (squeakersPistolAmmo > 0)
							{
								reloadPistol.play();
								reload = pistolReload;
							}
							else
							{
								if (!emptyGunIsPlaying) //PLAY SOUND ON EMPTY
								{
									emptyGun.play();
									emptyGunIsPlaying = true;
								}
							}
						}
					}
					break;
					
					case 4:
					{
						if (happy_mc.pistolClip > 0)
						{
						pb = new pistolBullet;
						pb.tag = currentPlayer;
						addChild(pb);
						pb.cacheAsBitmap = true;
						
						addGunFlash(happy_mc.x, happy_mc.y);
						
						if((Math.floor(Math.random() * (1 - 0 + 1)) + 0) == 0)
						{
							pb.rotation = (happy_mc.rotation - 90) + (Math.floor(Math.random() * (accuracy - (-1 * accuracy) + 1)) + (-1 * accuracy))/22;
						}
						else
						{
							pb.rotation = ((happy_mc.rotation - 90) + ((Math.floor(Math.random() * (accuracy - (-1 * accuracy) + 1)) + (-1 * accuracy))/22) * -1);
						}
						
						pb.x = happy_mc.x;
						pb.y = happy_mc.y;
						bullets.push(pb);
						
						if (accuracy < pistolAccHigh)
						{
							accuracy += pistolAccRise;
						}
						
						happy_mc.pistol_mc.gotoAndPlay(2);
						pistolShot.play();
						fireRate = 15;
						happy_mc.pistolClip--;
						}
						else
						{
							if (happyPistolAmmo > 0)
							{
								reloadPistol.play();
								reload = pistolReload;
							}
							else
							{
								if (!emptyGunIsPlaying) //PLAY SOUND ON EMPTY
								{
									emptyGun.play();
									emptyGunIsPlaying = true;
								}
							}
						}
					}
					break;
				}
			}
			if ((currentWeapon == 3) && (reload == 0)) //FIRE ROCKET
			{
				if (rocketAmmo > 0)
				{
					switch (currentPlayer)
					{
						case 1:
						{
							var r = new rocket;
							bullets.push(r);
							r.tag = currentPlayer;
							addChild(r);
							r.cacheAsBitmap = true;
							addGunFlash(norm_mc.x, norm_mc.y);
							rocketLaunch.play();
							
							if((Math.floor(Math.random() * (1 - 0 + 1)) + 0) == 0)
							{
								r.rotation = (norm_mc.rotation - 90) + (Math.floor(Math.random() * (accuracy - (-1 * accuracy) + 1)) + (-1 * accuracy))/22;
							}
							else
							{
								r.rotation = ((norm_mc.rotation - 90) + ((Math.floor(Math.random() * (accuracy - (-1 * accuracy) + 1)) + (-1 * accuracy))/22) * -1);
							}
							
							r.x = norm_mc.x;
							r.y = norm_mc.y;
							
							if (accuracy < rocketAccHigh)
							{
								accuracy += rocketAccRise;
							}
							
							norm_mc.rocketLauncher_mc.gotoAndPlay(2);
							//pistolShot.play();
							fireRate = 30;
						}
						break;
						
						case 2:
						{
							var r2 = new rocket;
							bullets.push(r2);
							r2.tag = currentPlayer;
							addChild(r2);
							r2.cacheAsBitmap = true;
							rocketLaunch.play();
							
							addGunFlash(carl_mc.x, carl_mc.y);
							
							if((Math.floor(Math.random() * (1 - 0 + 1)) + 0) == 0)
							{
								r2.rotation = (carl_mc.rotation - 90) + (Math.floor(Math.random() * (accuracy - (-1 * accuracy) + 1)) + (-1 * accuracy))/22;
							}
							else
							{
								r2.rotation = ((carl_mc.rotation - 90) + ((Math.floor(Math.random() * (accuracy - (-1 * accuracy) + 1)) + (-1 * accuracy))/22) * -1);
							}
							
							r2.x = carl_mc.x;
							r2.y = carl_mc.y;
							
							if (accuracy < rocketAccHigh)
							{
								accuracy += rocketAccRise;
							}
							
							carl_mc.rocketLauncher_mc.gotoAndPlay(2);
							//pistolShot.play();
							fireRate = 30;
						}
						break;
						
						case 3:
						{
							var r2s = new rocket;
							bullets.push(r2s);
							r2s.tag = currentPlayer;
							addChild(r2s);
							r2s.cacheAsBitmap = true;
							rocketLaunch.play();
							
							addGunFlash(squeakers_mc.x, squeakers_mc.y);
							
							if((Math.floor(Math.random() * (1 - 0 + 1)) + 0) == 0)
							{
								r2s.rotation = (squeakers_mc.rotation - 90) + (Math.floor(Math.random() * (accuracy - (-1 * accuracy) + 1)) + (-1 * accuracy))/22;
							}
							else
							{
								r2s.rotation = ((squeakers_mc.rotation - 90) + ((Math.floor(Math.random() * (accuracy - (-1 * accuracy) + 1)) + (-1 * accuracy))/22) * -1);
							}
							
							r2s.x = squeakers_mc.x;
							r2s.y = squeakers_mc.y;
							
							if (accuracy < rocketAccHigh)
							{
								accuracy += rocketAccRise;
							}
							
							squeakers_mc.rocketLauncher_mc.gotoAndPlay(2);
							//pistolShot.play();
							fireRate = 30;
						}
						break;
						
						case 4:
						{
							var r2sh = new rocket;
							bullets.push(r2sh);
							r2sh.tag = currentPlayer;
							addChild(r2sh);
							r2sh.cacheAsBitmap = true;
							rocketLaunch.play();
							
							addGunFlash(happy_mc.x, happy_mc.y);
							
							if((Math.floor(Math.random() * (1 - 0 + 1)) + 0) == 0)
							{
								r2sh.rotation = (happy_mc.rotation - 90) + (Math.floor(Math.random() * (accuracy - (-1 * accuracy) + 1)) + (-1 * accuracy))/22;
							}
							else
							{
								r2sh.rotation = ((happy_mc.rotation - 90) + ((Math.floor(Math.random() * (accuracy - (-1 * accuracy) + 1)) + (-1 * accuracy))/22) * -1);
							}
							
							r2sh.x = happy_mc.x;
							r2sh.y = happy_mc.y;
							
							if (accuracy < rocketAccHigh)
							{
								accuracy += rocketAccRise;
							}
							
							happy_mc.rocketLauncher_mc.gotoAndPlay(2);
							//pistolShot.play();
							fireRate = 30;
						}
						break;
					}
					rocketAmmo--;
				}
				else
				{
					emptyGun.play();
					fireRate = 30;
				}
			}
		}
	}
}

function afterWeapon(evt:Event):void //AFTER WEAPONS
{
	if (!mouseIsDown)
	{
		if (currentWeapon == 2)
		{
			fireRate = 0;
		}
		else if (fireRate > 0)
		{
			fireRate--;
		}
		
		if (emptyGunIsPlaying)
		{
			emptyGunIsPlaying = false;
		}
		
		//REGAIN ACCURACY
		if (currentPlayer == 1) //NORM
		{
			if (currentWeapon == 1)
			{
				if (accuracy > normAccLow)
				{
					accuracy -= normAccFall;
				}
				else
				{
					accuracy = normAccLow;
				}
			}
			else if (currentWeapon == 2)
			{
				if (accuracy > pistolAccLow)
				{
					accuracy -= pistolAccFall;
				}
				else
				{
					accuracy = pistolAccLow;
				}
			}
			else if (currentWeapon == 3)
			{
				if (accuracy > rocketAccLow)
				{
					accuracy -= rocketAccFall;
				}
				else
				{
					accuracy = rocketAccLow;
				}
			}
		}
		else if (currentPlayer == 2) //CARL
		{
			if (currentWeapon == 1)
			{
				if (accuracy > carlAccLow)
				{
					accuracy -= carlAccFall;
				}
				else
				{
					accuracy = carlAccLow;
				}
			}
			else if (currentWeapon == 2)
			{
				if (accuracy > pistolAccLow)
				{
					accuracy -= pistolAccFall;
				}
				else
				{
					accuracy = pistolAccLow;
				}
			}
			else if (currentWeapon == 3)
			{
				if (accuracy > rocketAccLow)
				{
					accuracy -= rocketAccFall;
				}
				else
				{
					accuracy = rocketAccLow;
				}
			}
		}
		else if (currentPlayer == 3) //SQUEAKERS
		{
			if (currentWeapon == 1)
			{
				if (accuracy > squeakersAccLow)
				{
					accuracy -= squeakersAccFall;
				}
				else
				{
					accuracy = squeakersAccLow;
				}
			}
			else if (currentWeapon == 2)
			{
				if (accuracy > pistolAccLow)
				{
					accuracy -= pistolAccFall;
				}
				else
				{
					accuracy = pistolAccLow;
				}
			}
			else if (currentWeapon == 3)
			{
				if (accuracy > rocketAccLow)
				{
					accuracy -= rocketAccFall;
				}
				else
				{
					accuracy = rocketAccLow;
				}
			}
		}
		else if (currentPlayer == 4) //HAPPY
		{
			if (currentWeapon == 1)
			{
				if (accuracy > happyAccLow)
				{
					accuracy -= happyAccFall;
				}
				else
				{
					accuracy = happyAccLow;
				}
			}
			else if (currentWeapon == 2)
			{
				if (accuracy > pistolAccLow)
				{
					accuracy -= pistolAccFall;
				}
				else
				{
					accuracy = pistolAccLow;
				}
			}
			else if (currentWeapon == 3)
			{
				if (accuracy > rocketAccLow)
				{
					accuracy -= rocketAccFall;
				}
				else
				{
					accuracy = rocketAccLow;
				}
			}
		}
	}
}

function mouseUps(evt:MouseEvent):void //MOUSE IS UP
{
	mouseIsDown = false;
}

function mouseDowns(evt:MouseEvent):void //MOUSE IS DOWN
{
	mouseIsDown = true;
}

function updateObjects(evt:Event):void //UPDATE OBJECTS
{
	if (!pauseGame)
	{
	for (var bu:Number = bullets.length - 1; bu >= 0; bu--) //UPDATE BULLETS
	{
		bullets[bu].updateBullet();
		
		//OFF STAGE - REMOVE
		if ((bullets[bu].x < (-20)) || (bullets[bu].x > 660) || (bullets[bu].y < (-20)) || (bullets[bu].y > 500))
		{
			removeChild(bullets[bu]);
			bullets[bu] = null;
			bullets.splice(bu, 1);
		}
		else //HIT TESTS
		{
			for (var ce1:Number = enemiesOne.length - 1; ce1 >= 0; ce1--) //HIT ENEMY ONE
			{
				if (enemiesOne[ce1].health > 0)
				{
					if ((bullets[bu] != null) && (enemiesOne[ce1] != null))
					{
						if (enemiesOne[ce1].hitTestObject(bullets[bu]))
						{
							if ((bullets[bu] is rocket) || (bullets[bu] is tankRocket))
							{
								bh12 = new rocketHit;
								bh12.x = bullets[bu].x;
								bh12.y = bullets[bu].y;
								bh12.width *= 4;
								bh12.height *= 4;
								bh12.gotoAndPlay(1);
								bh12.rotation = (Math.floor(Math.random() * (360 - 0 + 1)) + 0);
								addChild(bh12);
								bulletHits.push(bh12);
								ex1.play();
								addGunFlash(bh12.x, bh12.y);
								_mediumExplosion.create(bh12.x, bh12.y)
								addBigFlash(bh12.x, bh12.y);
							}
							else
							{
								bh1 = new bulletHit;
								bh1.x = bullets[bu].x;
								bh1.y = bullets[bu].y;
								addChild(bh1);
								bh1.gotoAndPlay(1);
								bh1.rotation = (Math.floor(Math.random() * (360 - 0 + 1)) + 0)
								bulletHits.push(bh1);
							}
							
							
							enemiesOne[ce1].health -= bullets[bu].damage; //DAMAGE ENEMY
							
							enemiesOne[ce1].rotation = bullets[bu].rotation - 90; //ROTATE ENEMY
							
							//KICK
							if ((!(enemiesOne[ce1] is enemyTank)) && (!(enemiesOne[ce1] is enemyThree)) && (enemiesOne[ce1].inbounds))
							{
								enemiesOne[ce1].hor += (Math.cos((enemiesOne[ce1].rotation + 90)/180*Math.PI)* bullets[bu].kick);
								enemiesOne[ce1].vert += (Math.sin((enemiesOne[ce1].rotation + 90)/180*Math.PI)* bullets[bu].kick);
							}
							
							if (bullets[bu].tag == currentPlayer) //PLAYER HIT EM
							{
								cursor_mc.hitMarker_mc.gotoAndPlay(2);
								enemiesOne[ce1].tag = true;
								
								//KILLED BY PLAYER
								if (enemiesOne[ce1].health <= 0)
								{
									earnPoint.play();
									pt1 = new pointText;
									addChild(pt1);
									pt1.x = enemiesOne[ce1].x;
									pt1.y = enemiesOne[ce1].y;
									
									
									//POINT VALUE
									if (enemiesOne[ce1] is enemyOne)
									{
										pt1.numberText_txt.text = (12);
									}
									else if (enemiesOne[ce1] is enemyTwo)
									{
										pt1.numberText_txt.text = (25);
									}
									else if (enemiesOne[ce1] is enemyThree)
									{
										pt1.numberText_txt.text = (50);
									}
									else if (enemiesOne[ce1] is enemyFour)
									{
										pt1.numberText_txt.text = (30);
									}
									else if (enemiesOne[ce1] is enemyTank)
									{
										pt1.numberText_txt.text = (80);
									}
									
									pt1.cacheAsBitmap = true;
									points.push(pt1);
								}
							}
							
							//BUDDIES KILLED IT--
							if ((enemiesOne[ce1].health <= 0) && (bullets[bu].tag != currentPlayer)) 
							{
								pt1 = new pointText;
								addChild(pt1);
								pt1.x = enemiesOne[ce1].x;
								pt1.y = enemiesOne[ce1].y;
								
								pt1.numberText_txt.textColor = 0xFFFFFF;
								pt1.plusText_txt.textColor = 0xFFFFFF;
								
								if (enemiesOne[ce1].tag)
								{
									//POINT VALUE
									if (enemiesOne[ce1] is enemyOne)
									{
										pt1.numberText_txt.text = (5);
									}
									else if (enemiesOne[ce1] is enemyTwo)
									{
										pt1.numberText_txt.text = (10);
									}
									else if (enemiesOne[ce1] is enemyThree)
									{
										pt1.numberText_txt.text = (25);
									}
									else if (enemiesOne[ce1] is enemyFour)
									{
										pt1.numberText_txt.text = (15);
									}
									else if (enemiesOne[ce1] is enemyTank)
									{
										pt1.numberText_txt.text = (40);
									}
								}
								else
								{
									//POINT VALUE
									if (enemiesOne[ce1] is enemyOne)
									{
										pt1.numberText_txt.text = (3);
									}
									else if (enemiesOne[ce1] is enemyTwo)
									{
										pt1.numberText_txt.text = (5);
									}
									else if (enemiesOne[ce1] is enemyThree)
									{
										pt1.numberText_txt.text = (15);
									}
									else if (enemiesOne[ce1] is enemyFour)
									{
										pt1.numberText_txt.text = (10);
									}
									else if (enemiesOne[ce1] is enemyTank)
									{
										pt1.numberText_txt.text = (20);
									}
								}
								pt1.cacheAsBitmap = true;
								points.push(pt1);
							}
							//--
							
							if (!(enemiesOne[ce1] is enemyTank))
							{
								enemiesOne[ce1].targeted = bullets[bu].tag; //CHANGE TARGET
							}
							
							//REMOVE BULLET
							{
								removeChild(bullets[bu]);
								bullets[bu] = null;
								bullets.splice(bu, 1);
							}
						}
					}
				}
			}
			
		}
	}
	
	for (var pr:Number = points.length - 1; pr >= 0; pr--) //UPDATE FLYING POINTS
	{
		//MOVE TOWARDS SCORE TEXT
		{
		var cqysp:Number = 40 - (points[pr].y);
		var cqxsp:Number = 320 - points[pr].x;
			
		// find out the angle
		var rotRadiansqsp:Number = Math.atan2(cqysp,cqxsp);
			
		// convert to degrees to rotate
		var rotDegreesqsp:Number = rotRadiansqsp * 180 / Math.PI;
			
		//points[pr].rotation = rotDegreesqsp + 90;
			
		points[pr].x = (points[pr].x + Math.cos((rotDegreesqsp)/180*Math.PI)* 10);
		points[pr].y = (points[pr].y + Math.sin((rotDegreesqsp)/180*Math.PI)* 10);
		}
		
		//ADD TO SCORE
		if ((points[pr].x > 310) && (points[pr].y < 45) && (points[pr].x < 330) && (points[pr].y > 20))
		{
			score += Number(points[pr].numberText_txt.text);
			removeChild(points[pr]);
			points[pr] = null;
			points.splice(pr, 1);
		}
	}
	
	for (var eb:Number = enemyBullets.length - 1; eb >= 0; eb--) //ENEMY BULLETS
	{
		enemyBullets[eb].updateBullet();
		
		//OFF STAGE - REMOVE
		if ((enemyBullets[eb].x < (-5)) || (enemyBullets[eb].x > 645) || (enemyBullets[eb].y < (-5)) || (enemyBullets[eb].y > 485))
		{
			removeChild(enemyBullets[eb]);
			enemyBullets[eb] = null;
			enemyBullets.splice(eb, 1);
		}
		else //HIT TESTS
		{
			if ((norm_mc != null) && (enemyBullets[eb] != null))
			{
				if ((norm_mc.hitTestObject(enemyBullets[eb])) && (norm_mc.visible == true))//HIT NORM
				{
					if (enemyBullets[eb] is enemyTankRocket)
					{
						var bh5t = new tankHit;
					    bh5t.x = enemyBullets[eb].x;
						bh5t.y = enemyBullets[eb].y;
						addChild(bh5t);
						bulletHits.push(bh5t);
						bh5t.gotoAndPlay(1);
						bh5t.rotation = (Math.floor(Math.random() * (360 - 0 + 1)) + 0)
						_mediumExplosion.create(bh5t.x, bh5t.y)
						addBigFlash(bh5t.x, bh5t.y);
					}
					else
					{
						var bh5 = new bulletHit;
					    bh5.x = enemyBullets[eb].x;
						bh5.y = enemyBullets[eb].y;
						addChild(bh5);
						bulletHits.push(bh5);
						bh5.gotoAndPlay(1);
						bh5.rotation = (Math.floor(Math.random() * (360 - 0 + 1)) + 0)
					}
					
					if (normHealth > 0)
					{
					normHealth -= enemyBullets[eb].damage; //DAMAGE NORM
					}
					
					if (currentPlayer == 1)
					{
						damageFlash_mc.gotoAndPlay(2);
					}
							
					removeChild(enemyBullets[eb]);
					enemyBullets[eb] = null;
					enemyBullets.splice(eb, 1);
				}
				else if ((carl_mc.hitTestObject(enemyBullets[eb])) && (carl_mc.visible == true)) //HIT CARL
				{
					if (enemyBullets[eb] is enemyTankRocket)
					{
						var bh5tr = new tankHit;
					    bh5tr.x = enemyBullets[eb].x;
						bh5tr.y = enemyBullets[eb].y;
						addChild(bh5tr);
						bulletHits.push(bh5tr);
						bh5tr.gotoAndPlay(1);
						bh5tr.rotation = (Math.floor(Math.random() * (360 - 0 + 1)) + 0)
						_mediumExplosion.create(bh5tr.x, bh5tr.y)
						addBigFlash(bh5tr.x, bh5tr.y);
					}
					else
					{
						var bh6 = new bulletHit;
					    bh6.x = enemyBullets[eb].x;
						bh6.y = enemyBullets[eb].y;
						addChild(bh6);
						bulletHits.push(bh6);
						bh6.gotoAndPlay(1);
						bh6.rotation = (Math.floor(Math.random() * (360 - 0 + 1)) + 0)
					}
					
					if (carlHealth > 0)
					{
					carlHealth -= enemyBullets[eb].damage; //DAMAGE NORM
					}
					
					if (currentPlayer == 2)
					{
						damageFlash_mc.gotoAndPlay(2);
					}
							
					removeChild(enemyBullets[eb]);
					enemyBullets[eb] = null;
					enemyBullets.splice(eb, 1);
				}
				else if ((squeakers_mc.hitTestObject(enemyBullets[eb])) && (squeakers_mc.visible == true)) //HIT SQUEAKERS
				{
					if (enemyBullets[eb] is enemyTankRocket)
					{
						var bh5tq = new tankHit;
					    bh5tq.x = enemyBullets[eb].x;
						bh5tq.y = enemyBullets[eb].y;
						addChild(bh5tq);
						bulletHits.push(bh5tq);
						bh5tq.gotoAndPlay(1);
						bh5tq.rotation = (Math.floor(Math.random() * (360 - 0 + 1)) + 0)
						_mediumExplosion.create(bh5tq.x, bh5tq.y)
						addBigFlash(bh5tq.x, bh5tq.y);
					}
					else
					{
						var bh6s = new bulletHit;
					    bh6s.x = enemyBullets[eb].x;
						bh6s.y = enemyBullets[eb].y;
						addChild(bh6s);
						bulletHits.push(bh6s);
						bh6s.gotoAndPlay(1);
						bh6s.rotation = (Math.floor(Math.random() * (360 - 0 + 1)) + 0)
					}
					
					if (squeakersHealth > 0)
					{
					squeakersHealth -= enemyBullets[eb].damage; //DAMAGE NORM
					}
					
					if (currentPlayer == 3)
					{
						damageFlash_mc.gotoAndPlay(2);
					}
							
					removeChild(enemyBullets[eb]);
					enemyBullets[eb] = null;
					enemyBullets.splice(eb, 1);
				}
				else if ((happy_mc.hitTestObject(enemyBullets[eb])) && (happy_mc.visible == true)) //HIT CARL
				{
					if (enemyBullets[eb] is enemyTankRocket)
					{
						var bh5tv = new tankHit;
					    bh5tv.x = enemyBullets[eb].x;
						bh5tv.y = enemyBullets[eb].y;
						addChild(bh5tv);
						bulletHits.push(bh5tv);
						bh5tv.gotoAndPlay(1);
						bh5tv.rotation = (Math.floor(Math.random() * (360 - 0 + 1)) + 0);
						_mediumExplosion.create(bh5tv.x, bh5tv.y)
						addBigFlash(bh5tv.x, bh5tv.y);
					}
					else
					{
						var bh6h = new bulletHit;
					    bh6h.x = enemyBullets[eb].x;
						bh6h.y = enemyBullets[eb].y;
						addChild(bh6h);
						bulletHits.push(bh6h);
						bh6h.gotoAndPlay(1);
						bh6h.rotation = (Math.floor(Math.random() * (360 - 0 + 1)) + 0)
					}
					
					if (happyHealth > 0)
					{
					happyHealth -= enemyBullets[eb].damage; //DAMAGE HAPPY
					}
					
					if (currentPlayer == 4)
					{
						damageFlash_mc.gotoAndPlay(2);
					}
							
					removeChild(enemyBullets[eb]);
					enemyBullets[eb] = null;
					enemyBullets.splice(eb, 1);
				}
				else if ((tank_mc.hitTestObject(enemyBullets[eb])) && (tank_mc.visible == true)) //HIT TANK
				{
					if (enemyBullets[eb] is enemyTankRocket)
					{
						var bh5tvt = new tankHit;
					    bh5tvt.x = enemyBullets[eb].x;
						bh5tvt.y = enemyBullets[eb].y;
						addChild(bh5tvt);
						bulletHits.push(bh5tvt);
						bh5tvt.gotoAndPlay(1);
						bh5tvt.rotation = (Math.floor(Math.random() * (360 - 0 + 1)) + 0);
						_mediumExplosion.create(bh5tvt.x, bh5tvt.y)
						addBigFlash(bh5tvt.x, bh5tvt.y);
					}
					else
					{
						var bh6ht = new bulletHit;
					    bh6ht.x = enemyBullets[eb].x;
						bh6ht.y = enemyBullets[eb].y;
						addChild(bh6ht);
						bulletHits.push(bh6ht);
						bh6ht.gotoAndPlay(1);
						bh6ht.rotation = (Math.floor(Math.random() * (360 - 0 + 1)) + 0)
					}
					
					if (tankHealth > 0)
					{
					tankHealth -= enemyBullets[eb].damage; //DAMAGE TANK
					}
					
					if (currentPlayer == 5)
					{
						damageFlash_mc.gotoAndPlay(2);
					}
							
					removeChild(enemyBullets[eb]);
					enemyBullets[eb] = null;
					enemyBullets.splice(eb, 1);
				}
			}
		}
	}
	
	for (var bh:Number = bulletHits.length - 1; bh >= 0; bh--) //BULLET EFFECT
	{
		if (bulletHits[bh] is rocketHit) //ROCKET EXPLOSION HITS ENEMY
		{
			for (var crh:Number = enemiesOne.length - 1; crh >= 0; crh--)
			{
				if (enemiesOne[crh] != null)
				{
					if (bulletHits[bh].hitTestObject(enemiesOne[crh]))
					{
						if ((bulletHits[bh].currentFrame == 4) && (enemiesOne[crh].health > 0))
						{
							var tempk:Number = (Math.floor(Math.random() * (10 - 5 + 1)) + 5);
							//KICK
							if (!(enemiesOne[crh] is enemyTank))
							{
								enemiesOne[crh].hor = (Math.cos((enemiesOne[crh].rotation + 90)/180*Math.PI)* tempk);
								enemiesOne[crh].vert = (Math.sin((enemiesOne[crh].rotation + 90)/180*Math.PI)* tempk);
							}
							enemiesOne[crh].health -= (Math.floor(Math.random() * (140 - 70 + 1)) + 70);
						}
					}
				}
			}
		}
		
		if (bulletHits[bh].currentFrame == 5) //REMOVE HIT
		{
			removeChild(bulletHits[bh]);
			bulletHits[bh].stop();
			bulletHits[bh] = null;
			bulletHits.splice(bh, 1);
		}
	}
	
	for (var gf:Number = gunFlashes.length - 1; gf >= 0; gf--) //GUN FLASHES
	{
		if (gunFlashes[gf].currentFrame == 2)
		{
			if (gunFlashes[gf].parent == black_mc)
			{
				black_mc.removeChild(gunFlashes[gf]);
			}
			else
			{
				removeChild(gunFlashes[gf]);
			}
			gunFlashes[gf].stop();
			gunFlashes[gf] = null;
			gunFlashes.splice(gf, 1);
		}
	}
	
	for (var e1:Number = enemiesOne.length - 1; e1 >= 0; e1--) //UPDATE ENEMYONES
	{
		if (enemiesOne[e1].targeted == 0) //TARGET A PLAYER
		{
			var temp:Number = 20000000;
			
			if (normHealth > 0)
			{
				temp = Math.sqrt((enemiesOne[e1].x - norm_mc.x) * (enemiesOne[e1].x - norm_mc.x) + (enemiesOne[e1].y - norm_mc.y) * (enemiesOne[e1].y - norm_mc.y));
				enemiesOne[e1].targeted = 1;
			}
			
			if (carlHealth > 0)
			{
				if ((Math.sqrt((enemiesOne[e1].x - carl_mc.x) * (enemiesOne[e1].x - carl_mc.x) + (enemiesOne[e1].y - carl_mc.y) * (enemiesOne[e1].y - carl_mc.y))) < temp)
				{
					enemiesOne[e1].targeted = 2;
					temp = (Math.sqrt((enemiesOne[e1].x - carl_mc.x) * (enemiesOne[e1].x - carl_mc.x) + (enemiesOne[e1].y - carl_mc.y) * (enemiesOne[e1].y - carl_mc.y)));
				}
			}
			
			if (squeakersHealth > 0)
			{
				if ((Math.sqrt((enemiesOne[e1].x - squeakers_mc.x) * (enemiesOne[e1].x - squeakers_mc.x) + (enemiesOne[e1].y - squeakers_mc.y) * (enemiesOne[e1].y - squeakers_mc.y))) < temp)
				{
					enemiesOne[e1].targeted = 3;
					temp = (Math.sqrt((enemiesOne[e1].x - squeakers_mc.x) * (enemiesOne[e1].x - squeakers_mc.x) + (enemiesOne[e1].y - squeakers_mc.y) * (enemiesOne[e1].y - squeakers_mc.y)));
				}
			}
			
			if (happyHealth > 0)
			{
				if ((Math.sqrt((enemiesOne[e1].x - happy_mc.x) * (enemiesOne[e1].x - happy_mc.x) + (enemiesOne[e1].y - happy_mc.y) * (enemiesOne[e1].y - happy_mc.y))) < temp)
				{
					enemiesOne[e1].targeted = 4;
				}
			}
			
			if (tankHealth > 0)
			{
				if ((Math.sqrt((enemiesOne[e1].x - tank_mc.x) * (enemiesOne[e1].x - tank_mc.x) + (enemiesOne[e1].y - tank_mc.y) * (enemiesOne[e1].y - tank_mc.y))) < temp)
				{
					enemiesOne[e1].targeted = 5;
				}
			}
		}
		
		
		if (enemiesOne[e1].targeted == 1) //ATTACK NORM
		{
			enemiesOne[e1].updateEnemy(norm_mc.x, norm_mc.y);
			
			//CHANGE TARGET
			if ((enemiesOne[e1].x > norm_mc.x + 80) || (enemiesOne[e1].x < norm_mc.x - 80) || (enemiesOne[e1].y > norm_mc.y + 80) || (enemiesOne[e1].y < norm_mc.y - 80) && (!(enemiesOne[e1] is enemyTank)))
			{
			    if ((enemiesOne[e1].x < tank_mc.x + 80) && (enemiesOne[e1].x > tank_mc.x - 80) && (enemiesOne[e1].y < tank_mc.y + 80) && (enemiesOne[e1].y > tank_mc.y - 80) && (tankHealth > 0))
				{
					enemiesOne[e1].targeted = 5;
				}
				else if ((enemiesOne[e1].x < carl_mc.x + 80) && (enemiesOne[e1].x > carl_mc.x - 80) && (enemiesOne[e1].y < carl_mc.y + 80) && (enemiesOne[e1].y > carl_mc.y - 80) && (carlHealth > 0))
				{
					enemiesOne[e1].targeted = 2;
				}
				else if ((enemiesOne[e1].x < squeakers_mc.x + 80) && (enemiesOne[e1].x > squeakers_mc.x - 80) && (enemiesOne[e1].y < squeakers_mc.y + 80) && (enemiesOne[e1].y > squeakers_mc.y - 80) && (squeakersHealth > 0))
				{
					enemiesOne[e1].targeted = 3;
				}
				else if ((enemiesOne[e1].x < happy_mc.x + 80) && (enemiesOne[e1].x > happy_mc.x - 80) && (enemiesOne[e1].y < happy_mc.y + 80) && (enemiesOne[e1].y > happy_mc.y - 80) && (happyHealth > 0))
				{
					enemiesOne[e1].targeted = 4;
				}
			}
			
			//ATTACK
			{
				if ((enemiesOne[e1].fireRate == 0) && (enemiesOne[e1].health > 0) && (normHealth > 0))
				{
					if (enemiesOne[e1] is enemyOne)
					{
						e1b = new enemyOneBullet;
						enemyBullets.push(e1b);
						addChild(e1b);
						e1b.cacheAsBitmap = true;
						addGunFlash(enemiesOne[e1].x, enemiesOne[e1].y);
							
						if((Math.floor(Math.random() * (1 - 0 + 1)) + 0) == 0)
						{
							e1b.rotation = (enemiesOne[e1].rotation - 90) + (Math.floor(Math.random() * (enemiesOneAcc - (-1 * enemiesOneAcc) + 1)) + (-1 * enemiesOneAcc))/22;
						}
						else
						{
							e1b.rotation = ((enemiesOne[e1].rotation - 90) + ((Math.floor(Math.random() * (enemiesOneAcc - (-1 * enemiesOneAcc) + 1)) + (-1 * enemiesOneAcc))/22) * -1);
						}
							
						e1b.x = enemiesOne[e1].x;
						e1b.y = enemiesOne[e1].y;
						
						enemyShot.play();
						
						enemiesOne[e1].gotoAndStop(1);
						enemiesOne[e1].rifle_mc.gotoAndPlay(2);
						enemiesOne[e1].fireRate = (Math.floor(Math.random() * (35 - 15 + 1)) + 15);
					}
					else if (enemiesOne[e1] is enemyTwo)
					{
						e1b = new enemyTwoBullet;
						enemyBullets.push(e1b);
						addChild(e1b);
						e1b.cacheAsBitmap = true;
						addGunFlash(enemiesOne[e1].x, enemiesOne[e1].y);
							
						if((Math.floor(Math.random() * (1 - 0 + 1)) + 0) == 0)
						{
							e1b.rotation = (enemiesOne[e1].rotation - 90) + (Math.floor(Math.random() * (enemiesOneAcc - (-1 * enemiesOneAcc) + 1)) + (-1 * enemiesOneAcc))/22;
						}
						else
						{
							e1b.rotation = ((enemiesOne[e1].rotation - 90) + ((Math.floor(Math.random() * (enemiesOneAcc - (-1 * enemiesOneAcc) + 1)) + (-1 * enemiesOneAcc))/22) * -1);
						}
							
						e1b.x = enemiesOne[e1].x;
						e1b.y = enemiesOne[e1].y;
						
						sniperShot.play();
						
						enemiesOne[e1].gotoAndStop(1);
						enemiesOne[e1].rifle_mc.gotoAndPlay(2);
						enemiesOne[e1].fireRate = (Math.floor(Math.random() * (200 - 100 + 1)) + 100);
					}
					else if (enemiesOne[e1] is enemyTank)
					{
						e1b = new enemyTankRocket;
						enemyBullets.push(e1b);
						addChild(e1b);
						e1b.cacheAsBitmap = true;
						addGunFlash(enemiesOne[e1].x, enemiesOne[e1].y);
							
						
						e1b.rotation = enemiesOne[e1].cannon_mc.rotation + enemiesOne[e1].rotation - 90;
						
						
							
						e1b.x = enemiesOne[e1].x;
						e1b.y = enemiesOne[e1].y;
						
						tankShot.play();
						
						enemiesOne[e1].gotoAndStop(1);
						enemiesOne[e1].cannon_mc.gotoAndPlay(2);
						enemiesOne[e1].fireRate = (Math.floor(Math.random() * (70 - 30 + 1)) + 30);
					}
					else if (enemiesOne[e1] is enemyThree)
					{
						for (var hgg:Number = 5; hgg >= 0; hgg--)
						{
							e1b = new enemyThreeBullet;
							enemyBullets.push(e1b);
							addChild(e1b);
							e1b.cacheAsBitmap = true;
							e1b.x = enemiesOne[e1].x;
							e1b.y = enemiesOne[e1].y;
							
							if((Math.floor(Math.random() * (1 - 0 + 1)) + 0) == 0)
							{
								e1b.rotation = (enemiesOne[e1].rotation - 90) + (Math.floor(Math.random() * (70 - (-1 * 70) + 1)) + (-1 * 70))/22;
							}
							else
							{
								e1b.rotation = ((enemiesOne[e1].rotation - 90) + ((Math.floor(Math.random() * (70 - (-1 * 70) + 1)) + (-1 * 70))/22) * -1);
							}
						}
						
						addGunFlash(enemiesOne[e1].x, enemiesOne[e1].y);
						shotgunShot.play();
						
						enemiesOne[e1].gotoAndStop(1);
						enemiesOne[e1].rifle_mc.gotoAndPlay(2);
						enemiesOne[e1].fireRate = (Math.floor(Math.random() * (40 - 30 + 1)) + 30);
					}
					else if (enemiesOne[e1] is enemyFour)
					{
						e1b = new enemyFourBullet;
						enemyBullets.push(e1b);
						addChild(e1b);
						e1b.cacheAsBitmap = true;
						addGunFlash(enemiesOne[e1].x, enemiesOne[e1].y);
							
						if((Math.floor(Math.random() * (1 - 0 + 1)) + 0) == 0)
						{
							e1b.rotation = (enemiesOne[e1].rotation - 90) + (Math.floor(Math.random() * (enemiesOneAcc - (-1 * enemiesOneAcc) + 1)) + (-1 * enemiesOneAcc))/22;
						}
						else
						{
							e1b.rotation = ((enemiesOne[e1].rotation - 90) + ((Math.floor(Math.random() * (enemiesOneAcc - (-1 * enemiesOneAcc) + 1)) + (-1 * enemiesOneAcc))/22) * -1);
						}
							
						e1b.x = enemiesOne[e1].x;
						e1b.y = enemiesOne[e1].y;
						
						assaultShot.play();
						
						enemiesOne[e1].gotoAndStop(1);
						enemiesOne[e1].rifle_mc.gotoAndPlay(2);
						enemiesOne[e1].fireRate = (Math.floor(Math.random() * (13 - 10 + 1)) + 10);
					}
				}
				else if (normHealth <= 0)
				{
					enemiesOne[e1].targeted = 0;
				}
			}
		}
		else if (enemiesOne[e1].targeted == 2) //ATTACK CARL
		{
			enemiesOne[e1].updateEnemy(carl_mc.x, carl_mc.y);
			
			//CHANGE TARGET
			if ((enemiesOne[e1].x > carl_mc.x + 80) || (enemiesOne[e1].x < carl_mc.x - 80) || (enemiesOne[e1].y > carl_mc.y + 80) || (enemiesOne[e1].y < carl_mc.y - 80) && (!(enemiesOne[e1] is enemyTank)))
			{
				if ((enemiesOne[e1].x < norm_mc.x + 80) && (enemiesOne[e1].x > norm_mc.x - 80) && (enemiesOne[e1].y < norm_mc.y + 80) && (enemiesOne[e1].y > norm_mc.y - 80) && (normHealth > 0))
				{
					enemiesOne[e1].targeted = 1;
				}
				else if ((enemiesOne[e1].x < squeakers_mc.x + 80) && (enemiesOne[e1].x > squeakers_mc.x - 80) && (enemiesOne[e1].y < squeakers_mc.y + 80) && (enemiesOne[e1].y > squeakers_mc.y - 80) && (squeakersHealth > 0))
				{
					enemiesOne[e1].targeted = 3;
				}
				else if ((enemiesOne[e1].x < happy_mc.x + 80) && (enemiesOne[e1].x > happy_mc.x - 80) && (enemiesOne[e1].y < happy_mc.y + 80) && (enemiesOne[e1].y > happy_mc.y - 80) && (happyHealth > 0))
				{
					enemiesOne[e1].targeted = 4;
				}
				else if ((enemiesOne[e1].x < tank_mc.x + 80) && (enemiesOne[e1].x > tank_mc.x - 80) && (enemiesOne[e1].y < tank_mc.y + 80) && (enemiesOne[e1].y > tank_mc.y - 80) && (tankHealth > 0))
				{
					enemiesOne[e1].targeted = 5;
				}
			}
			
			//ATTACK
			{
				if ((enemiesOne[e1].fireRate == 0) && (enemiesOne[e1].health > 0) && (carlHealth > 0))
				{
					if (enemiesOne[e1] is enemyOne)
					{
						e1b = new enemyOneBullet;
						enemyBullets.push(e1b);
						addChild(e1b);
						e1b.cacheAsBitmap = true;
						addGunFlash(enemiesOne[e1].x, enemiesOne[e1].y);
							
						if((Math.floor(Math.random() * (1 - 0 + 1)) + 0) == 0)
						{
							e1b.rotation = (enemiesOne[e1].rotation - 90) + (Math.floor(Math.random() * (enemiesOneAcc - (-1 * enemiesOneAcc) + 1)) + (-1 * enemiesOneAcc))/22;
						}
						else
						{
							e1b.rotation = ((enemiesOne[e1].rotation - 90) + ((Math.floor(Math.random() * (enemiesOneAcc - (-1 * enemiesOneAcc) + 1)) + (-1 * enemiesOneAcc))/22) * -1);
						}
							
						e1b.x = enemiesOne[e1].x;
						e1b.y = enemiesOne[e1].y;
						
						enemyShot.play();
							
						enemiesOne[e1].gotoAndStop(1);
						enemiesOne[e1].rifle_mc.gotoAndPlay(2);
						enemiesOne[e1].fireRate = (Math.floor(Math.random() * (35 - 15 + 1)) + 15);
					}
					else if (enemiesOne[e1] is enemyTwo)
					{
						e1b = new enemyTwoBullet;
						enemyBullets.push(e1b);
						addChild(e1b);
						e1b.cacheAsBitmap = true;
						addGunFlash(enemiesOne[e1].x, enemiesOne[e1].y);
							
						if((Math.floor(Math.random() * (1 - 0 + 1)) + 0) == 0)
						{
							e1b.rotation = (enemiesOne[e1].rotation - 90) + (Math.floor(Math.random() * (enemiesOneAcc - (-1 * enemiesOneAcc) + 1)) + (-1 * enemiesOneAcc))/22;
						}
						else
						{
							e1b.rotation = ((enemiesOne[e1].rotation - 90) + ((Math.floor(Math.random() * (enemiesOneAcc - (-1 * enemiesOneAcc) + 1)) + (-1 * enemiesOneAcc))/22) * -1);
						}
							
						e1b.x = enemiesOne[e1].x;
						e1b.y = enemiesOne[e1].y;
						
						sniperShot.play();
						
						enemiesOne[e1].gotoAndStop(1);
						enemiesOne[e1].rifle_mc.gotoAndPlay(2);
						enemiesOne[e1].fireRate = (Math.floor(Math.random() * (200 - 100 + 1)) + 100);
					}
					else if (enemiesOne[e1] is enemyTank)
					{
						e1b = new enemyTankRocket;
						enemyBullets.push(e1b);
						addChild(e1b);
						e1b.cacheAsBitmap = true;
						addGunFlash(enemiesOne[e1].x, enemiesOne[e1].y);
							
						e1b.rotation = enemiesOne[e1].cannon_mc.rotation + enemiesOne[e1].rotation - 90;
							
						e1b.x = enemiesOne[e1].x;
						e1b.y = enemiesOne[e1].y;
						
						tankShot.play();
						
						enemiesOne[e1].gotoAndStop(1);
						enemiesOne[e1].cannon_mc.gotoAndPlay(2);
						enemiesOne[e1].fireRate = (Math.floor(Math.random() * (70 - 30 + 1)) + 30);
					}
					else if (enemiesOne[e1] is enemyThree)
					{
						for (var hggf:Number = 5; hggf >= 0; hggf--)
						{
							e1b = new enemyThreeBullet;
							enemyBullets.push(e1b);
							addChild(e1b);
							e1b.cacheAsBitmap = true;
							e1b.x = enemiesOne[e1].x;
							e1b.y = enemiesOne[e1].y;
							
							
							if((Math.floor(Math.random() * (1 - 0 + 1)) + 0) == 0)
							{
								e1b.rotation = (enemiesOne[e1].rotation - 90) + (Math.floor(Math.random() * (70 - (-1 * 70) + 1)) + (-1 * 70))/22;
							}
							else
							{
								e1b.rotation = ((enemiesOne[e1].rotation - 90) + ((Math.floor(Math.random() * (70 - (-1 * 70) + 1)) + (-1 * 70))/22) * -1);
							}
						}
						
						addGunFlash(enemiesOne[e1].x, enemiesOne[e1].y);
						shotgunShot.play();
						
						enemiesOne[e1].gotoAndStop(1);
						enemiesOne[e1].rifle_mc.gotoAndPlay(2);
						enemiesOne[e1].fireRate = (Math.floor(Math.random() * (40 - 30 + 1)) + 30);
					}
					else if (enemiesOne[e1] is enemyFour)
					{
						e1b = new enemyFourBullet;
						enemyBullets.push(e1b);
						addChild(e1b);
						e1b.cacheAsBitmap = true;
						addGunFlash(enemiesOne[e1].x, enemiesOne[e1].y);
							
						if((Math.floor(Math.random() * (1 - 0 + 1)) + 0) == 0)
						{
							e1b.rotation = (enemiesOne[e1].rotation - 90) + (Math.floor(Math.random() * (enemiesOneAcc - (-1 * enemiesOneAcc) + 1)) + (-1 * enemiesOneAcc))/22;
						}
						else
						{
							e1b.rotation = ((enemiesOne[e1].rotation - 90) + ((Math.floor(Math.random() * (enemiesOneAcc - (-1 * enemiesOneAcc) + 1)) + (-1 * enemiesOneAcc))/22) * -1);
						}
							
						e1b.x = enemiesOne[e1].x;
						e1b.y = enemiesOne[e1].y;
						
						assaultShot.play();
						
						enemiesOne[e1].gotoAndStop(1);
						enemiesOne[e1].rifle_mc.gotoAndPlay(2);
						enemiesOne[e1].fireRate = (Math.floor(Math.random() * (13 - 10 + 1)) + 10);
					}
				}
				else if (carlHealth <= 0)
				{
					enemiesOne[e1].targeted = 0;
				}
			}
		}
		else if (enemiesOne[e1].targeted == 3) //ATTACK SQUEAKERS
		{
			enemiesOne[e1].updateEnemy(squeakers_mc.x, squeakers_mc.y);
			
			//CHANGE TARGET
			if ((enemiesOne[e1].x > squeakers_mc.x + 80) || (enemiesOne[e1].x < squeakers_mc.x - 80) || (enemiesOne[e1].y > squeakers_mc.y + 80) || (enemiesOne[e1].y < squeakers_mc.y - 80) && (!(enemiesOne[e1] is enemyTank)))
			{
				if ((enemiesOne[e1].x < norm_mc.x + 80) && (enemiesOne[e1].x > norm_mc.x - 80) && (enemiesOne[e1].y < norm_mc.y + 80) && (enemiesOne[e1].y > norm_mc.y - 80) && (normHealth > 0))
				{
					enemiesOne[e1].targeted = 1;
				}
				else if ((enemiesOne[e1].x < carl_mc.x + 80) && (enemiesOne[e1].x > carl_mc.x - 80) && (enemiesOne[e1].y < carl_mc.y + 80) && (enemiesOne[e1].y > carl_mc.y - 80) && (carlHealth > 0))
				{
					enemiesOne[e1].targeted = 2;
				}
				else if ((enemiesOne[e1].x < happy_mc.x + 80) && (enemiesOne[e1].x > happy_mc.x - 80) && (enemiesOne[e1].y < happy_mc.y + 80) && (enemiesOne[e1].y > happy_mc.y - 80) && (happyHealth > 0))
				{
					enemiesOne[e1].targeted = 4;
				}
				else if ((enemiesOne[e1].x < tank_mc.x + 80) && (enemiesOne[e1].x > tank_mc.x - 80) && (enemiesOne[e1].y < tank_mc.y + 80) && (enemiesOne[e1].y > tank_mc.y - 80) && (tankHealth > 0))
				{
					enemiesOne[e1].targeted = 5;
				}
			}
			
			//ATTACK
			{
				if ((enemiesOne[e1].fireRate == 0) && (enemiesOne[e1].health > 0) && (squeakersHealth > 0))
				{
					if (enemiesOne[e1] is enemyOne)
					{
						e1b = new enemyOneBullet;
						enemyBullets.push(e1b);
						addChild(e1b);
						e1b.cacheAsBitmap = true;
						addGunFlash(enemiesOne[e1].x, enemiesOne[e1].y);
							
						if((Math.floor(Math.random() * (1 - 0 + 1)) + 0) == 0)
						{
							e1b.rotation = (enemiesOne[e1].rotation - 90) + (Math.floor(Math.random() * (enemiesOneAcc - (-1 * enemiesOneAcc) + 1)) + (-1 * enemiesOneAcc))/22;
						}
						else
						{
							e1b.rotation = ((enemiesOne[e1].rotation - 90) + ((Math.floor(Math.random() * (enemiesOneAcc - (-1 * enemiesOneAcc) + 1)) + (-1 * enemiesOneAcc))/22) * -1);
						}
							
						e1b.x = enemiesOne[e1].x;
						e1b.y = enemiesOne[e1].y;
						
						enemyShot.play();
							
						enemiesOne[e1].gotoAndStop(1);
						enemiesOne[e1].rifle_mc.gotoAndPlay(2);
						enemiesOne[e1].fireRate = (Math.floor(Math.random() * (35 - 15 + 1)) + 15);
					}
					else if (enemiesOne[e1] is enemyTwo)
					{
						e1b = new enemyTwoBullet;
						enemyBullets.push(e1b);
						addChild(e1b);
						e1b.cacheAsBitmap = true;
						addGunFlash(enemiesOne[e1].x, enemiesOne[e1].y);
							
						if((Math.floor(Math.random() * (1 - 0 + 1)) + 0) == 0)
						{
							e1b.rotation = (enemiesOne[e1].rotation - 90) + (Math.floor(Math.random() * (enemiesOneAcc - (-1 * enemiesOneAcc) + 1)) + (-1 * enemiesOneAcc))/22;
						}
						else
						{
							e1b.rotation = ((enemiesOne[e1].rotation - 90) + ((Math.floor(Math.random() * (enemiesOneAcc - (-1 * enemiesOneAcc) + 1)) + (-1 * enemiesOneAcc))/22) * -1);
						}
							
						e1b.x = enemiesOne[e1].x;
						e1b.y = enemiesOne[e1].y;
						
						sniperShot.play();
						
						enemiesOne[e1].gotoAndStop(1);
						enemiesOne[e1].rifle_mc.gotoAndPlay(2);
						enemiesOne[e1].fireRate = (Math.floor(Math.random() * (200 - 100 + 1)) + 100);
					}
					else if (enemiesOne[e1] is enemyTank)
					{
						e1b = new enemyTankRocket;
						enemyBullets.push(e1b);
						addChild(e1b);
						e1b.cacheAsBitmap = true;
						addGunFlash(enemiesOne[e1].x, enemiesOne[e1].y);
							
						e1b.rotation = enemiesOne[e1].cannon_mc.rotation + enemiesOne[e1].rotation - 90;
							
						e1b.x = enemiesOne[e1].x;
						e1b.y = enemiesOne[e1].y;
						
						tankShot.play();
						
						enemiesOne[e1].gotoAndStop(1);
						enemiesOne[e1].cannon_mc.gotoAndPlay(2);
						enemiesOne[e1].fireRate = (Math.floor(Math.random() * (80 - 30 + 1)) + 30);
					}
					else if (enemiesOne[e1] is enemyThree)
					{
						for (var hggfa:Number = 5; hggfa >= 0; hggfa--)
						{
							e1b = new enemyThreeBullet;
							enemyBullets.push(e1b);
							addChild(e1b);
							e1b.cacheAsBitmap = true;
							e1b.x = enemiesOne[e1].x;
							e1b.y = enemiesOne[e1].y;
							
							if((Math.floor(Math.random() * (1 - 0 + 1)) + 0) == 0)
							{
								e1b.rotation = (enemiesOne[e1].rotation - 90) + (Math.floor(Math.random() * (70 - (-1 * 70) + 1)) + (-1 * 70))/22;
							}
							else
							{
								e1b.rotation = ((enemiesOne[e1].rotation - 90) + ((Math.floor(Math.random() * (70 - (-1 * 70) + 1)) + (-1 * 70))/22) * -1);
							}
						}
						
						addGunFlash(enemiesOne[e1].x, enemiesOne[e1].y);
						shotgunShot.play();
						
						enemiesOne[e1].gotoAndStop(1);
						enemiesOne[e1].rifle_mc.gotoAndPlay(2);
						enemiesOne[e1].fireRate = (Math.floor(Math.random() * (40 - 30 + 1)) + 30);
					}
					else if (enemiesOne[e1] is enemyFour)
					{
						e1b = new enemyFourBullet;
						enemyBullets.push(e1b);
						addChild(e1b);
						e1b.cacheAsBitmap = true;
						addGunFlash(enemiesOne[e1].x, enemiesOne[e1].y);
							
						if((Math.floor(Math.random() * (1 - 0 + 1)) + 0) == 0)
						{
							e1b.rotation = (enemiesOne[e1].rotation - 90) + (Math.floor(Math.random() * (enemiesOneAcc - (-1 * enemiesOneAcc) + 1)) + (-1 * enemiesOneAcc))/22;
						}
						else
						{
							e1b.rotation = ((enemiesOne[e1].rotation - 90) + ((Math.floor(Math.random() * (enemiesOneAcc - (-1 * enemiesOneAcc) + 1)) + (-1 * enemiesOneAcc))/22) * -1);
						}
							
						e1b.x = enemiesOne[e1].x;
						e1b.y = enemiesOne[e1].y;
						
						assaultShot.play();
						
						enemiesOne[e1].gotoAndStop(1);
						enemiesOne[e1].rifle_mc.gotoAndPlay(2);
						enemiesOne[e1].fireRate = (Math.floor(Math.random() * (13 - 10 + 1)) + 10);
					}
				}
				else if (squeakersHealth <= 0)
				{
					enemiesOne[e1].targeted = 0;
				}
			}
		}
		else if (enemiesOne[e1].targeted == 4) //ATTACK SQUEAKERS
		{
			enemiesOne[e1].updateEnemy(happy_mc.x, happy_mc.y);
			
			//CHANGE TARGET
			if ((enemiesOne[e1].x > happy_mc.x + 80) || (enemiesOne[e1].x < happy_mc.x - 80) || (enemiesOne[e1].y > happy_mc.y + 80) || (enemiesOne[e1].y < happy_mc.y - 80) && (!(enemiesOne[e1] is enemyTank)))
			{
				if ((enemiesOne[e1].x < norm_mc.x + 80) && (enemiesOne[e1].x > norm_mc.x - 80) && (enemiesOne[e1].y < norm_mc.y + 80) && (enemiesOne[e1].y > norm_mc.y - 80) && (normHealth > 0))
				{
					enemiesOne[e1].targeted = 1;
				}
				else if ((enemiesOne[e1].x < carl_mc.x + 80) && (enemiesOne[e1].x > carl_mc.x - 80) && (enemiesOne[e1].y < carl_mc.y + 80) && (enemiesOne[e1].y > carl_mc.y - 80) && (carlHealth > 0))
				{
					enemiesOne[e1].targeted = 2;
				}
				else if ((enemiesOne[e1].x < squeakers_mc.x + 80) && (enemiesOne[e1].x > squeakers_mc.x - 80) && (enemiesOne[e1].y < squeakers_mc.y + 80) && (enemiesOne[e1].y > squeakers_mc.y - 80) && (squeakersHealth > 0))
				{
					enemiesOne[e1].targeted = 3;
				}
				else if ((enemiesOne[e1].x < tank_mc.x + 80) && (enemiesOne[e1].x > tank_mc.x - 80) && (enemiesOne[e1].y < tank_mc.y + 80) && (enemiesOne[e1].y > tank_mc.y - 80) && (tankHealth > 0))
				{
					enemiesOne[e1].targeted = 5;
				}
			}
			
			//ATTACK
			{
				if ((enemiesOne[e1].fireRate == 0) && (enemiesOne[e1].health > 0) && (happyHealth > 0))
				{
					if (enemiesOne[e1] is enemyOne)
					{
						e1b = new enemyOneBullet;
						enemyBullets.push(e1b);
						addChild(e1b);
						e1b.cacheAsBitmap = true;
						addGunFlash(enemiesOne[e1].x, enemiesOne[e1].y);
							
						if((Math.floor(Math.random() * (1 - 0 + 1)) + 0) == 0)
						{
							e1b.rotation = (enemiesOne[e1].rotation - 90) + (Math.floor(Math.random() * (enemiesOneAcc - (-1 * enemiesOneAcc) + 1)) + (-1 * enemiesOneAcc))/22;
						}
						else
						{
							e1b.rotation = ((enemiesOne[e1].rotation - 90) + ((Math.floor(Math.random() * (enemiesOneAcc - (-1 * enemiesOneAcc) + 1)) + (-1 * enemiesOneAcc))/22) * -1);
						}
							
						e1b.x = enemiesOne[e1].x;
						e1b.y = enemiesOne[e1].y;
						
						enemyShot.play();
							
						enemiesOne[e1].gotoAndStop(1);
						enemiesOne[e1].rifle_mc.gotoAndPlay(2);
						enemiesOne[e1].fireRate = (Math.floor(Math.random() * (35 - 15 + 1)) + 15);
					}
					else if (enemiesOne[e1] is enemyTwo)
					{
						e1b = new enemyTwoBullet;
						enemyBullets.push(e1b);
						addChild(e1b);
						e1b.cacheAsBitmap = true;
						addGunFlash(enemiesOne[e1].x, enemiesOne[e1].y);
							
						if((Math.floor(Math.random() * (1 - 0 + 1)) + 0) == 0)
						{
							e1b.rotation = (enemiesOne[e1].rotation - 90) + (Math.floor(Math.random() * (enemiesOneAcc - (-1 * enemiesOneAcc) + 1)) + (-1 * enemiesOneAcc))/22;
						}
						else
						{
							e1b.rotation = ((enemiesOne[e1].rotation - 90) + ((Math.floor(Math.random() * (enemiesOneAcc - (-1 * enemiesOneAcc) + 1)) + (-1 * enemiesOneAcc))/22) * -1);
						}
							
						e1b.x = enemiesOne[e1].x;
						e1b.y = enemiesOne[e1].y;
						
						sniperShot.play();
						
						enemiesOne[e1].gotoAndStop(1);
						enemiesOne[e1].rifle_mc.gotoAndPlay(2);
						enemiesOne[e1].fireRate = (Math.floor(Math.random() * (200 - 100 + 1)) + 100);
					}
					else if (enemiesOne[e1] is enemyTank)
					{
						e1b = new enemyTankRocket;
						enemyBullets.push(e1b);
						addChild(e1b);
						e1b.cacheAsBitmap = true;
						addGunFlash(enemiesOne[e1].x, enemiesOne[e1].y);
							
						e1b.rotation = enemiesOne[e1].cannon_mc.rotation + enemiesOne[e1].rotation - 90;
							
						e1b.x = enemiesOne[e1].x;
						e1b.y = enemiesOne[e1].y;
						
						tankShot.play();
						
						enemiesOne[e1].gotoAndStop(1);
						enemiesOne[e1].cannon_mc.gotoAndPlay(2);
						enemiesOne[e1].fireRate = (Math.floor(Math.random() * (80 - 30 + 1)) + 30);
					}
					else if (enemiesOne[e1] is enemyThree)
					{
						for (var hggfw:Number = 5; hggfw >= 0; hggfw--)
						{
							e1b = new enemyThreeBullet;
							enemyBullets.push(e1b);
							addChild(e1b);
							e1b.cacheAsBitmap = true;
							e1b.x = enemiesOne[e1].x;
							e1b.y = enemiesOne[e1].y;
							
							
							if((Math.floor(Math.random() * (1 - 0 + 1)) + 0) == 0)
							{
								e1b.rotation = (enemiesOne[e1].rotation - 90) + (Math.floor(Math.random() * (70 - (-1 * 70) + 1)) + (-1 * 70))/22;
							}
							else
							{
								e1b.rotation = ((enemiesOne[e1].rotation - 90) + ((Math.floor(Math.random() * (70 - (-1 * 70) + 1)) + (-1 * 70))/22) * -1);
							}
						}
						
						addGunFlash(enemiesOne[e1].x, enemiesOne[e1].y);
						shotgunShot.play();
						
						enemiesOne[e1].gotoAndStop(1);
						enemiesOne[e1].rifle_mc.gotoAndPlay(2);
						enemiesOne[e1].fireRate = (Math.floor(Math.random() * (40 - 30 + 1)) + 30);
					}
					else if (enemiesOne[e1] is enemyFour)
					{
						e1b = new enemyFourBullet;
						enemyBullets.push(e1b);
						addChild(e1b);
						e1b.cacheAsBitmap = true;
						addGunFlash(enemiesOne[e1].x, enemiesOne[e1].y);
							
						if((Math.floor(Math.random() * (1 - 0 + 1)) + 0) == 0)
						{
							e1b.rotation = (enemiesOne[e1].rotation - 90) + (Math.floor(Math.random() * (enemiesOneAcc - (-1 * enemiesOneAcc) + 1)) + (-1 * enemiesOneAcc))/22;
						}
						else
						{
							e1b.rotation = ((enemiesOne[e1].rotation - 90) + ((Math.floor(Math.random() * (enemiesOneAcc - (-1 * enemiesOneAcc) + 1)) + (-1 * enemiesOneAcc))/22) * -1);
						}
							
						e1b.x = enemiesOne[e1].x;
						e1b.y = enemiesOne[e1].y;
						
						assaultShot.play();
						
						enemiesOne[e1].gotoAndStop(1);
						enemiesOne[e1].rifle_mc.gotoAndPlay(2);
						enemiesOne[e1].fireRate = (Math.floor(Math.random() * (13 - 10 + 1)) + 10);
					}
				}
				else if (happyHealth <= 0)
				{
					enemiesOne[e1].targeted = 0;
				}
			}
		}
		else if (enemiesOne[e1].targeted == 5) //ATTACK TANK
		{
			enemiesOne[e1].updateEnemy(tank_mc.x, tank_mc.y);
			
			//CHANGE TARGET
			if ((enemiesOne[e1].x > tank_mc.x + 80) || (enemiesOne[e1].x < tank_mc.x - 80) || (enemiesOne[e1].y > tank_mc.y + 80) || (enemiesOne[e1].y < tank_mc.y - 80) && (!(enemiesOne[e1] is enemyTank)))
			{
				if ((enemiesOne[e1].x < norm_mc.x + 80) && (enemiesOne[e1].x > norm_mc.x - 80) && (enemiesOne[e1].y < norm_mc.y + 80) && (enemiesOne[e1].y > norm_mc.y - 80) && (normHealth > 0))
				{
					enemiesOne[e1].targeted = 1;
				}
				else if ((enemiesOne[e1].x < carl_mc.x + 80) && (enemiesOne[e1].x > carl_mc.x - 80) && (enemiesOne[e1].y < carl_mc.y + 80) && (enemiesOne[e1].y > carl_mc.y - 80) && (carlHealth > 0))
				{
					enemiesOne[e1].targeted = 2;
				}
				else if ((enemiesOne[e1].x < squeakers_mc.x + 80) && (enemiesOne[e1].x > squeakers_mc.x - 80) && (enemiesOne[e1].y < squeakers_mc.y + 80) && (enemiesOne[e1].y > squeakers_mc.y - 80) && (squeakersHealth > 0))
				{
					enemiesOne[e1].targeted = 3;
				}
				else if ((enemiesOne[e1].x < squeakers_mc.x + 80) && (enemiesOne[e1].x > squeakers_mc.x - 80) && (enemiesOne[e1].y < squeakers_mc.y + 80) && (enemiesOne[e1].y > squeakers_mc.y - 80) && (squeakersHealth > 0))
				{
					enemiesOne[e1].targeted = 3;
				}
			}
			
			//ATTACK
			{
				if ((enemiesOne[e1].fireRate == 0) && (enemiesOne[e1].health > 0) && (tankHealth > 0))
				{
					if (enemiesOne[e1] is enemyOne)
					{
						e1b = new enemyOneBullet;
						enemyBullets.push(e1b);
						addChild(e1b);
						e1b.cacheAsBitmap = true;
						addGunFlash(enemiesOne[e1].x, enemiesOne[e1].y);
							
						if((Math.floor(Math.random() * (1 - 0 + 1)) + 0) == 0)
						{
							e1b.rotation = (enemiesOne[e1].rotation - 90) + (Math.floor(Math.random() * (enemiesOneAcc - (-1 * enemiesOneAcc) + 1)) + (-1 * enemiesOneAcc))/22;
						}
						else
						{
							e1b.rotation = ((enemiesOne[e1].rotation - 90) + ((Math.floor(Math.random() * (enemiesOneAcc - (-1 * enemiesOneAcc) + 1)) + (-1 * enemiesOneAcc))/22) * -1);
						}
							
						e1b.x = enemiesOne[e1].x;
						e1b.y = enemiesOne[e1].y;
						
						enemyShot.play();
							
						enemiesOne[e1].gotoAndStop(1);
						enemiesOne[e1].rifle_mc.gotoAndPlay(2);
						enemiesOne[e1].fireRate = (Math.floor(Math.random() * (35 - 15 + 1)) + 15);
					}
					else if (enemiesOne[e1] is enemyTwo)
					{
						e1b = new enemyTwoBullet;
						enemyBullets.push(e1b);
						addChild(e1b);
						e1b.cacheAsBitmap = true;
						addGunFlash(enemiesOne[e1].x, enemiesOne[e1].y);
							
						if((Math.floor(Math.random() * (1 - 0 + 1)) + 0) == 0)
						{
							e1b.rotation = (enemiesOne[e1].rotation - 90) + (Math.floor(Math.random() * (enemiesOneAcc - (-1 * enemiesOneAcc) + 1)) + (-1 * enemiesOneAcc))/22;
						}
						else
						{
							e1b.rotation = ((enemiesOne[e1].rotation - 90) + ((Math.floor(Math.random() * (enemiesOneAcc - (-1 * enemiesOneAcc) + 1)) + (-1 * enemiesOneAcc))/22) * -1);
						}
							
						e1b.x = enemiesOne[e1].x;
						e1b.y = enemiesOne[e1].y;
						
						sniperShot.play();
						
						enemiesOne[e1].gotoAndStop(1);
						enemiesOne[e1].rifle_mc.gotoAndPlay(2);
						enemiesOne[e1].fireRate = (Math.floor(Math.random() * (200 - 100 + 1)) + 100);
					}
					else if (enemiesOne[e1] is enemyTank)
					{
						e1b = new enemyTankRocket;
						enemyBullets.push(e1b);
						addChild(e1b);
						e1b.cacheAsBitmap = true;
						addGunFlash(enemiesOne[e1].x, enemiesOne[e1].y);
							
						e1b.rotation = enemiesOne[e1].cannon_mc.rotation + enemiesOne[e1].rotation - 90;
							
						e1b.x = enemiesOne[e1].x;
						e1b.y = enemiesOne[e1].y;
						
						tankShot.play();
						
						enemiesOne[e1].gotoAndStop(1);
						enemiesOne[e1].cannon_mc.gotoAndPlay(2);
						enemiesOne[e1].fireRate = (Math.floor(Math.random() * (80 - 30 + 1)) + 30);
					}
					else if (enemiesOne[e1] is enemyThree)
					{
						for (var hggfc:Number = 5; hggfc >= 0; hggfc--)
						{
							e1b = new enemyThreeBullet;
							enemyBullets.push(e1b);
							addChild(e1b);
							e1b.cacheAsBitmap = true;
							e1b.x = enemiesOne[e1].x;
							e1b.y = enemiesOne[e1].y;
							
							
							
							if((Math.floor(Math.random() * (1 - 0 + 1)) + 0) == 0)
							{
								e1b.rotation = (enemiesOne[e1].rotation - 90) + (Math.floor(Math.random() * (70 - (-1 * 70) + 1)) + (-1 * 70))/22;
							}
							else
							{
								e1b.rotation = ((enemiesOne[e1].rotation - 90) + ((Math.floor(Math.random() * (70 - (-1 * 70) + 1)) + (-1 * 70))/22) * -1);
							}
						}
						
						addGunFlash(enemiesOne[e1].x, enemiesOne[e1].y);
						shotgunShot.play();
						
						enemiesOne[e1].gotoAndStop(1);
						enemiesOne[e1].rifle_mc.gotoAndPlay(2);
						enemiesOne[e1].fireRate = (Math.floor(Math.random() * (40 - 30 + 1)) + 30);
					}
					else if (enemiesOne[e1] is enemyFour)
					{
						e1b = new enemyFourBullet;
						enemyBullets.push(e1b);
						addChild(e1b);
						e1b.cacheAsBitmap = true;
						addGunFlash(enemiesOne[e1].x, enemiesOne[e1].y);
							
						if((Math.floor(Math.random() * (1 - 0 + 1)) + 0) == 0)
						{
							e1b.rotation = (enemiesOne[e1].rotation - 90) + (Math.floor(Math.random() * (enemiesOneAcc - (-1 * enemiesOneAcc) + 1)) + (-1 * enemiesOneAcc))/22;
						}
						else
						{
							e1b.rotation = ((enemiesOne[e1].rotation - 90) + ((Math.floor(Math.random() * (enemiesOneAcc - (-1 * enemiesOneAcc) + 1)) + (-1 * enemiesOneAcc))/22) * -1);
						}
							
						e1b.x = enemiesOne[e1].x;
						e1b.y = enemiesOne[e1].y;
						
						assaultShot.play();
						
						enemiesOne[e1].gotoAndStop(1);
						enemiesOne[e1].rifle_mc.gotoAndPlay(2);
						enemiesOne[e1].fireRate = (Math.floor(Math.random() * (13 - 10 + 1)) + 10);
					}
				}
				else if (tankHealth <= 0)
				{
					enemiesOne[e1].targeted = 0;
				}
			}
		}
	}
	
	for (var a1:Number = ammo.length - 1; a1 >= 0; a1--) //UPDATE AMMO
	{
		if ((ammo[a1].hitTestObject(norm_mc)) && (normHealth > 0))
		{
			if (ammo[a1] is ammoSymbol) //ADD TO AMMO
			{
				ame = (Math.floor(Math.random() * (45 - 30 + 1)) + 30);
				normAmmo += ame;
				if (currentPlayer == 1)
				{
				hud_mc.addedAmmoText_txt.text = ("Rifle Ammo +" + ame);
				addedAmmo = 30;
				}
			}
			else
			{
				ame = (Math.floor(Math.random() * (10 - 5 + 1)) + 5);
				normPistolAmmo += ame;
				if (currentPlayer == 1)
				{
				hud_mc.addedAmmoText_txt.text = ("Pistol Ammo +" + ame);
				addedAmmo = 30;
				}
			}
			
			pt1 = new pointText;
			if (currentPlayer != 1)
			{
				pt1.numberText_txt.textColor = 0xFFFFFF;
				pt1.plusText_txt.textColor = 0xFFFFFF;
			}
			addChild(pt1);
			pt1.x = ammo[a1].x;
			pt1.y = ammo[a1].y;
			pt1.numberText_txt.text = (1);
			pt1.cacheAsBitmap = true;
			points.push(pt1);
			
			addGunFlash(ammo[a1].x, ammo[a1].y);
			pickup.play();
			removeChild(ammo[a1]);
			ammo[a1] = null;
			ammo.splice(a1, 1);
		}
		else if ((ammo[a1].hitTestObject(carl_mc)) && (carlHealth > 0))
		{
			if (ammo[a1] is ammoSymbol) //ADD TO AMMO
			{
				ame = (Math.floor(Math.random() * (5 - 2 + 1)) + 2);
				carlAmmo += ame;
				if (currentPlayer == 2)
				{
				hud_mc.addedAmmoText_txt.text = ("Sniper Ammo +" + ame);
				addedAmmo = 30;
				}
			}
			else
			{
				ame = (Math.floor(Math.random() * (10 - 5 + 1)) + 5);
				carlPistolAmmo += ame;
				if (currentPlayer == 2)
				{
				hud_mc.addedAmmoText_txt.text = ("Pistol Ammo +" + ame);
				addedAmmo = 30;
				}
			}
			
			pt1 = new pointText;
			if (currentPlayer != 2)
			{
				pt1.numberText_txt.textColor = 0xFFFFFF;
				pt1.plusText_txt.textColor = 0xFFFFFF;
			}
			addChild(pt1);
			pt1.x = ammo[a1].x;
			pt1.y = ammo[a1].y;
			pt1.numberText_txt.text = (1);
			pt1.cacheAsBitmap = true;
			points.push(pt1);
			
			addGunFlash(ammo[a1].x, ammo[a1].y);
			pickup.play();
			removeChild(ammo[a1]);
			ammo[a1] = null;
			ammo.splice(a1, 1);
		}
		else if ((ammo[a1].hitTestObject(squeakers_mc)) && (squeakersHealth > 0))
		{
			if (ammo[a1] is ammoSymbol) //ADD TO AMMO
			{
				ame = (Math.floor(Math.random() * (6 - 3 + 1)) + 3);
				squeakersAmmo += ame;
				if (currentPlayer == 3)
				{
				hud_mc.addedAmmoText_txt.text = ("Shotgun Ammo +" + ame);
				addedAmmo = 30;
				}
			}
			else
			{
				ame = (Math.floor(Math.random() * (10 - 5 + 1)) + 5);
				squeakersPistolAmmo += ame;
				if (currentPlayer == 3)
				{
				hud_mc.addedAmmoText_txt.text = ("Pistol Ammo +" + ame);
				addedAmmo = 30;
				}
			}
			
			pt1 = new pointText;
			if (currentPlayer != 3)
			{
				pt1.numberText_txt.textColor = 0xFFFFFF;
				pt1.plusText_txt.textColor = 0xFFFFFF;
			}
			addChild(pt1);
			pt1.x = ammo[a1].x;
			pt1.y = ammo[a1].y;
			pt1.numberText_txt.text = (1);
			pt1.cacheAsBitmap = true;
			points.push(pt1);
			addGunFlash(ammo[a1].x, ammo[a1].y);
			pickup.play();
			removeChild(ammo[a1]);
			ammo[a1] = null;
			ammo.splice(a1, 1);
		}
		else if ((ammo[a1].hitTestObject(happy_mc)) && (happyHealth > 0))
		{
			if (ammo[a1] is ammoSymbol) //ADD TO AMMO
			{
				ame = (Math.floor(Math.random() * (60 - 40 + 1)) + 40);
				happyAmmo += ame;
				if (currentPlayer == 4)
				{
				hud_mc.addedAmmoText_txt.text = ("LMG Ammo +" + ame);
				addedAmmo = 30;
				}
			}
			else
			{
				ame = (Math.floor(Math.random() * (10 - 5 + 1)) + 5);
				happyPistolAmmo += ame;
				if (currentPlayer == 4)
				{
				hud_mc.addedAmmoText_txt.text = ("Pistol Ammo +" + ame);
				addedAmmo = 30;
				}
			}
			pt1 = new pointText;
			if (currentPlayer != 4)
			{
				pt1.numberText_txt.textColor = 0xFFFFFF;
				pt1.plusText_txt.textColor = 0xFFFFFF;
			}
			addChild(pt1);
			pt1.x = ammo[a1].x;
			pt1.y = ammo[a1].y;
			pt1.numberText_txt.text = (1);
			pt1.cacheAsBitmap = true;
			points.push(pt1);
			addGunFlash(ammo[a1].x, ammo[a1].y);
			pickup.play();
			removeChild(ammo[a1]);
			ammo[a1] = null;
			ammo.splice(a1, 1);
		}
	}
	
	
	if (norm_mc != null) //UPDATE NORM
	{
		norm_mc.updateNorm();
		
		if ((currentPlayer != 1) && (normHealth > 0)) //IF NOT SELECTED
		{
		for (var eOneN:Number = enemiesOne.length - 1; eOneN >= 0; eOneN--) 
		{
			//ATTACK
			if ((enemiesOne[eOneN].x < norm_mc.x + 150) && (enemiesOne[eOneN].x > norm_mc.x - 150) && (enemiesOne[eOneN].y < norm_mc.y + 150) && (enemiesOne[eOneN].y > norm_mc.y - 150))
			{
				switch (norm_mc.normCurrentWeapon)
				{
					case 1:
					if ((norm_mc.clip > 0) && (norm_mc.normFireRate == 0) && (enemiesOne[eOneN].health > 0))
					{
						//ROTATE NORM
						{
						var c6y21:Number = enemiesOne[eOneN].y - (norm_mc.y); 
						var c6x21:Number = enemiesOne[eOneN].x - norm_mc.x;
								
						// find out the angle
						var rotRadians621:Number = Math.atan2(c6y21,c6x21);
								
						// convert to degrees to rotate
						var rotDegrees621:Number = rotRadians621 * 180 / Math.PI;
									
						norm_mc.rotation = rotDegrees621 + 90;
						}
						
						
						pb = new normBullet;
						addChild(pb);
						pb.cacheAsBitmap = true;
						addGunFlash(norm_mc.x, norm_mc.y);
						
						if((Math.floor(Math.random() * (1 - 0 + 1)) + 0) == 0)
						{
							pb.rotation = (norm_mc.rotation - 90) + (Math.floor(Math.random() * (normAccLow - (-1 * normAccLow) + 1)) + (-1 * normAccLow))/22;
						}
						else
						{
							pb.rotation = ((norm_mc.rotation - 90) + ((Math.floor(Math.random() * (normAccLow - (-1 * normAccLow) + 1)) + (-1 * normAccLow))/22) * -1);
						}
						
						pb.x = norm_mc.x;
						pb.y = norm_mc.y;
						
						bullets.push(pb);
						
						norm_mc.gotoAndStop(1);
						norm_mc.rifle_mc.gotoAndPlay(2);
						assaultShot.play();
						norm_mc.normFireRate = normFireRate * 2;
						norm_mc.clip--;
					}
					break;
					
					case 2:
					if ((norm_mc.pistolClip > 0) && (norm_mc.normFireRate == 0) && (enemiesOne[eOneN].health > 0))
					{
						//ROTATE NORM
						{
						var c6y12:Number = enemiesOne[eOneN].y - (norm_mc.y); 
						var c6x12:Number = enemiesOne[eOneN].x - norm_mc.x;
								
						// find out the angle
						var rotRadians612:Number = Math.atan2(c6y12,c6x12);
								
						// convert to degrees to rotate
						var rotDegrees612:Number = rotRadians612 * 180 / Math.PI;
									
						norm_mc.rotation = rotDegrees612 + 90;
						}
						
						
						pb = new pistolBullet;
						addChild(pb);
						pb.cacheAsBitmap = true;
						pb.tag = 1;
						addGunFlash(norm_mc.x, norm_mc.y);
						
						if((Math.floor(Math.random() * (1 - 0 + 1)) + 0) == 0)
						{
							pb.rotation = (norm_mc.rotation - 90) + (Math.floor(Math.random() * (pistolAccHigh - (-1 * pistolAccHigh) + 1)) + (-1 * pistolAccHigh))/22;
						}
						else
						{
							pb.rotation = ((norm_mc.rotation - 90) + ((Math.floor(Math.random() * (pistolAccHigh - (-1 * pistolAccHigh) + 1)) + (-1 * pistolAccHigh))/22) * -1);
						}
						
						pb.x = norm_mc.x;
						pb.y = norm_mc.y;
						bullets.push(pb);
						
						norm_mc.gotoAndStop(2);
						norm_mc.pistol_mc.gotoAndPlay(2);
						pistolShot.play();
						norm_mc.normFireRate = normFireRate;
						norm_mc.pistolClip--;
					}
					break;
				}
				
				if ((norm_mc.reloadTimer == -1) && ((enemiesOne[eOneN].x > norm_mc.x + 50) || (enemiesOne[eOneN].x < norm_mc.x - 50) || (enemiesOne[eOneN].y < norm_mc.y - 50) || (enemiesOne[eOneN].y > norm_mc.y + 50)))

				{
					norm_mc.x = (norm_mc.x + Math.cos((norm_mc.rotation - 90)/180*Math.PI)/ 11);
					norm_mc.y = (norm_mc.y + Math.sin((norm_mc.rotation - 90)/180*Math.PI)/ 11);
				}
			}
			else if ((enemiesOne[eOneN].x < norm_mc.x + 350) && (enemiesOne[eOneN].x > norm_mc.x - 350) && (enemiesOne[eOneN].y < norm_mc.y + 350) && (enemiesOne[eOneN].y > norm_mc.y - 350))
			{
				switch (norm_mc.normCurrentWeapon)
				{
					case 1:
					if ((norm_mc.clip > 0) && (norm_mc.normFireRate == 0) && (enemiesOne[eOneN].health > 0))
					{
						//ROTATE NORM
						{
						var c6y2:Number = enemiesOne[eOneN].y - (norm_mc.y); 
						var c6x2:Number = enemiesOne[eOneN].x - norm_mc.x;
								
						// find out the angle
						var rotRadians62:Number = Math.atan2(c6y2,c6x2);
								
						// convert to degrees to rotate
						var rotDegrees62:Number = rotRadians62 * 180 / Math.PI;
									
						norm_mc.rotation = rotDegrees62 + 90;
						}
						
						
						pb = new normBullet;
						addChild(pb);
						pb.cacheAsBitmap = true;
						addGunFlash(norm_mc.x, norm_mc.y);
						
						if((Math.floor(Math.random() * (1 - 0 + 1)) + 0) == 0)
						{
							pb.rotation = (norm_mc.rotation - 90) + (Math.floor(Math.random() * ((normAccLow + 40) - (-1 * (normAccLow + 40)) + 1)) + (-1 * (normAccLow + 40)))/22;
						}
						else
						{
							pb.rotation = ((norm_mc.rotation - 90) + ((Math.floor(Math.random() * ((normAccLow + 40) - (-1 * (normAccLow + 40)) + 1)) + (-1 * (normAccLow + 40)))/22) * -1);
						}
						
						pb.x = norm_mc.x;
						pb.y = norm_mc.y;
						bullets.push(pb);
						
						norm_mc.gotoAndStop(1);
						norm_mc.rifle_mc.gotoAndPlay(2);
						assaultShot.play();
						norm_mc.normFireRate = normFireRate * 3;
						norm_mc.clip--;
					}
					break;
					
					case 2:
					if ((norm_mc.pistolClip > 0) && (norm_mc.normFireRate == 0) && (enemiesOne[eOneN].health > 0))
					{
						//ROTATE NORM
						{
						var c6y1:Number = enemiesOne[eOneN].y - (norm_mc.y); 
						var c6x1:Number = enemiesOne[eOneN].x - norm_mc.x;
								
						// find out the angle
						var rotRadians61:Number = Math.atan2(c6y1,c6x1);
								
						// convert to degrees to rotate
						var rotDegrees61:Number = rotRadians61 * 180 / Math.PI;
									
						norm_mc.rotation = rotDegrees61 + 90;
						}
						
						
						pb = new pistolBullet;
						addChild(pb);
						pb.cacheAsBitmap = true;
						pb.tag = 1;
						addGunFlash(norm_mc.x, norm_mc.y);
						
						if((Math.floor(Math.random() * (1 - 0 + 1)) + 0) == 0)
						{
							pb.rotation = (norm_mc.rotation - 90) + (Math.floor(Math.random() * (pistolAccHigh - (-1 * pistolAccHigh) + 1)) + (-1 * pistolAccHigh))/22;
						}
						else
						{
							pb.rotation = ((norm_mc.rotation - 90) + ((Math.floor(Math.random() * (pistolAccHigh - (-1 * pistolAccHigh) + 1)) + (-1 * pistolAccHigh))/22) * -1);
						}
						
						pb.x = norm_mc.x;
						pb.y = norm_mc.y;
						bullets.push(pb);
						
						norm_mc.gotoAndStop(2);
						norm_mc.pistol_mc.gotoAndPlay(2);
						pistolShot.play();
						norm_mc.normFireRate = normFireRate * 2;
						norm_mc.pistolClip--;
					}
					break;
				}
				
				norm_mc.x = (norm_mc.x + Math.cos((norm_mc.rotation - 90)/180*Math.PI)/ 9);
				norm_mc.y = (norm_mc.y + Math.sin((norm_mc.rotation - 90)/180*Math.PI)/ 9);
			}
		}
		
		//MOVE AROUND
		if ((norm_mc.x > 50) && (norm_mc.x < 590) && (norm_mc.y > 50) && (norm_mc.y < 430))
		{
			if (norm_mc.normFireRate == 0)
			{
				norm_mc.x = (norm_mc.x + Math.cos((norm_mc.rotation - 90)/180*Math.PI)/ 8);
				norm_mc.y = (norm_mc.y + Math.sin((norm_mc.rotation - 90)/180*Math.PI)/ 8);
			}
		}
		else
		{
			var cqys:Number = 240 - (norm_mc.y);
			var cqxs:Number = 320 - norm_mc.x;
			
			// find out the angle
			var rotRadiansqs:Number = Math.atan2(cqys,cqxs);
			
			// convert to degrees to rotate
			var rotDegreesqs:Number = rotRadiansqs * 180 / Math.PI;
			
			norm_mc.rotation = rotDegreesqs + 90;
			
			norm_mc.x = (norm_mc.x + Math.cos((norm_mc.rotation - 90)/180*Math.PI)* 1);
			norm_mc.y = (norm_mc.y + Math.sin((norm_mc.rotation - 90)/180*Math.PI)* 1);
		}
		
		//GET AMMO
		if ((norm_mc.clip <= 0) && (normAmmo <= 0) && (normPistolAmmo <= 0) && (norm_mc.pistolClip <= 0) && (ammo.length > 0))
		{
			for (var san:Number = ammo.length - 1; san >= 0; san--)
			{
				//ROTATE squeakers
				{
					var c6y2dasn:Number = ammo[san].y - (norm_mc.y); 
					var c6x2dasn:Number = ammo[san].x - norm_mc.x;
							
				    //find out the angle
					var rotRadians62dasn:Number = Math.atan2(c6y2dasn,c6x2dasn);
								
					// convert to degrees to rotate
					var rotDegrees62dasn:Number = rotRadians62dasn * 180 / Math.PI;
									
					norm_mc.rotation = rotDegrees62dasn + 90;
				}
				
				norm_mc.x = (norm_mc.x + Math.cos((norm_mc.rotation - 90)/180*Math.PI) * 6);
				norm_mc.y = (norm_mc.y + Math.sin((norm_mc.rotation - 90)/180*Math.PI) * 6);
				
				san = -1;
			}
		}
		
		}
		
		if ((normHealth <= 0) && (!gameOver)) //DOWN
		{
			//if (currentWave != 0)
			{
				norm_mc.alpha -= .00000001;
			}
			reviveCircle1_mc.gotoAndStop(1);
			
			var tempNH:Number = norm_mc.alpha;
			
			if (norm_mc.visible == true)
			{
			switch (currentPlayer) //CURRENT PLAYER IN CIRCLE
			{
				case 2:
				if (reviveCircle1_mc.hitTestPoint(carl_mc.x, carl_mc.y, true))
				{
					norm_mc.alpha += .01;
					reviveCircle1_mc.gotoAndStop(2);
				}
				break;
				
				case 3:
				if (reviveCircle1_mc.hitTestPoint(squeakers_mc.x, squeakers_mc.y, true))
				{
					norm_mc.alpha += .01;
					reviveCircle1_mc.gotoAndStop(2);
				}
				break;
				
				case 4:
				if (reviveCircle1_mc.hitTestPoint(happy_mc.x, happy_mc.y, true))
				{
					norm_mc.alpha += .01;
					reviveCircle1_mc.gotoAndStop(2);
				}
				break;
			}
			}
			
			if (norm_mc.alpha >= 1)
			{
				if (currentWave != 0)
				{
					normHealth = 20;
					revive.play();
				}
				else
				{
					normHealth = 100;
					revive.play();
				}
				hud_mc.normBox_mc.gotoAndStop(1);
			}
			else if (norm_mc.alpha <= 0)
			{
				norm_mc.visible = false;
				reviveCircle1_mc.visible = false;
				if (!normDead)
				{
					downed.play();
				}
				normDead = true;
			}
			else
			{
				if (currentWave == 0)
				{
					if (tempNH == norm_mc.alpha)
					{
						norm_mc.alpha = .7;
					}
				}
			}
		}
	}
	
	if (carl_mc != null) //UPDATE CARL
	{
		carl_mc.updateCarl();
		
		if ((currentPlayer != 2) && (carlHealth > 0)) //ATTACK IF NOT SELECTED
		{
		for (var eOne:Number = enemiesOne.length - 1; eOne >= 0; eOne--) 
		{
			//ATTACK
			if (enemiesOne[eOne].inbounds)
			{
			if ((enemiesOne[eOne].x < carl_mc.x + 350) && (enemiesOne[eOne].x > carl_mc.x - 350) && (enemiesOne[eOne].y < carl_mc.y + 350) && (enemiesOne[eOne].y > carl_mc.y - 350))
			{
				switch (carl_mc.carlCurrentWeapon)
				{
					case 1:
					if ((carl_mc.clip > 0) && (carl_mc.carlFireRate == 0) && (enemiesOne[eOne].health > 0))
					{
						//ROTATE CARL
						{
						var c5y:Number = enemiesOne[eOne].y - (carl_mc.y); 
						var c5x:Number = enemiesOne[eOne].x - carl_mc.x;
								
						// find out the angle
						var rotRadians5:Number = Math.atan2(c5y,c5x);
								
						// convert to degrees to rotate
						var rotDegrees5:Number = rotRadians5 * 180 / Math.PI;
									
						carl_mc.rotation = rotDegrees5 + 90;
						}
						
						
						pb = new carlBullet;
						addChild(pb);
						pb.cacheAsBitmap = true;
						addGunFlash(carl_mc.x, carl_mc.y);
						
						if((Math.floor(Math.random() * (1 - 0 + 1)) + 0) == 0)
						{
							pb.rotation = (carl_mc.rotation - 90) + (Math.floor(Math.random() * (carlAccLow - (-1 * carlAccLow) + 1)) + (-1 * carlAccLow))/22;
						}
						else
						{
							pb.rotation = ((carl_mc.rotation - 90) + ((Math.floor(Math.random() * (carlAccLow - (-1 * carlAccLow) + 1)) + (-1 * carlAccLow))/22) * -1);
						}
						
						pb.x = carl_mc.x;
						pb.y = carl_mc.y;
						bullets.push(pb);
						
						carl_mc.gotoAndStop(1);
						carl_mc.rifle_mc.gotoAndPlay(2);
						sniperShot.play();
						carl_mc.carlFireRate = carlFireRate * 10;
						carl_mc.clip--;
					}
					break;
					
					case 2:
					if ((carl_mc.pistolClip > 0) && (carl_mc.carlFireRate == 0) && (enemiesOne[eOne].health > 0))
					{
						//ROTATE CARL
						{
						var c6y:Number = enemiesOne[eOne].y - (carl_mc.y); 
						var c6x:Number = enemiesOne[eOne].x - carl_mc.x;
								
						// find out the angle
						var rotRadians6:Number = Math.atan2(c6y,c6x);
								
						// convert to degrees to rotate
						var rotDegrees6:Number = rotRadians6 * 180 / Math.PI;
									
						carl_mc.rotation = rotDegrees6 + 90;
						}
						
						
						pb = new pistolBullet;
						addChild(pb);
						pb.cacheAsBitmap = true;
						pb.tag = 2;
						addGunFlash(carl_mc.x, carl_mc.y);
						
						if((Math.floor(Math.random() * (1 - 0 + 1)) + 0) == 0)
						{
							pb.rotation = (carl_mc.rotation - 90) + (Math.floor(Math.random() * (pistolAccHigh - (-1 * pistolAccHigh) + 1)) + (-1 * pistolAccHigh))/22;
						}
						else
						{
							pb.rotation = ((carl_mc.rotation - 90) + ((Math.floor(Math.random() * (pistolAccHigh - (-1 * pistolAccHigh) + 1)) + (-1 * pistolAccHigh))/22) * -1);
						}
						
						pb.x = carl_mc.x;
						pb.y = carl_mc.y;
						bullets.push(pb);
						
						carl_mc.gotoAndStop(2);
						carl_mc.pistol_mc.gotoAndPlay(2);
						pistolShot.play();
						carl_mc.carlFireRate = carlFireRate * 2;
						carl_mc.pistolClip--;
					}
					break;
				}
			}
			}
		}
		
		//MOVE AROUND
		if ((carl_mc.x > 340) || (carl_mc.x < 300) || (carl_mc.y > 260) || (carl_mc.y < 220))
		{
			if (carl_mc.carlFireRate == 0)
			{
			var cqy:Number = 240 - (carl_mc.y);
			var cqx:Number = 320 - carl_mc.x;
			
			// find out the angle
			var rotRadiansq:Number = Math.atan2(cqy,cqx);
			
			// convert to degrees to rotate
			var rotDegreesq:Number = rotRadiansq * 180 / Math.PI;
			
			carl_mc.rotation = rotDegreesq + 90;
			
			carl_mc.x = (carl_mc.x + Math.cos((carl_mc.rotation - 90)/180*Math.PI)* 1);
			carl_mc.y = (carl_mc.y + Math.sin((carl_mc.rotation - 90)/180*Math.PI)* 1);
			}
		}
		
		//GET AMMO
		if ((carl_mc.clip <= 0) && (carlAmmo <= 0) && (carlPistolAmmo <= 0) && (carl_mc.pistolClip <= 0) && (ammo.length > 0))
		{
			for (var sac:Number = ammo.length - 1; sac >= 0; sac--)
			{
				//ROTATE squeakers
				{
					var c6y2dasc:Number = ammo[sac].y - (carl_mc.y); 
					var c6x2dasc:Number = ammo[sac].x - carl_mc.x;
							
				    //find out the angle
					var rotRadians62dasc:Number = Math.atan2(c6y2dasc,c6x2dasc);
								
					// convert to degrees to rotate
					var rotDegrees62dasc:Number = rotRadians62dasc * 180 / Math.PI;
									
					carl_mc.rotation = rotDegrees62dasc + 90;
				}
				
				carl_mc.x = (carl_mc.x + Math.cos((carl_mc.rotation - 90)/180*Math.PI) * 7);
				carl_mc.y = (carl_mc.y + Math.sin((carl_mc.rotation - 90)/180*Math.PI) * 7);
				
				sac = -1;
			}
		}
		
		}
		
		if ((carlHealth <= 0) && (!gameOver)) //DOWN
		{
			carl_mc.alpha -= .00000001;
			reviveCircle2_mc.gotoAndStop(1);
			
			var tempCH:Number = carl_mc.alpha;
			
			if (carl_mc.visible == true)
			{
			switch (currentPlayer) //CURRENT PLAYER IN CIRCLE
			{
				case 1:
				if (reviveCircle2_mc.hitTestPoint(norm_mc.x, norm_mc.y, true))
				{
					carl_mc.alpha += .01;
					reviveCircle2_mc.gotoAndStop(2);
				}
				break;
				
				case 3:
				if (reviveCircle2_mc.hitTestPoint(squeakers_mc.x, squeakers_mc.y, true))
				{
					carl_mc.alpha += .01;
					reviveCircle2_mc.gotoAndStop(2);
				}
				break;
				
				case 4:
				if (reviveCircle2_mc.hitTestPoint(happy_mc.x, happy_mc.y, true))
				{
					carl_mc.alpha += .01;
					reviveCircle2_mc.gotoAndStop(2);
				}
				break;
			}
			}
			
			if (carl_mc.alpha >= 1)
			{
				hud_mc.carlBox_mc.gotoAndStop(1);
				carlHealth = 20;
				revive.play();
			}
			else if (carl_mc.alpha <= 0)
			{
				carl_mc.visible = false;
				reviveCircle2_mc.visible = false;
				if (!carlDead)
				{
					downed.play();
				}
				carlDead = true;
			}
			else
			{
				if (currentWave == 0)
				{
					if (tempCH == carl_mc.alpha)
					{
						carl_mc.alpha = .7;
					}
				}
			}
		}
		
	}
	
	if (squeakers_mc != null) //UPDATE SQUEAKERS
	{
		squeakers_mc.updateSqueakers();
		
		if ((currentPlayer != 3) && (squeakersHealth > 0)) //IF NOT SELECTED
		{
		for (var eOneNs:Number = enemiesOne.length - 1; eOneNs >= 0; eOneNs--) 
		{
			//ATTACK
			if ((enemiesOne[eOneNs].x < squeakers_mc.x + 80) && (enemiesOne[eOneNs].x > squeakers_mc.x - 80) && (enemiesOne[eOneNs].y < squeakers_mc.y + 80) && (enemiesOne[eOneNs].y > squeakers_mc.y - 80))
			{
				switch (squeakers_mc.squeakersCurrentWeapon)
				{
					case 1:
					if ((squeakers_mc.clip > 0) && (squeakers_mc.squeakersFireRate == 0) && (enemiesOne[eOneNs].health > 0))
					{
						//ROTATE squeakers
						{
						var c6y21w:Number = enemiesOne[eOneNs].y - (squeakers_mc.y); 
						var c6x21w:Number = enemiesOne[eOneNs].x - squeakers_mc.x;
								
						// find out the angle
						var rotRadians621w:Number = Math.atan2(c6y21w,c6x21w);
								
						// convert to degrees to rotate
						var rotDegrees621w:Number = rotRadians621w * 180 / Math.PI;
									
						squeakers_mc.rotation = rotDegrees621w + 90;
						}
						
						for (var fd:Number = 5; fd >= 0; fd--)
						{
						pb = new squeakersBullet;
						pb.damage /= 2;
						pb.kick--;
						addChild(pb);
						pb.cacheAsBitmap = true;
						
						if((Math.floor(Math.random() * (1 - 0 + 1)) + 0) == 0)
						{
							pb.rotation = (squeakers_mc.rotation - 90) + (Math.floor(Math.random() * (squeakersAccLow - (-1 * squeakersAccLow) + 1)) + (-1 * squeakersAccLow))/22;
						}
						else
						{
							pb.rotation = ((squeakers_mc.rotation - 90) + ((Math.floor(Math.random() * (squeakersAccLow - (-1 * squeakersAccLow) + 1)) + (-1 * squeakersAccLow))/22) * -1);
						}
						
						pb.x = squeakers_mc.x;
						pb.y = squeakers_mc.y;
						bullets.push(pb);
						}
						addGunFlash(squeakers_mc.x, squeakers_mc.y);
						squeakers_mc.gotoAndStop(1);
						squeakers_mc.rifle_mc.gotoAndPlay(2);
						shotgunShot.play();
						squeakers_mc.squeakersFireRate = squeakersFireRate * 9;
						squeakers_mc.clip--;
					}
					break;
					
					case 2:
					if ((squeakers_mc.pistolClip > 0) && (squeakers_mc.squeakersFireRate == 0) && (enemiesOne[eOneNs].health > 0))
					{
						//ROTATE squeakers
						{
						var c6y12q:Number = enemiesOne[eOneNs].y - (squeakers_mc.y); 
						var c6x12q:Number = enemiesOne[eOneNs].x - squeakers_mc.x;
								
						// find out the angle
						var rotRadians612q:Number = Math.atan2(c6y12q,c6x12q);
								
						// convert to degrees to rotate
						var rotDegrees612q:Number = rotRadians612q * 180 / Math.PI;
									
						squeakers_mc.rotation = rotDegrees612q + 90;
						}
						
						
						pb = new pistolBullet;
						addChild(pb);
						pb.cacheAsBitmap = true;
						pb.tag = 3;
						addGunFlash(squeakers_mc.x, squeakers_mc.y);
						
						if((Math.floor(Math.random() * (1 - 0 + 1)) + 0) == 0)
						{
							pb.rotation = (squeakers_mc.rotation - 90) + (Math.floor(Math.random() * (pistolAccHigh - (-1 * pistolAccHigh) + 1)) + (-1 * pistolAccHigh))/22;
						}
						else
						{
							pb.rotation = ((squeakers_mc.rotation - 90) + ((Math.floor(Math.random() * (pistolAccHigh - (-1 * pistolAccHigh) + 1)) + (-1 * pistolAccHigh))/22) * -1);
						}
						
						pb.x = squeakers_mc.x;
						pb.y = squeakers_mc.y;
						bullets.push(pb);
						
						squeakers_mc.gotoAndStop(2);
						squeakers_mc.pistol_mc.gotoAndPlay(2);
						pistolShot.play();
						squeakers_mc.squeakersFireRate = squeakersFireRate;
						squeakers_mc.pistolClip--;
					}
					break;
				}
				
				/*if ((squeakers_mc.reloadTimer == -1) && ((enemiesOne[eOneNs].x > squeakers_mc.x + 50) || (enemiesOne[eOneNs].x < squeakers_mc.x - 50) || (enemiesOne[eOneNs].y < squeakers_mc.y - 50) || (enemiesOne[eOneNs].y > squeakers_mc.y + 50)))
				{
					squeakers_mc.x = (squeakers_mc.x + Math.cos((squeakers_mc.rotation - 90)/180*Math.PI)/ 12);
					squeakers_mc.y = (squeakers_mc.y + Math.sin((squeakers_mc.rotation - 90)/180*Math.PI)/ 12);
				}*/
			}
			else if ((enemiesOne[eOneNs].x < squeakers_mc.x + 400) && (enemiesOne[eOneNs].x > squeakers_mc.x - 400) && (enemiesOne[eOneNs].y < squeakers_mc.y + 400) && (enemiesOne[eOneNs].y > squeakers_mc.y - 400))
			{
				if (enemiesOne[eOneNs].inbounds)
				{
				switch (squeakers_mc.squeakersCurrentWeapon)
				{
					case 1:
					if ((squeakers_mc.clip > 0) && (squeakers_mc.squeakersFireRate == 0) && (enemiesOne[eOneNs].health > 0))
					{
						//ROTATE squeakers
						{
						var c6y2d:Number = enemiesOne[eOneNs].y - (squeakers_mc.y); 
						var c6x2d:Number = enemiesOne[eOneNs].x - squeakers_mc.x;
								
						// find out the angle
						var rotRadians62d:Number = Math.atan2(c6y2d,c6x2d);
								
						// convert to degrees to rotate
						var rotDegrees62d:Number = rotRadians62d * 180 / Math.PI;
									
						squeakers_mc.rotation = rotDegrees62d + 90;
						}
						
						/*for (var as3:Number = 5; as3 >= 0; as3--)
						{
						var nb1r = new squeakersBullet;
						bullets.push(nb1r);
						addChild(nb1r);
						addGunFlash(squeakers_mc.x, squeakers_mc.y);
						
						if((Math.floor(Math.random() * (1 - 0 + 1)) + 0) == 0)
						{
							nb1r.rotation = (squeakers_mc.rotation - 90) + (Math.floor(Math.random() * ((squeakersAccLow + 40) - (-1 * (squeakersAccLow + 40)) + 1)) + (-1 * (squeakersAccLow + 40)))/22;
						}
						else
						{
							nb1r.rotation = ((squeakers_mc.rotation - 90) + ((Math.floor(Math.random() * ((squeakersAccLow + 40) - (-1 * (squeakersAccLow + 40)) + 1)) + (-1 * (squeakersAccLow + 40)))/22) * -1);
						}
						
						nb1r.x = squeakers_mc.x;
						nb1r.y = squeakers_mc.y;
						}
						
						squeakers_mc.gotoAndStop(1);
						squeakers_mc.rifle_mc.gotoAndPlay(2);
						shotgunShot.play();
						squeakers_mc.squeakersFireRate = squeakersFireRate * 3;
						squeakers_mc.clip--;*/
					}
					break;
					
					case 2:
					if ((squeakers_mc.pistolClip > 0) && (squeakers_mc.squeakersFireRate == 0) && (enemiesOne[eOneNs].health > 0))
					{
						//ROTATE squeakers
						{
						var c6y1x:Number = enemiesOne[eOneNs].y - (squeakers_mc.y); 
						var c6x1x:Number = enemiesOne[eOneNs].x - squeakers_mc.x;
								
						// find out the angle
						var rotRadians61x:Number = Math.atan2(c6y1x,c6x1x);
								
						// convert to degrees to rotate
						var rotDegrees61x:Number = rotRadians61x * 180 / Math.PI;
									
						squeakers_mc.rotation = rotDegrees61x + 90;
						}
						
						
						pb= new pistolBullet;
						addChild(pb);
						pb.cacheAsBitmap = true;
						pb.tag = 3;
						addGunFlash(squeakers_mc.x, squeakers_mc.y);
						
						if((Math.floor(Math.random() * (1 - 0 + 1)) + 0) == 0)
						{
							pb.rotation = (squeakers_mc.rotation - 90) + (Math.floor(Math.random() * (pistolAccHigh - (-1 * pistolAccHigh) + 1)) + (-1 * pistolAccHigh))/22;
						}
						else
						{
							pb.rotation = ((squeakers_mc.rotation - 90) + ((Math.floor(Math.random() * (pistolAccHigh - (-1 * pistolAccHigh) + 1)) + (-1 * pistolAccHigh))/22) * -1);
						}
						
						pb.x = squeakers_mc.x;
						pb.y = squeakers_mc.y;
						bullets.push(pb);
						
						squeakers_mc.gotoAndStop(2);
						squeakers_mc.pistol_mc.gotoAndPlay(2);
						pistolShot.play();
						squeakers_mc.squeakersFireRate = squeakersFireRate * 2;
						squeakers_mc.pistolClip--;
					}
					break;
				}
				}
			}
		}
		
		
		if ((squeakers_mc.squeakersFireRate == 0) && (enemiesOne.length > 0)) //MOVE AT TARGET
		{
			squeakers_mc.x = (squeakers_mc.x + Math.cos((squeakers_mc.rotation - 90)/180*Math.PI) * 10);
			squeakers_mc.y = (squeakers_mc.y + Math.sin((squeakers_mc.rotation - 90)/180*Math.PI) * 10);
		}
		
		//MOVE AROUND
		if ((squeakers_mc.x > 50) && (squeakers_mc.x < 590) && (squeakers_mc.y > 50) && (squeakers_mc.y < 430) && (enemiesOne.length == 0))
		{
			if (squeakers_mc.squeakersFireRate == 0)
			{
				//squeakers_mc.x = (squeakers_mc.x + Math.cos((squeakers_mc.rotation - 90)/180*Math.PI) * squeakersSpeed);
				//squeakers_mc.y = (squeakers_mc.y + Math.sin((squeakers_mc.rotation - 90)/180*Math.PI) * squeakersSpeed);
				squeakers_mc.rotation += 10;
			}
		}
		
		//DON'T GO OFF SCREEN
		if ((squeakers_mc.x < 50) || (squeakers_mc.x > 590) || (squeakers_mc.y < 50) || (squeakers_mc.y > 430))
		{
			var cqysf:Number = 240 - (squeakers_mc.y);
			var cqxsf:Number = 320 - squeakers_mc.x;
			
			// find out the angle
			var rotRadiansqsf:Number = Math.atan2(cqysf,cqxsf);
			
			// convert to degrees to rotate
			var rotDegreesqsf:Number = rotRadiansqsf * 180 / Math.PI;
			
			squeakers_mc.rotation = rotDegreesqsf + 90;
			
			squeakers_mc.x = (squeakers_mc.x + Math.cos((squeakers_mc.rotation - 90)/180*Math.PI)* squeakersSpeed);
			squeakers_mc.y = (squeakers_mc.y + Math.sin((squeakers_mc.rotation - 90)/180*Math.PI)* squeakersSpeed);
		}
		
		//GET AMMO
		if ((squeakers_mc.clip <= 0) && (squeakersAmmo <= 0) && (squeakersPistolAmmo <= 0) && (squeakers_mc.pistolClip <= 0) && (ammo.length > 0))
		{
			for (var sa:Number = ammo.length - 1; sa >= 0; sa--)
			{
				//ROTATE squeakers
				{
					var c6y2das:Number = ammo[sa].y - (squeakers_mc.y); 
					var c6x2das:Number = ammo[sa].x - squeakers_mc.x;
							
				    //find out the angle
					var rotRadians62das:Number = Math.atan2(c6y2das,c6x2das);
								
					// convert to degrees to rotate
					var rotDegrees62das:Number = rotRadians62das * 180 / Math.PI;
									
					squeakers_mc.rotation = rotDegrees62das + 90;
				}
				
				squeakers_mc.x = (squeakers_mc.x + Math.cos((squeakers_mc.rotation - 90)/180*Math.PI) * 10);
				squeakers_mc.y = (squeakers_mc.y + Math.sin((squeakers_mc.rotation - 90)/180*Math.PI) * 10);
				sa = -1;
			}
		}
		
		}
		
		if ((squeakersHealth <= 0) && (!gameOver)) //DOWN
		{
			squeakers_mc.alpha -= .00000001;
			reviveCircle3_mc.gotoAndStop(1);
			
			var tempSH:Number = squeakers_mc.alpha;
			
			if (squeakers_mc.visible == true)
			{
			switch (currentPlayer) //CURRENT PLAYER IN CIRCLE
			{
				case 2:
				if (reviveCircle3_mc.hitTestPoint(carl_mc.x, carl_mc.y, true))
				{
					squeakers_mc.alpha += .01;
					reviveCircle3_mc.gotoAndStop(2);
				}
				break;
				
				case 1:
				if (reviveCircle3_mc.hitTestPoint(norm_mc.x, norm_mc.y, true))
				{
					squeakers_mc.alpha += .01;
					reviveCircle3_mc.gotoAndStop(2);
				}
				break;
				
				case 4:
				if (reviveCircle3_mc.hitTestPoint(happy_mc.x, happy_mc.y, true))
				{
					squeakers_mc.alpha += .01;
					reviveCircle3_mc.gotoAndStop(2);
				}
				break;
			}
			}
			
			if (squeakers_mc.alpha >= 1)
			{
				hud_mc.squeakersBox_mc.gotoAndStop(1);
				if (currentWave != 0)
				{
					squeakersHealth = 20;
					revive.play();
				}
				else
				{
					squeakersHealth = 100;
					revive.play();
				}
			}
			else if (squeakers_mc.alpha <= 0)
			{
				squeakers_mc.visible = false;
				reviveCircle3_mc.visible = false;
				if (!squeakersDead)
				{
					downed.play();
				}
				squeakersDead = true;
			}
			else
			{
				if (currentWave == 0)
				{
					if (tempSH == squeakers_mc.alpha)
					{
						squeakers_mc.alpha = .7;
					}
				}
			}
		}
	}
	
	if (happy_mc != null) //UPDATE HAPPY
	{
		happy_mc.updateHappy();
		
		if ((currentPlayer != 4) && (happyHealth > 0)) //IF NOT SELECTED
		{
		
		for (var eOneNh:Number = enemiesOne.length - 1; eOneNh >= 0; eOneNh--) 
		{
			//ATTACK
			if (enemiesOne[eOneNh].inbounds)
			{
			if ((enemiesOne[eOneNh].x < happy_mc.x + 300) && (enemiesOne[eOneNh].x > happy_mc.x - 300) && (enemiesOne[eOneNh].y < happy_mc.y + 300) && (enemiesOne[eOneNh].y > happy_mc.y - 300))
			{
				switch (happy_mc.happyCurrentWeapon)
				{
					case 1:
					if ((happy_mc.clip > 0) && (happy_mc.happyFireRate == 0) && (enemiesOne[eOneNh].health > 0))
					{
						//ROTATE happy
						{
						var c6y2h:Number = enemiesOne[eOneNh].y - (happy_mc.y); 
						var c6x2h:Number = enemiesOne[eOneNh].x - happy_mc.x;
								
						// find out the angle
						var rotRadians62h:Number = Math.atan2(c6y2h,c6x2h);
								
						// convert to degrees to rotate
						var rotDegrees62h:Number = rotRadians62h * 180 / Math.PI;
									
						happy_mc.rotation = rotDegrees62h + 90;
						}
						
						
						pb = new happyBullet;
						addChild(pb);
						pb.cacheAsBitmap = true;
						addGunFlash(happy_mc.x, happy_mc.y);
						
						if((Math.floor(Math.random() * (1 - 0 + 1)) + 0) == 0)
						{
							pb.rotation = (happy_mc.rotation - 90) + (Math.floor(Math.random() * ((happyAccLow + 70) - (-1 * (happyAccLow + 40)) + 1)) + (-1 * (happyAccLow + 70)))/22;
						}
						else
						{
							pb.rotation = ((happy_mc.rotation - 90) + ((Math.floor(Math.random() * ((happyAccLow + 70) - (-1 * (happyAccLow + 40)) + 1)) + (-1 * (happyAccLow + 70)))/22) * -1);
						}
						
						pb.x = happy_mc.x;
						pb.y = happy_mc.y;
						bullets.push(pb);
						
						happy_mc.gotoAndStop(1);
						happy_mc.rifle_mc.gotoAndPlay(2);
						lmgShot.play();
						happy_mc.happyFireRate = happyFireRate * 2;
						happy_mc.clip--;
					}
					break;
					
					case 2:
					if ((happy_mc.pistolClip > 0) && (happy_mc.happyFireRate == 0) && (enemiesOne[eOneNh].health > 0))
					{
						//ROTATE happy
						{
						var c6y1a:Number = enemiesOne[eOneNh].y - (happy_mc.y); 
						var c6x1a:Number = enemiesOne[eOneNh].x - happy_mc.x;
								
						// find out the angle
						var rotRadians61a:Number = Math.atan2(c6y1a,c6x1a);
								
						// convert to degrees to rotate
						var rotDegrees61a:Number = rotRadians61a * 180 / Math.PI;
									
						happy_mc.rotation = rotDegrees61a + 90;
						}
						
						
						pb = new pistolBullet;
						addChild(pb);
						pb.cacheAsBitmap = true;
						pb.tag = 4;
						addGunFlash(happy_mc.x, happy_mc.y);
						
						if((Math.floor(Math.random() * (1 - 0 + 1)) + 0) == 0)
						{
							pb.rotation = (happy_mc.rotation - 90) + (Math.floor(Math.random() * (pistolAccHigh - (-1 * pistolAccHigh) + 1)) + (-1 * pistolAccHigh))/22;
						}
						else
						{
							pb.rotation = ((happy_mc.rotation - 90) + ((Math.floor(Math.random() * (pistolAccHigh - (-1 * pistolAccHigh) + 1)) + (-1 * pistolAccHigh))/22) * -1);
						}
						
						pb.x = happy_mc.x;
						pb.y = happy_mc.y;
						bullets.push(pb);
						
						happy_mc.gotoAndStop(2);
						happy_mc.pistol_mc.gotoAndPlay(2);
						pistolShot.play();
						happy_mc.happyFireRate = happyFireRate * 2;
						happy_mc.pistolClip--;
					}
					break;
				}
			}
			}
		}
		
		if ((happy_mc.happyFireRate == 0) && (enemiesOne.length > 0)) //MOVE AT TARGET
		{
			happy_mc.x = (happy_mc.x + Math.cos((happy_mc.rotation - 90)/180*Math.PI) / 6);
			happy_mc.y = (happy_mc.y + Math.sin((happy_mc.rotation - 90)/180*Math.PI) / 6);
		}
		
		//MOVE AROUND
		if ((happy_mc.x > 50) && (happy_mc.x < 590) && (happy_mc.y > 50) && (happy_mc.y < 430) && (enemiesOne.length == 0))
		{
			if (happy_mc.happyFireRate == 0)
			{
				
				if (happy_mc.steps > 0)
				{
					happy_mc.x = (happy_mc.x + Math.cos((happy_mc.rotation - 90)/180*Math.PI) * .2);
					happy_mc.y = (happy_mc.y + Math.sin((happy_mc.rotation - 90)/180*Math.PI) * .2);
					happy_mc.steps--;
				}
				else
				{
					happy_mc.rotation = (Math.floor(Math.random() * (360 - 1 + 1)) + 1);
					happy_mc.steps = (Math.floor(Math.random() * (700 - 1 + 300)) + 300);
				}
			}
		}
		
		//DON'T GO OFF SCREEN
		if ((happy_mc.x < 50) || (happy_mc.x > 590) || (happy_mc.y < 50) || (happy_mc.y > 430))
		{
			var cqysfd:Number = 240 - (happy_mc.y);
			var cqxsfd:Number = 320 - happy_mc.x;
			
			// find out the angle
			var rotRadiansqsfd:Number = Math.atan2(cqysfd,cqxsfd);
			
			// convert to degrees to rotate
			var rotDegreesqsfd:Number = rotRadiansqsfd * 180 / Math.PI;
			
			happy_mc.rotation = rotDegreesqsfd + 90;
			
			happy_mc.x = (happy_mc.x + Math.cos((happy_mc.rotation - 90)/180*Math.PI)* happySpeed);
			happy_mc.y = (happy_mc.y + Math.sin((happy_mc.rotation - 90)/180*Math.PI)* happySpeed);
		}
		
		//GET AMMO
		if ((happy_mc.clip <= 0) && (happyAmmo <= 0) && (happyPistolAmmo <= 0) && (happy_mc.pistolClip <= 0) && (ammo.length > 0))
		{
			for (var sah:Number = ammo.length - 1; sah >= 0; sah--)
			{
				//ROTATE squeakers
				{
					var c6y2dash:Number = ammo[sah].y - (happy_mc.y); 
					var c6x2dash:Number = ammo[sah].x - happy_mc.x;
							
				    //find out the angle
					var rotRadians62dash:Number = Math.atan2(c6y2dash,c6x2dash);
								
					// convert to degrees to rotate
					var rotDegrees62dash:Number = rotRadians62dash * 180 / Math.PI;
									
					happy_mc.rotation = rotDegrees62dash + 90;
				}
				
				happy_mc.x = (happy_mc.x + Math.cos((happy_mc.rotation - 90)/180*Math.PI) * 5);
				happy_mc.y = (happy_mc.y + Math.sin((happy_mc.rotation - 90)/180*Math.PI) * 5);
				
				sah = -1;
			}
		}
		
		}
		
		if ((happyHealth <= 0) && (!gameOver)) //DOWN
		{
			happy_mc.alpha -= .00000001;
			reviveCircle4_mc.gotoAndStop(1);
			
			var tempHH:Number = happy_mc.alpha;
			
			if (happy_mc.visible == true)
			{
			switch (currentPlayer) //CURRENT PLAYER IN CIRCLE
			{
				case 2:
				if (reviveCircle4_mc.hitTestPoint(carl_mc.x, carl_mc.y, true))
				{
					happy_mc.alpha += .01;
					reviveCircle4_mc.gotoAndStop(2);
				}
				break;
				
				case 3:
				if (reviveCircle4_mc.hitTestPoint(squeakers_mc.x, squeakers_mc.y, true))
				{
					happy_mc.alpha += .01;
					reviveCircle4_mc.gotoAndStop(2);
				}
				break;
				
				case 1:
				if (reviveCircle4_mc.hitTestPoint(norm_mc.x, norm_mc.y, true))
				{
					happy_mc.alpha += .01;
					reviveCircle4_mc.gotoAndStop(2);
				}
				break;
			}
			}
			
			if (happy_mc.alpha >= 1)
			{
				hud_mc.happyBox_mc.gotoAndStop(1);
				if (currentWave != 0)
				{
					happyHealth = 20;
					revive.play();
				}
				else
				{
					happyHealth = 130;
					revive.play();
				}
			}
			else if (happy_mc.alpha <= 0)
			{
				happy_mc.visible = false;
				reviveCircle4_mc.visible = false;
				if (!happyDead)
				{
					downed.play();
				}
				happyDead = true;
			}
			else
			{
				if (currentWave == 0)
				{
					if (tempHH == happy_mc.alpha)
					{
						happy_mc.alpha = .7;
					}
				}
			}
		}
	}
	
	if (tank_mc != null) //UPDATE TANK
	{
		tank_mc.updateTank();
		
		if ((currentPlayer != 5) && (tankHealth > 0)) //ATTACK IF NOT SELECTED
		{
		for (var eOnet:Number = enemiesOne.length - 1; eOnet >= 0; eOnet--) 
		{
			//ATTACK
			if (enemiesOne[eOnet].inbounds)
			{
			if ((enemiesOne[eOnet].x < tank_mc.x + 350) && (enemiesOne[eOnet].x > tank_mc.x - 350) && (enemiesOne[eOnet].y < tank_mc.y + 350) && (enemiesOne[eOnet].y > tank_mc.y - 350))
			{
				
					if ((tank_mc.tankFireRate == 0) && (enemiesOne[eOnet].health > 0))
					{
						//ROTATE TANK
						{
						var c5yt:Number = enemiesOne[eOnet].y - (tank_mc.y); 
						var c5xt:Number = enemiesOne[eOnet].x - tank_mc.x;
								
						// find out the angle
						var rotRadians5t:Number = Math.atan2(c5yt,c5xt);
								
						// convert to degrees to rotate
						var rotDegrees5t:Number = rotRadians5t * 180 / Math.PI;
									
						rotDegrees5t -= tank_mc.rotation;
				
						tank_mc.cannon_mc.rotation =rotDegrees5t + 90;
						}
						
						
						pb = new tankRocket;
						addChild(pb);
						pb.cacheAsBitmap = true;
						addGunFlash(tank_mc.x, tank_mc.y);
						
						pb.rotation = tank_mc.cannon_mc.rotation + tank_mc.rotation - 90;
						
						pb.x = tank_mc.x;
						pb.y = tank_mc.y;
						bullets.push(pb);
						
						tank_mc.gotoAndStop(1);
						tank_mc.cannon_mc.gotoAndPlay(2);
						tankShot.play();
						tank_mc.tankFireRate = tankFireRate * 2;
					}
			}
			}
		}
		
		//MOVE AROUND
		if ((tank_mc.x > 340) || (tank_mc.x < 300) || (tank_mc.y > 350) || (tank_mc.y < 330))
		{
			if (tank_mc.tankFireRate == 0)
			{
			var cqytm:Number = 340 - (tank_mc.y);
			var cqxtm:Number = 320 - tank_mc.x;
			
			// find out the angle
			var rotRadiansqtm:Number = Math.atan2(cqytm,cqxtm);
			
			// convert to degrees to rotate
			var rotDegreesqtm:Number = rotRadiansqtm * 180 / Math.PI;
			
			tank_mc.rotation = rotDegreesqtm + 90;
			
		    tank_mc.x = (tank_mc.x + Math.cos((tank_mc.rotation - 90)/180*Math.PI)* tankSpeed);
			tank_mc.y = (tank_mc.y + Math.sin((tank_mc.rotation - 90)/180*Math.PI)* tankSpeed);
			}
		}
		
		}
		
		
		if (tank_mc.visible == true) //DOWN
		{
			if ((tank_mc.currentFrame == 1) && (tankHealth <= 0))
			{
				tank_mc.gotoAndPlay(2);
				tankExplode.play();
				addBigFlash(tank_mc.x, tank_mc.y);
				_largeExplosion.create(tank_mc.x, tank_mc.y);
				
				var bh12t = new rocketHit;
				bh12t.x = tank_mc.x;
				bh12t.y = tank_mc.y;
				bh12t.width *= 4;
				bh12t.height *= 4;
				addChild(bh12t);
				bulletHits.push(bh12t);
				bh12t.gotoAndPlay(1);
				bh12t.rotation = (Math.floor(Math.random() * (360 - 0 + 1)) + 0)
			}
		}
		if (tankHealth > 0)
		{
			tank_mc.visible = true;
		}
		
	}
	}
}

function updateHUD(evt:Event):void //UPDATE THE HUD
{
	if (hud_mc != null)
	{
	//NORM BOX
	{
		if (currentPlayer == 1)
		{
			hud_mc.normBox_mc.gotoAndStop(2);
		}
		else
		{
			hud_mc.normBox_mc.gotoAndStop(1);
		}
		
		if (normHealth > 0)
		{
			hud_mc.normBox_mc.nameText_txt.text = ("1. Norm");
			hud_mc.normBox_mc.ammoText_txt.text = ("Rifle Ammo" + "\n" + norm_mc.clip + "/" + normAmmo);
			
			if (normAmmo == 0)
			{
				hud_mc.normBox_mc.ammoText_txt.textColor = 0xFF0000;
			}
			else
			{
				hud_mc.normBox_mc.ammoText_txt.textColor = 0xFFFFFF;
			}
			
			if (pistolsUnlocked)
			{
				if (normPistolAmmo == 0)
				{
					hud_mc.normBox_mc.pistolAmmoText_txt.textColor = 0xFF0000;
				}
				else
				{
					hud_mc.normBox_mc.pistolAmmoText_txt.textColor = 0xFFFFFF;
				}
				hud_mc.normBox_mc.pistolAmmoText_txt.text = ("Pistol Ammo" + "\n" + norm_mc.pistolClip + "/" + normPistolAmmo);
			}
			else
			{
				hud_mc.normBox_mc.pistolAmmoText_txt.text = "";
			}
			
			if (normHealth <= 20)
			{
				hud_mc.normBox_mc.healthText_txt.textColor = 0xFF0000;
			}
			else
			{
				hud_mc.normBox_mc.healthText_txt.textColor = 0x00FF00;
			}
			
			hud_mc.normBox_mc.healthText_txt.text = "Health: " + normHealth;
		}
		else if (norm_mc.visible == false)
		{
			hud_mc.normBox_mc.visible = false;
		}
		else
		{
			hud_mc.normBox_mc.gotoAndStop(3);
			hud_mc.normBox_mc.nameText_txt.text = ("Revive" + "\n" + "Norm!");
		}
	}
	
	//CARL BOX
	{
		if (currentPlayer == 2)
		{
			hud_mc.carlBox_mc.gotoAndStop(2);
		}
		else
		{
			hud_mc.carlBox_mc.gotoAndStop(1);
		}
		
		if (carlHealth > 0)
		{
			hud_mc.carlBox_mc.nameText_txt.text = ("2. Carl");
			hud_mc.carlBox_mc.ammoText_txt.text = ("Sniper Ammo" + "\n" + carl_mc.clip + "/" + carlAmmo);
			
			if (carlAmmo <= 0)
			{
				hud_mc.carlBox_mc.ammoText_txt.textColor = 0xFF0000;
			}
			else
			{
				hud_mc.carlBox_mc.ammoText_txt.textColor = 0xFFFFFF;
			}
			
			if (pistolsUnlocked)
			{
				if (carlPistolAmmo <= 0)
				{
					hud_mc.carlBox_mc.pistolAmmoText_txt.textColor = 0xFF0000;
				}
				else
				{
					hud_mc.carlBox_mc.pistolAmmoText_txt.textColor = 0xFFFFFF;
				}
				hud_mc.carlBox_mc.pistolAmmoText_txt.text = ("Pistol Ammo" + "\n" + carl_mc.pistolClip + "/" + carlPistolAmmo);
			}
			else
			{
				hud_mc.carlBox_mc.pistolAmmoText_txt.text = "";
			}
			
			hud_mc.carlBox_mc.healthText_txt.text = "Health: " + carlHealth;
			
			if (carlHealth <= 20)
			{
				hud_mc.carlBox_mc.healthText_txt.textColor = 0xFF0000;
			}
			else
			{
				hud_mc.carlBox_mc.healthText_txt.textColor = 0x00FF00;
			}
		}
		else if (carl_mc.visible == false)
		{
			hud_mc.carlBox_mc.visible = false;
		}
		else
		{
			hud_mc.carlBox_mc.gotoAndStop(3);
			hud_mc.carlBox_mc.nameText_txt.text = ("Revive" + "\n" + "Carl!");
		}
	}
	
	//SQUEAKERS BOX
	{
		if (currentPlayer == 3)
		{
			hud_mc.squeakersBox_mc.gotoAndStop(2);
		}
		else
		{
			hud_mc.squeakersBox_mc.gotoAndStop(1);
		}
		
		if (squeakersHealth > 0)
		{
			hud_mc.squeakersBox_mc.nameText_txt.text = ("3. Squeakers");
			hud_mc.squeakersBox_mc.ammoText_txt.text = ("Shotgun Ammo" + "\n" + squeakers_mc.clip + "/" + squeakersAmmo);
			
			if (squeakersAmmo <= 0)
			{
				hud_mc.squeakersBox_mc.ammoText_txt.textColor = 0xFF0000;
			}
			else
			{
				hud_mc.squeakersBox_mc.ammoText_txt.textColor = 0xFFFFFF;
			}
			
			if (pistolsUnlocked)
			{
				if (squeakersPistolAmmo <= 0)
				{
					hud_mc.squeakersBox_mc.pistolAmmoText_txt.textColor = 0xFF0000;
				}
				else
				{
					hud_mc.squeakersBox_mc.pistolAmmoText_txt.textColor = 0xFFFFFF;
				}
				hud_mc.squeakersBox_mc.pistolAmmoText_txt.text = ("Pistol Ammo" + "\n" + squeakers_mc.pistolClip + "/" + squeakersPistolAmmo);
			}
			else
			{
				hud_mc.squeakersBox_mc.pistolAmmoText_txt.text = "";
			}
			
			if (squeakersHealth <= 20)
			{
				hud_mc.squeakersBox_mc.healthText_txt.textColor = 0xFF0000;
			}
			else
			{
				hud_mc.squeakersBox_mc.healthText_txt.textColor = 0x00FF00;
			}
			hud_mc.squeakersBox_mc.healthText_txt.text = "Health: " + squeakersHealth;
		}
		else if (squeakers_mc.visible == false)
		{
			hud_mc.squeakersBox_mc.visible = false;
		}
		else
		{
			hud_mc.squeakersBox_mc.gotoAndStop(3);
			hud_mc.squeakersBox_mc.nameText_txt.text = ("Revive" + "\n" + "Squeakers!");
		}
	}
	
	//HAPPY BOX
	{
		if (currentPlayer == 4)
		{
			hud_mc.happyBox_mc.gotoAndStop(2);
		}
		else
		{
			hud_mc.happyBox_mc.gotoAndStop(1);
		}
		
		if (happyHealth > 0)
		{
			hud_mc.happyBox_mc.nameText_txt.text = ("4. Happy");
			hud_mc.happyBox_mc.ammoText_txt.text = ("LMG Ammo" + "\n" + happy_mc.clip + "/" + happyAmmo);
			
			if (happyAmmo <= 0)
			{
				hud_mc.happyBox_mc.ammoText_txt.textColor = 0xFF0000;
			}
			else
			{
				hud_mc.happyBox_mc.ammoText_txt.textColor = 0xFFFFFF;
			}
			
			if (pistolsUnlocked)
			{
				if (happyPistolAmmo <= 0)
				{
					hud_mc.happyBox_mc.pistolAmmoText_txt.textColor = 0xFF0000;
				}
				else
				{
					hud_mc.happyBox_mc.pistolAmmoText_txt.textColor = 0xFFFFFF;
				}
				hud_mc.happyBox_mc.pistolAmmoText_txt.text = ("Pistol Ammo" + "\n" + happy_mc.pistolClip + "/" + happyPistolAmmo);
			}
			else
			{
				hud_mc.happyBox_mc.pistolAmmoText_txt.text = "";
			}
			
			if (happyHealth <= 20)
			{
				hud_mc.happyBox_mc.healthText_txt.textColor = 0xFF0000;
			}
			else
			{
				hud_mc.happyBox_mc.healthText_txt.textColor = 0x00FF00;
			}
			
			hud_mc.happyBox_mc.healthText_txt.text = "Health: " + happyHealth;
		}
		else if (happy_mc.visible == false)
		{
			hud_mc.happyBox_mc.visible = false;
		}
		else
		{
			hud_mc.happyBox_mc.gotoAndStop(3);
			hud_mc.happyBox_mc.nameText_txt.text = ("Revive" + "\n" + "Happy!");
		}
	}
	
	//TANK BOX
	{
		if (currentPlayer == 5)
		{
			hud_mc.tankBox_mc.gotoAndStop(2);
		}
		else
		{
			hud_mc.tankBox_mc.gotoAndStop(1);
		}
		
		if (tankHealth > 0)
		{
			hud_mc.tankBox_mc.nameText_txt.text = ("5. Tank");
			hud_mc.tankBox_mc.healthText_txt.text = "Health: " + tankHealth;
			
			if (tankHealth <= 50)
			{
				hud_mc.tankBox_mc.healthText_txt.textColor = 0xFF0000;
			}
			else
			{
				hud_mc.tankBox_mc.healthText_txt.textColor = 0x00FF00;
			}
		}
		else if (tankHealth <= 0)
		{
			hud_mc.tankBox_mc.visible = false;
		}
	}
	
	//ROCKET BOX
	{
		if (rocketsUnlocked)
		{
			hud_mc.rocketBlock_mc.visible = true;
			hud_mc.rocketBlock_mc.rocketText_txt.text = ("" + rocketAmmo + "");
			
			if (rocketAmmo <= 0)
			{
				hud_mc.rocketBlock_mc.rocketText_txt.textColor = 0xFF0000;
			}
			else
			{
				hud_mc.rocketBlock_mc.rocketText_txt.textColor = 0xFFFFFF;
			}
		}
		else
		{
			hud_mc.rocketBlock_mc.visible = false;
		}
	}
	
	if (nextWaveButton_btn.visible == true)
	{
		hud_mc.pauseText_txt.visible = false;
	}
	else
	{
		hud_mc.pauseText_txt.visible = true;
	}
	
	if (pauseGame)
	{
		hud_mc.pauseScreen_mc.visible = true;
		hud_mc.pauseText_txt.visible = false;
		quitButtonP_btn.visible = true;
	}
	else
	{
		hud_mc.pauseScreen_mc.visible = false;
		hud_mc.pauseText_txt.visible = true;
		quitButtonP_btn.visible = false;
	}
	
	//ADDED AMMO
	{
		if (addedAmmo > 0)
		{
			addedAmmo--;
		}
		else
		{
			hud_mc.addedAmmoText_txt.text = "";
		}
	}
	
	hud_mc.scoreText_txt.text = ("Score: " + score);
	
	
	//REVIVE CIRCLES
	if ((norm_mc != null) && (reviveCircle1_mc != null) && (reviveCircle2_mc != null))
	{
		if (reviveCircle1_mc != null)
		{
			reviveCircle1_mc.x = norm_mc.x;
			reviveCircle1_mc.y = norm_mc.y;
			reviveCircle2_mc.x = carl_mc.x;
			reviveCircle2_mc.y = carl_mc.y;
			reviveCircle3_mc.x = squeakers_mc.x;
			reviveCircle3_mc.y = squeakers_mc.y;
			reviveCircle4_mc.x = happy_mc.x;
			reviveCircle4_mc.y = happy_mc.y;
		}
	
	if ((normHealth <= 0) && (norm_mc.visible == true))
	{
		reviveCircle1_mc.visible = true;
	}
	else
	{
		reviveCircle1_mc.visible = false;
	}
	
	if ((carlHealth <= 0) && (carl_mc.visible == true))
	{
		reviveCircle2_mc.visible = true;
	}
	else
	{
		if (reviveCircle2_mc != null)
		{
		reviveCircle2_mc.visible = false;
		}
	}
	
	if ((squeakersHealth <= 0) && (squeakers_mc.visible == true))
	{
		reviveCircle3_mc.visible = true;
	}
	else
	{
		reviveCircle3_mc.visible = false;
	}
	
	if ((happyHealth <= 0) && (happy_mc.visible == true))
	{
		reviveCircle4_mc.visible = true;
	}
	else
	{
		reviveCircle4_mc.visible = false;
	}
	}
	
	if (!waveDone)
	{
		if (currentWave != 0)
		{
			hud_mc.waveText_txt.text = ("Wave: " + currentWave);
		}
		else
		{
			hud_mc.waveText_txt.text = ("");
		}
		quitButton_btn.visible = false;
		controlsButton_btn.visible = false;
	}
	else
	{
		hud_mc.waveText_txt.text = "";
		if (!tut5Switch)
		{
			tutTimer.start();
			tut5Switch = true;
			saveGame();
		}
	}
	
	if (reload > 0) //RELOAD TEXT
	{
		hud_mc.reloadText_txt.visible = true;
	}
	else
	{
		hud_mc.reloadText_txt.visible = false;
	}
	
	if (mute)
	{
		ex2_mc.visible = true;
	}
	else
	{
		ex2_mc.visible = false;
	}
	
	if ((hud_mc != null) && (tank_mc.parent != null))//RESET INDEXES
	{
		removeChild(tank_mc);
		removeChild(norm_mc);
		removeChild(carl_mc);
		removeChild(squeakers_mc);
		removeChild(happy_mc);
		addChild(tank_mc);
		addChild(norm_mc);
		addChild(carl_mc);
		addChild(squeakers_mc);
		addChild(happy_mc);
	}
	
	if (fadeOut_mc.currentFrame != 119)
	{
	switch (currentPlayer) //SELECTED PLAYER
	{
		case 1:
		norm_mc.playerCircle_mc.visible = true;
		hud_mc.normBox_mc.gotoAndStop(2);
		carl_mc.playerCircle_mc.visible = false;
		//hud_mc.carlBox_mc.gotoAndStop(1);
		squeakers_mc.playerCircle_mc.visible = false;
		//hud_mc.squeakersBox_mc.gotoAndStop(1);
		happy_mc.playerCircle_mc.visible = false;
		//hud_mc.happyBox_mc.gotoAndStop(1);
		tank_mc.playerCircle_mc.visible = false;
		removeChild(norm_mc);
		addChild(norm_mc);
		
		if (normHealth <= 25)
		{
			hud_mc.red_mc.visible = true;
		}
		else
		{
			hud_mc.red_mc.visible = false;
		}
		break;
		
		case 2:
		norm_mc.playerCircle_mc.visible = false;
		//hud_mc.normBox_mc.gotoAndStop(1);
		carl_mc.playerCircle_mc.visible = true;
		hud_mc.carlBox_mc.gotoAndStop(2);
		squeakers_mc.playerCircle_mc.visible = false;
		//hud_mc.squeakersBox_mc.gotoAndStop(1);
		happy_mc.playerCircle_mc.visible = false;
		//hud_mc.happyBox_mc.gotoAndStop(1);
		tank_mc.playerCircle_mc.visible = false;
		removeChild(carl_mc);
		addChild(carl_mc);
		
		if (carlHealth <= 25)
		{
			hud_mc.red_mc.visible = true;
		}
		else
		{
			hud_mc.red_mc.visible = false;
		}
		break;
		
		case 3:
		norm_mc.playerCircle_mc.visible = false;
		//hud_mc.normBox_mc.gotoAndStop(1);
		carl_mc.playerCircle_mc.visible = false;
		//hud_mc.carlBox_mc.gotoAndStop(1);
		squeakers_mc.playerCircle_mc.visible = true;
		hud_mc.squeakersBox_mc.gotoAndStop(2);
		happy_mc.playerCircle_mc.visible = false;
		//hud_mc.happyBox_mc.gotoAndStop(1);
		tank_mc.playerCircle_mc.visible = false;
		removeChild(squeakers_mc);
		addChild(squeakers_mc);
		
		if (squeakersHealth <= 25)
		{
			hud_mc.red_mc.visible = true;
		}
		else
		{
			hud_mc.red_mc.visible = false;
		}
		break;
		
		case 4:
		norm_mc.playerCircle_mc.visible = false;
		//hud_mc.normBox_mc.gotoAndStop(1);
		carl_mc.playerCircle_mc.visible = false;
		//hud_mc.carlBox_mc.gotoAndStop(1);
		squeakers_mc.playerCircle_mc.visible = false;
		//hud_mc.squeakersBox_mc.gotoAndStop(1);
		happy_mc.playerCircle_mc.visible = true;
		hud_mc.happyBox_mc.gotoAndStop(2);
		tank_mc.playerCircle_mc.visible = false;
		removeChild(happy_mc);
		addChild(happy_mc);
		
		if (happyHealth <= 25)
		{
			hud_mc.red_mc.visible = true;
		}
		else
		{
			hud_mc.red_mc.visible = false;
		}
		break;
		
		case 5:
		norm_mc.playerCircle_mc.visible = false;
		//hud_mc.normBox_mc.gotoAndStop(1);
		carl_mc.playerCircle_mc.visible = false;
		//hud_mc.carlBox_mc.gotoAndStop(1);
		squeakers_mc.playerCircle_mc.visible = false;
		//hud_mc.squeakersBox_mc.gotoAndStop(1);
		happy_mc.playerCircle_mc.visible = false;
		//hud_mc.happyBox_mc.gotoAndStop(2);
		tank_mc.playerCircle_mc.visible = true;
		hud_mc.tankBox_mc.gotoAndStop(2);
		removeChild(tank_mc);
		addChild(tank_mc);
		
		if (tankHealth <= 50)
		{
			hud_mc.red_mc.visible = true;
		}
		else
		{
			hud_mc.red_mc.visible = false;
		}
		break;
	}
	}
	
	//ENEMY INDEX
	for (var ez:Number = enemiesOne.length - 1; ez >= 0; ez--)
	{
		if ((enemiesOne[ez].currentFrame == 1) || (enemiesOne[ez] is enemyTank)) 
		{
			removeChild(enemiesOne[ez]);
			addChild(enemiesOne[ez]);
		}
	}
	
	if ((pistolsUnlocked) || (rocketsUnlocked))
	{
		if (!tut6Switch)
		{
			tutTimer.start();
			hud_mc.tutBox_mc.gotoAndStop(6);
			tut6Switch = true;
			saveGame();
		}
	}
	
	if (tankHealth > 0)
	{
		if (!tut7Switch)
		{
			tutTimer.start();
			hud_mc.tutBox_mc.gotoAndStop(7);
			tut7Switch = true;
			saveGame();
		}
	}
	
	//WAVE COMPLETED
	if (waveDone)
	{
		nextWaveButton_btn.visible = true;
		shopButton_btn.visible = true;
		quitButton_btn.visible = true;
		controlsButton_btn.visible = true;
		hud_mc.eventText_mc.visible = true;
		hud_mc.eventText_mc.eventText_txt.text = ("Wave Complete");
	}
	
	{
		
		if (black_mc.parent != null)
		{
			removeChild(black_mc);
			addChild(black_mc);
		}
		
		for (var vr:Number = points.length - 1; vr >= 0; vr--)
		{
			removeChild(points[vr]);
			addChild(points[vr]);
		}
		
		if (fadeOut_mc.currentFrame != 119)
		{
		removeChild(muteButton2_btn);
		addChild(muteButton2_btn);
		removeChild(ex2_mc);
		addChild(ex2_mc);
		ex2_mc.mouseEnabled = false;
		}
		
		if (hud_mc.parent != null)
		{
			removeChild(hud_mc);
			addChild(hud_mc);
		}
		
		if ((nextWaveButton_btn.visible == true) && (fadeOut_mc.currentFrame != 119))
		{
			removeChild(nextWaveButton_btn);
			addChild(nextWaveButton_btn);
			removeChild(shopButton_btn);
			addChild(shopButton_btn);
			removeChild(quitButton_btn);
			addChild(quitButton_btn);
			removeChild(controlsButton_btn);
			addChild(controlsButton_btn);
		}
		
		
		removeChild(controlsScreen_mc);
		addChild(controlsScreen_mc);
		removeChild(controlsBackButton_btn);
		addChild(controlsBackButton_btn);
		
		removeChild(quitButtonP_btn);
		addChild(quitButtonP_btn);
		removeChild(cursor_mc);
		addChild(cursor_mc);
		removeChild(damageFlash_mc);
		addChild(damageFlash_mc);
		removeChild(fade_mc);
		addChild(fade_mc);
		removeChild(fadeOut_mc);
		addChild(fadeOut_mc);
	} //RESET MORE INDEXES
	
}
}

function nextTut(evt:TimerEvent):void //HANDLE TIMERS
{
	tutTimer.stop();
	
	if (tutStage == 0)
	{
		if (hud_mc.tutBox_mc.currentFrame == 1)
		{
			hud_mc.tutBox_mc.visible = true;
			tutStage = 1;
			tutTimer.start();
		}
		else if (hud_mc.tutBox_mc.currentFrame == 2)
		{
			hud_mc.tutBox_mc.visible = true;
			tutStage = 2;
			tutTimer.start();
		}
		else if (hud_mc.tutBox_mc.currentFrame == 3)
		{
			hud_mc.tutBox_mc.visible = true;
			tutStage = 3;
			tutTimer.start();
		}
		else if (hud_mc.tutBox_mc.currentFrame == 4)
		{
			hud_mc.tutBox_mc.visible = true;
			tutStage = 4;
			tutTimer.start();
		}
		else if (hud_mc.tutBox_mc.currentFrame == 5)
		{
			hud_mc.tutBox_mc.visible = true;
			tutStage = 5;
			tutTimer.start();
		}
		else if (hud_mc.tutBox_mc.currentFrame == 6)
		{
			hud_mc.tutBox_mc.visible = true;
			tutStage = 6;
			tutTimer.start();
		}
		else if (hud_mc.tutBox_mc.currentFrame == 7)
		{
			hud_mc.tutBox_mc.visible = true;
			tutStage = 7;
			tutTimer.start();
		}
		else if (hud_mc.tutBox_mc.currentFrame == 8)
		{
			hud_mc.tutBox_mc.visible = true;
			tutStage = 8;
			tutTimer.start();
		}
	}
	else
	{
		if (tutStage == 1)
		{
			hud_mc.tutBox_mc.visible = false;
			hud_mc.tutBox_mc.gotoAndStop(2);
			tutStage = 0;
			tutTimer.start();
		}
		else if (tutStage == 2)
		{
			hud_mc.tutBox_mc.visible = false;
			hud_mc.tutBox_mc.gotoAndStop(3);
			tutStage = 0;
			tutTimer.start();
		}
		else if (tutStage == 3)
		{
			hud_mc.tutBox_mc.visible = false;
			hud_mc.tutBox_mc.gotoAndStop(4);
			tutStage = 0;
			tutTimer.start();
		}
		else if (tutStage == 4)
		{
			hud_mc.tutBox_mc.visible = false;
			hud_mc.tutBox_mc.gotoAndStop(5);
			tutStage = 0;
		}
		else if (tutStage == 5)
		{
			hud_mc.tutBox_mc.visible = false;
			hud_mc.tutBox_mc.gotoAndStop(6);
			tutStage = 0;
		}
		else if (tutStage == 6)
		{
			hud_mc.tutBox_mc.visible = false;
			hud_mc.tutBox_mc.gotoAndStop(7);
			tutStage = 0;
		}
		else if (tutStage == 7)
		{
			hud_mc.tutBox_mc.visible = false;
			hud_mc.tutBox_mc.gotoAndStop(8);
			tutStage = 0;
		}
		else if (tutStage == 8)
		{
			hud_mc.tutBox_mc.visible = false;
			tutStage = 0;
		}
	}
}

function clickButtons(evt:MouseEvent):void //CLICK ON DIFFERENT BUTTONS
{
	if (evt.target == nextWaveButton_btn)
	{
		sniperShot.play();
		waveDone = false;
		nextWaveButton_btn.visible = false;
		shopButton_btn.visible = false;
		earnPoint.play();
		waveTimer.start();
		hud_mc.eventText_mc.visible = true;
		hud_mc.eventText_mc.eventText_txt.text = ("Wave " + currentWave);
	}
	if (evt.target == shopButton_btn)
	{
		sniperShot.play();
		normX = norm_mc.x;
		normY = norm_mc.y;
		carlX = carl_mc.x;
		carlY = carl_mc.y;
		squeakersX = squeakers_mc.x;
		squeakersY = squeakers_mc.y;
		happyX = happy_mc.x;
		happyY = happy_mc.y;
		tankX = tank_mc.x;
		tankY = tank_mc.y;
		
		normAmmo += norm_mc.clip;
		normPistolAmmo += norm_mc.pistolClip;
		carlAmmo += carl_mc.clip;
		carlPistolAmmo += carl_mc.pistolClip;
		squeakersAmmo += squeakers_mc.clip;
		squeakersPistolAmmo += squeakers_mc.pistolClip;
		happyAmmo += happy_mc.clip;
		happyPistolAmmo += happy_mc.pistolClip;
		
		removeEventListeners();
		removeObjects();
		gotoAndStop(6);
	}
	if (evt.target == controlsButton_btn)
	{
		sniperShot.play();
		controlsScreen_mc.visible = true;
		controlsBackButton_btn.visible = true;
		removeChild(controlsBackButton_btn);
		controlsBackButton_btn = null;
		controlsBackButton_btn = new backButton;
		addChild(controlsBackButton_btn);
		controlsBackButton_btn.width = 200;
		controlsBackButton_btn.height = 64;
		controlsBackButton_btn.x = 100.35;
		controlsBackButton_btn.y = 440.30;
	}
	if (evt.target == controlsBackButton_btn)
	{
		sniperShot.play();
		controlsScreen_mc.visible = false;
		controlsBackButton_btn.visible = false;
		removeChild(controlsButton_btn);
		controlsButton_btn = null;
		controlsButton_btn = new controlsButton;
		addChild(controlsButton_btn);
		controlsButton_btn.width = 212;
		controlsButton_btn.height = 45.20;
		controlsButton_btn.x = 106;
		controlsButton_btn.y = 313;
	}
	if ((evt.target == quitButton_btn) || (evt.target == quitButtonP_btn))
	{
		if (fadeOut_mc.currentFrame == 1)
		{
			sniperShot.play();
			fadeOut_mc.gotoAndPlay(2);
			saveGame();
		}
	}
}

function buttonsRoll(evt:MouseEvent):void //ROLL OVER BUTTONS
{
	if ((shopButton_btn.visible == false) && (evt.target != muteButton2_btn))
	{
		stage.focus = this;
	}
	
	if (evt.target == muteButton2_btn)
	{
		if (switchClick)
		{
			menuClick.play();
			switchClick = false;
		}
	}
	if (evt.target == nextWaveButton_btn)
	{
		if (switchClick)
		{
			menuClick.play();
			switchClick = false;
		}
	}
	if (evt.target == quitButton_btn)
	{
		if (switchClick)
		{
			menuClick.play();
			switchClick = false;
		}
	}
	if (evt.target == shopButton_btn)
	{
		if (switchClick)
		{
			menuClick.play();
			switchClick = false;
		}
	}
	if (evt.target == controlsButton_btn)
	{
		if (switchClick)
		{
			menuClick.play();
			switchClick = false;
		}
	}
	if (evt.target == quitButtonP_btn)
	{
		if (switchClick)
		{
			menuClick.play();
			switchClick = false;
		}
	}
	switchClick = true;
}

function calmTrackComplete(evt:Event):void //CALM TRACK DONE
{
	calmTrackChannel.removeEventListener(Event.SOUND_COMPLETE, calmTrackComplete);
	if (nextWaveButton_btn.visible == true)
	{
		calmTrackChannel = calmTrack.play(0, 1);
		calmTrackChannel.addEventListener(Event.SOUND_COMPLETE, calmTrackComplete);
	}
	else
	{
		if (currentWave % 2 == 1)
		{
			actionTrackChannel = actionTrack.play(0, 1);
			actionTrackChannel.addEventListener(Event.SOUND_COMPLETE, actionTrackComplete);
		}
		else
		{
			exciteTrackChannel = exciteTrack.play(0, 1);
			exciteTrackChannel.addEventListener(Event.SOUND_COMPLETE, exciteTrackComplete);
			exciteTimer.start();
		}
	}
}

function exciteTrackComplete(evt:Event):void //EXCITE TRACK DONE
{
	exciteTrackChannel.removeEventListener(Event.SOUND_COMPLETE, exciteTrackComplete);
	
	/*if ((!exciteTimer.running) && (actionTrackChannel.position >= 7888.798185941043))// || ((!exciteTimer.running) && (calmTrackChannel.position >= 14092.471655328798)))
	{
		trace("here");
	if (nextWaveButton_btn.visible == false)
	{
		if (currentWave % 2 == 1)
		{
			actionTrackChannel = actionTrack.play(0, 1);
			actionTrackChannel.addEventListener(Event.SOUND_COMPLETE, actionTrackComplete);
		}
		else
		{
			exciteTrackChannel = exciteTrack.play();
			exciteTrackChannel.addEventListener(Event.SOUND_COMPLETE, exciteTrackComplete);
		}
	}
	else
	{
		calmTrackChannel = calmTrack.play(0, 1);
		calmTrackChannel.addEventListener(Event.SOUND_COMPLETE, calmTrackComplete);
	}
	}*/
}

function exciteTrackFix(evt:Event):void //FIXES EXCITE LAG
{
	//STRT - 46.439909297052154
	//3390.1133786848072
	//3600.0226757369614
	
	/*
	if (exciteTrackChannel.position == 3390.1133786848072)
	{
		if (nextWaveButton_btn.visible == false)
		{
			if (currentWave % 2 != 1)
			{
				exciteTimer.start();
				//exciteTrackChannel = exciteTrack.play();
				//exciteTrackChannel.addEventListener(Event.SOUND_COMPLETE, exciteTrackComplete);
			}
			else
			{
				actionTrackChannel = actionTrack.play(0, 1);
				actionTrackChannel.addEventListener(Event.SOUND_COMPLETE, actionTrackComplete);
			}
		}
		else
		{
			calmTrackChannel = calmTrack.play(0, 1);
			calmTrackChannel.addEventListener(Event.SOUND_COMPLETE, calmTrackComplete);
		}
	}*/
}

function startExciteFix(evt:TimerEvent):void //EXCITE FIX TIMER
{
	exciteTimer.stop();
	if (nextWaveButton_btn.visible == false)
	{
		if (currentWave % 2 == 1)
		{
			actionTrackChannel = actionTrack.play(0, 1);
			actionTrackChannel.addEventListener(Event.SOUND_COMPLETE, actionTrackComplete);
		}
		else
		{
			exciteTrackChannel = exciteTrack.play();
			exciteTrackChannel.addEventListener(Event.SOUND_COMPLETE, exciteTrackComplete);
			exciteTimer.start();
		}
	}
	else
	{
		calmTrackChannel = calmTrack.play(0, 1);
		calmTrackChannel.addEventListener(Event.SOUND_COMPLETE, calmTrackComplete);
	}
}

function actionTrackComplete(evt:Event):void //ACTION TRACK DONE
{
	actionTrackChannel.removeEventListener(Event.SOUND_COMPLETE, actionTrackComplete);
	if (nextWaveButton_btn.visible == false)
	{
		if (currentWave % 2 == 1)
		{
			actionTrackChannel = actionTrack.play(0, 1);
			actionTrackChannel.addEventListener(Event.SOUND_COMPLETE, actionTrackComplete);
		}
		else
		{
			exciteTimer.start();
			exciteTrackChannel = exciteTrack.play(0, 1);
			exciteTrackChannel.addEventListener(Event.SOUND_COMPLETE, exciteTrackComplete);
		}
	}
	else
	{
		calmTrackChannel = calmTrack.play(0, 1);
		calmTrackChannel.addEventListener(Event.SOUND_COMPLETE, calmTrackComplete);
	}
}