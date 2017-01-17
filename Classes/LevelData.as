package
{
	public class LevelData
	{
		public var backgroundImage:String;
		public var pointsToReachNextLevel:Number;
		public var enemySpawnRate:Number;
		public var levelNum:Number;
 
		public function LevelData( levelNumber:Number )
		{
			levelNum = levelNumber;
			if ( levelNumber == 1 )
			{
				backgroundImage = "green";
				pointsToReachNextLevel = 150;
				enemySpawnRate = 0.05;
			}
			else if ( levelNumber == 2 )
			{
				backgroundImage = "pink";
				pointsToReachNextLevel = 400;
				enemySpawnRate = 0.1;
			}
			else if ( levelNumber == 3 )
			{
				backgroundImage = "green";
				pointsToReachNextLevel = 800;
				enemySpawnRate = 0.15;
			}
			else if ( levelNumber == 4 )
			{
				backgroundImage = "pink";
				pointsToReachNextLevel = 1100;
				enemySpawnRate = 0.19;
			}
			else
			{
				backgroundImage = "green";
				pointsToReachNextLevel = levelNumber * 210;
				enemySpawnRate = 0.6 - ( 2 / levelNumber );
			}
		}
	}
}
