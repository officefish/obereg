package  
{
	/**
	 * ...
	 * @author 
	 */
	public class Transition 
	{
		
		private static var t_color:uint = Figure.WHITE;
		
		public function Transition() 
		{
			
		}
		
		public static function progress () :void {
			if (t_color == Figure.WHITE) {
				t_color = Figure.BLACK
			} else {
				t_color = Figure.WHITE;
			}
		}
		
		public static function getColor () :uint {
			return t_color;
		}
		
	}

}