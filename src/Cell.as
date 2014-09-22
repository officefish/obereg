package  
{
	/**
	 * ...
	 * @author 
	 */
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	 
	public class Cell extends Sprite
	{
		
		public static const CELL_WIDTH:int = 50;
		
		private var selectRect:Shape
		private var position:Point;
		
		private var emptyFlag:Boolean = true;
		private var exitFlag:Boolean = false;
		private var throneFlag:Boolean = false;
		
		public function Cell(position:Point) 
		{
			this.position = position;
			
			graphics.beginFill (0xCCCCCC, 1);
			graphics.drawRect (0, 0, CELL_WIDTH, CELL_WIDTH);
			graphics.endFill()
			
			selectRect = new Shape ();
			selectRect.graphics.beginFill (0xEEEEEE, 0.8);
			selectRect.graphics.drawRect (0, 0, CELL_WIDTH , CELL_WIDTH );
		}
		
		public function select ():void {
			addChild (selectRect);
			buttonMode = true;
			addEventListener (MouseEvent.CLICK, onCellClick);
		}
		
		public function clear ():void {
			if (this.contains (selectRect))  removeChild (selectRect);
			buttonMode = false;
			removeEventListener (MouseEvent.CLICK, onCellClick);
		}
		
		private function onCellClick (event:MouseEvent) :void {
			dispatchEvent (new CellEvent (CellEvent.CLICK, position));
		}
		
		public function isEmpty () :Boolean {
			return emptyFlag;
		}
		
		public function book () :void {
			emptyFlag = false;
		}
		
		public function empty () :void {
			emptyFlag = true;
		}
		
		public function markAsExit () :void {
			graphics.clear ()
			graphics.beginFill (0xAAAAAA, 1);
			graphics.drawRect (0, 0, CELL_WIDTH, CELL_WIDTH);
			graphics.endFill()
			exitFlag = true;
		}
		
		public function markAsThrone () :void {
			graphics.clear ()
			graphics.beginFill (0xAAAAAA, 1);
			graphics.drawRect (0, 0, CELL_WIDTH, CELL_WIDTH);
			graphics.endFill()
			throneFlag = true;
		}
		
	}

}