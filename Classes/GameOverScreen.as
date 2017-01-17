package 
{
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.ui.Mouse;
	import flash.net.SharedObject;
 
	public class GameOverScreen extends MovieClip 
	{
		public var sharedObject:SharedObject;
		
		public function GameOverScreen() 
		{
			Mouse.show();
			restartButton.addEventListener( MouseEvent.CLICK, onClickRestart );
			sharedObject = SharedObject.getLocal( "mjwScores" );
		}
 		
		public function onClickRestart( mouseEvent:MouseEvent ) 
		{
			dispatchEvent( new NavigationEvent( NavigationEvent.RESTART ) );
		}
		
		public function setFinalScore( scoreValue:Number ):void
		{
			finalScore.text = scoreValue.toString();
			try
			{
				if ( sharedObject.data.bestScore == null )
				{
					sharedObject.data.bestScore = scoreValue;
				}
				else if ( scoreValue > sharedObject.data.bestScore )
				{
					sharedObject.data.bestScore = scoreValue;
				}
				bestScore.text = sharedObject.data.bestScore.toString();
				sharedObject.flush();
			}
			catch ( sharedObjectError:Error )
			{
				trace( "Caught this error:", sharedObjectError.name, sharedObjectError.message );
				bestScore.text = "???";
			}
		}
		
	}
}
