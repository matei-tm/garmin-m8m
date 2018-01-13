module FactoryFormCustomiser
{
	class Setter {
		var batteryX;
		var batteryY;
		
		function initialize(dc)
		{
			var width = dc.getWidth();
			var height = dc.getHeight();
			
			batteryX = 93;
			batteryY = 39;
			
			if (width == 240 && height == 240)
			{
				batteryX = 140;
				batteryY = 25;
			}
			
		}
	}
}
