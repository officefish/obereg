package  
{
	import flash.events.Event;
	/**
	 * ...
	 * @author 
	 */
	public class FigureEvent extends Event
	{
		
		public static const CLICK:String = 'figureClick';
		
		public function FigureEvent(type:String, bubbles:Boolean=false, cancelable:Boolean = false) 
		{
			super (type, bubbles, cancelable);
		}
		
	}

}