package 
{
	import flash.display.MovieClip;
	public class Enemy extends MovieClip 
	{
		public var xSpeed:Number;	//pixels moved to the right per tick
		public var ySpeed:Number;	//pixels moved downwards per tick
 
		public function Enemy( startX:Number, startY:Number ) 
		{
			x = startX;
			y = startY;
 
			xSpeed = 0;
			ySpeed = Math.random()+Math.random()*2+1;

		}
 
		public function moveABit():void 
		{
			x = x + xSpeed;
			y = y + ySpeed;
		}
	}
}
