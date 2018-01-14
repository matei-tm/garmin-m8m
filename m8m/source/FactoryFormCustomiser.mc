module FactoryFormCustomiser
{
	class Setter {
		var batteryX;
		var batteryY;
		
		function initialize(settings)
		{
			var width = settings.screenWidth;
			var height = settings.screenHeight;
			var shape = settings.screenShape;
			
			batteryX = 93;
			batteryY = 39;
			
			if (width == 218 && height == 218 && shape == 1)
			{
				batteryX = 145;
				batteryY = 25;
			}
			
			if (width == 240 && height == 240 && shape == 1)
			{
				batteryX = 140;
				batteryY = 25;
			}
			
			if (width == 215 && height == 180 && shape == 2)
			{
				batteryX = 128;
				batteryY = 39;
			}
			
			if (width == 205 && height == 148 && shape == 3)
			{
				batteryX = 160;
				batteryY = 15;
			}
			
		}
	}
}
