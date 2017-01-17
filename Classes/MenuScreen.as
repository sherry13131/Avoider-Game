package 
{
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
 
	public class MenuScreen extends MovieClip 
	{
		public var on:Boolean;
		
		public function MenuScreen() 
		{
			startButton.addEventListener( MouseEvent.CLICK, onClickStart );
     		keyButton.addEventListener( MouseEvent.CLICK, function1);
			mouseButton.addEventListener( MouseEvent.CLICK, function2 );
		}
 
		public function onClickStart( Event:MouseEvent ):void
		{
			dispatchEvent( new NavigationEvent( NavigationEvent.START ) );
		}
		
		public function onClickStart2( Event:MouseEvent ):void
		{
			dispatchEvent( new NavigationEvent( NavigationEvent.START ) );
			
		}
	
		public function function1( Event:MouseEvent ):void
		{
			on=true;
		}
		public function function2( Event:MouseEvent ):void
		{
			on=false;
		}
	
		public function getvar():Boolean
		{
			return on;
		}
	
	}
}
