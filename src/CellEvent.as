package  
{
	import flash.events.Event;
	import flash.geom.Point;
	/**
	 * ...
	 * @author 
	 */
	public class CellEvent extends Event
	{
		private var position:Point;
		public static const CLICK:String = 'clickOnCell'
		
		public function CellEvent(type:String, position:Point, bubbles:Boolean = false, cancelable:Boolean = false) 
		{
			this.position = position;
			super (type, bubbles, cancelable); 
		}
		
		public function getPosition () :Point {
			return position;
		}
		
	}

}