package 
{
	import flash.display.MovieClip;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.ui.Mouse;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.events.Event;
	import flash.media.SoundChannel;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;

	public class AvoiderGame extends MovieClip 
	{
		public var army:Array;
		public var enemy:Enemy;
		public var avatar:Avatar;
		public var gameTimer:Timer;
		public var useMouseControl:Boolean;
		public var downKeyIsBeingPressed:Boolean;
		public var upKeyIsBeingPressed:Boolean;
		public var leftKeyIsBeingPressed:Boolean;
		public var rightKeyIsBeingPressed:Boolean;
		
		public var backgroundMusic:BackgroundMusic;
		public var bgmSoundChannel:SoundChannel;	//bgm for BackGround Music
		public var enemyAppearSound:EnemyAppearSound;
		public var sfxSoundChannel:SoundChannel;
		
		public var currentLevelData:LevelData;

 
		public function AvoiderGame(on:Boolean) 
		{
			currentLevelData = new LevelData( 1 );
			if ( currentLevelData.backgroundImage == "green" )
			{
				backgroundContainer.addChild( new GreenBackground() );
			}
			else if ( currentLevelData.backgroundImage == "pink" )
			{
				backgroundContainer.addChild( new PinkBackground() );
			}

			backgroundMusic = new BackgroundMusic();
			bgmSoundChannel = backgroundMusic.play();
			bgmSoundChannel.addEventListener( Event.SOUND_COMPLETE, onBackgroundMusicFinished );
			enemyAppearSound = new EnemyAppearSound();

			downKeyIsBeingPressed = false;
			upKeyIsBeingPressed = false;
			leftKeyIsBeingPressed = false;
			rightKeyIsBeingPressed = false;
			useMouseControl = false;

			Mouse.hide();
			army = new Array();
 			var newEnemy = new Enemy( 100,-15 );
			army.push( newEnemy );
			addChild( newEnemy );
 			
			if ( on ==false )
			{
				useMouseControl = true;
			}
			
			avatar = new Avatar();
			addChild( avatar );
			if ( useMouseControl )
			{
				avatar.x = mouseX;
				avatar.y = mouseY;
			}
			else
			{
				avatar.x = 400;
				avatar.y = 550;
			}

			gameTimer = new Timer( 25 );   //ticks every 25ms = 0.025s or 40 times per second
			gameTimer.addEventListener( TimerEvent.TIMER, onTick );
			gameTimer.start();
			addEventListener( Event.ADDED_TO_STAGE, onAddToStage );
		}
		
		public function onAddToStage( event:Event ):void
		{
			stage.addEventListener( KeyboardEvent.KEY_DOWN, onKeyPress );
			stage.addEventListener( KeyboardEvent.KEY_UP, onKeyRelease );
		}

		public function onKeyPress( keyboardEvent:KeyboardEvent ):void
		{
			if ( keyboardEvent.keyCode == Keyboard.DOWN )
			{
				downKeyIsBeingPressed = true;
			}
			else if ( keyboardEvent.keyCode == Keyboard.UP )
			{
				upKeyIsBeingPressed = true;
			}
			else if ( keyboardEvent.keyCode == Keyboard.LEFT )
			{
				leftKeyIsBeingPressed = true;
			}
			else if ( keyboardEvent.keyCode == Keyboard.RIGHT )
			{
				rightKeyIsBeingPressed = true;
			}
		}

		public function onKeyRelease( keyboardEvent:KeyboardEvent ):void
		{
			if ( keyboardEvent.keyCode == Keyboard.DOWN )
			{
				downKeyIsBeingPressed = false;
			}
			if ( keyboardEvent.keyCode == Keyboard.UP )
			{
				upKeyIsBeingPressed = false;
			}
			if( keyboardEvent.keyCode == Keyboard.LEFT )
			{
				leftKeyIsBeingPressed = false;
			}
			if ( keyboardEvent.keyCode == Keyboard.RIGHT )
			{
				rightKeyIsBeingPressed = false;
			}
		}

		public function onTick( timerEvent:TimerEvent ):void 
		{
			if ( Math.random() < currentLevelData.enemySpawnRate )
			{
				var randomX:Number = Math.random() * 800;
				var newEnemy:Enemy = new Enemy( randomX, -15 );
				army.push( newEnemy );
				addChild( newEnemy );
				gameScore.addToValue( 10 );
				sfxSoundChannel = enemyAppearSound.play();
			}

			if ( useMouseControl )
			{
				avatar.x = mouseX;
				avatar.y = mouseY;
			}
			else
			{
				if ( downKeyIsBeingPressed )
				{
					avatar.moveABit( 0, 1 );
				}
				else if ( upKeyIsBeingPressed )
				{
					avatar.moveABit( 0, -1 );
				}
				else if ( leftKeyIsBeingPressed )
				{
					avatar.moveABit( -1, 0 );
				}
				else if ( rightKeyIsBeingPressed )
				{
					avatar.moveABit( 1, 0 );
				}
			}
			
			 if ( avatar.x < ( avatar.width / 2 ) )
			{
				avatar.x = avatar.width / 2;
			}
			if ( avatar.x > 800 - ( avatar.width / 2 ) )
			{
				avatar.x = 800 - ( avatar.width / 2 );
			}
			if ( avatar.y < ( avatar.height / 2 ) )
			{
				avatar.y = avatar.height / 2;
			}
			if ( avatar.y > 600 - ( avatar.height / 2 ) )
			{
				avatar.y = 600 - ( avatar.height / 2 );
			}
			
			var avatarHasBeenHit:Boolean = false;
			for each ( var enemy:Enemy in army ) 
			{
				enemy.moveABit();
				if ( PixelPerfectCollisionDetection.isColliding( avatar, enemy, this, true ) )
				{
					gameTimer.stop();
					avatarHasBeenHit = true;
				}
			}
			if ( avatarHasBeenHit )
			{
				bgmSoundChannel.stop();
				dispatchEvent( new AvatarEvent( AvatarEvent.DEAD ) );
			}
			
			if ( gameScore.currentValue >= currentLevelData.pointsToReachNextLevel )
			{
				currentLevelData = new LevelData( currentLevelData.levelNum + 1 );
				setBackgroundImage();
			}
		}
		
			
		public function getFinalScore():Number
		{
			return gameScore.currentValue;
		}
		
		public function onBackgroundMusicFinished( event:Event ):void
		{
			bgmSoundChannel = backgroundMusic.play();
			bgmSoundChannel.addEventListener( Event.SOUND_COMPLETE, onBackgroundMusicFinished );
		}
		
		public function setBackgroundImage():void
		{
			if ( currentLevelData.backgroundImage == "green" )
			{
				backgroundContainer.addChild( new GreenBackground() );
			}
			else if ( currentLevelData.backgroundImage == "pink" )
			{
				backgroundContainer.addChild( new PinkBackground() );
			}
		}

	}
}

