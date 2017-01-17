package 
{
	import flash.display.MovieClip;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	
	public class DocumentClass extends MovieClip 
	{
		public var menuScreen:MenuScreen;
		public var playScreen:AvoiderGame;
		public var gameOverScreen:GameOverScreen;
		public var bool:Boolean;
		public var loadingProgress:LoadingProgress;
 
		public function DocumentClass() 
		{
			loadingProgress = new LoadingProgress();
			loadingProgress.x = 200;
			loadingProgress.y = 150;
			addChild( loadingProgress );
			loaderInfo.addEventListener( Event.COMPLETE, onCompletelyDownloaded );
			loaderInfo.addEventListener( ProgressEvent.PROGRESS, onProgressMade );
		}
		
		public function showMenuScreen():void
		{
			menuScreen = new MenuScreen();
			menuScreen.addEventListener( NavigationEvent.START, onRequestStart );
			menuScreen.x = 0;
			menuScreen.y = 0;
			addChild( menuScreen );			
		}
 
 		public function onCompletelyDownloaded( event:Event ):void
		{
			gotoAndStop(3);
			showMenuScreen();
		}
		
		public function onProgressMade( progressEvent:ProgressEvent ):void
		{
			//trace( loaderInfo.bytesLoaded, loaderInfo.bytesTotal );
			loadingProgress.setValue( Math.floor( 100 * loaderInfo.bytesLoaded / loaderInfo.bytesTotal ) );
		}
 
		public function onAvatarDeath( avatarEvent:AvatarEvent ):void
		{
			var finalScore:Number = playScreen.getFinalScore();
			 
			gameOverScreen = new GameOverScreen();
			gameOverScreen.addEventListener( NavigationEvent.RESTART, onRequestRestart );
			gameOverScreen.x = 0;
			gameOverScreen.y = 0;
			gameOverScreen.setFinalScore( finalScore );
			addChild( gameOverScreen );
 
			playScreen = null;
		}
 
		public function restartGame():void
		{
			playScreen = new AvoiderGame(bool);
			playScreen.addEventListener( AvatarEvent.DEAD, onAvatarDeath );
			playScreen.x = 0;
			playScreen.y = 0;
			addChild( playScreen );
 
			gameOverScreen = null;
		}
		
		public function onRequestRestart( navigationEvent:NavigationEvent ):void
		{
			restartGame();
		}

		
		public function onRequestStart( navigationEvent:NavigationEvent ):void
		{
			bool=menuScreen.getvar();
			playScreen = new AvoiderGame(bool);
			playScreen.addEventListener( AvatarEvent.DEAD, onAvatarDeath );
			playScreen.x = 0;
			playScreen.y = 0;
			addChild( playScreen );
 
			menuScreen = null;
		}

	}
}
