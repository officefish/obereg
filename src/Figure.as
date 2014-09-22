package  
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import Cell
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
		/**
	 * ...
	 * @author 
	 */
	public class Figure extends Sprite
	{
		
		private var position:Point;
		private var selectable:Boolean = false;
		private var color:uint;
		
		public static const WHITE:uint = 0xFFFFFF;
		public static const BLACK:uint = 0x222222;
		
		private var kingFlag:Boolean = false;
		
		[Embed(source = '../lib/king.png')]
		private var King:Class;
	
		public function Figure(white:Boolean = true, king:Boolean = false) 
		{
			//graphics.beginFill (0xAAAAAA, 1)
			//graphics.drawRect (0, 0, Cell.CELL_WIDTH, Cell.CELL_WIDTH);
			//graphics.endFill();
			
			color = WHITE;
			if (!white) {
				color = BLACK;
			}
			
			graphics.beginFill (color, 1);
			graphics.drawCircle (Cell.CELL_WIDTH/2, Cell.CELL_WIDTH/2, Cell.CELL_WIDTH/2-5)
			graphics.endFill ();
			buttonMode = true;
			
			if (king) {
				kingFlag = true;
				var kingAsset:Bitmap = new King ();
				kingAsset.x = 10;
				kingAsset.y = 10;
				addChild (kingAsset);
			}
			
			addEventListener (MouseEvent.CLICK, onFigureClick);
			
		}
		
		public function getColor () :uint {
			return color;
		}
		
		public function place (pos:Point) :void {
			this.position = pos;
		}
		
		public function setPosition (position:Point) :void {
			this.position = position;
		}
		
		public function getPosition () :Point {
			return position;
		}
		
		public function deselect () :void {
			selectable = false;
		}
		
		public function isKing () :Boolean {
			return kingFlag;
		}
		
		private function onFigureClick (event:MouseEvent) :void {
			if (!selectable) {
				if (getColor() == Transition.getColor()) {
					dispatchEvent (new FigureEvent (FigureEvent.CLICK))
					selectable = true;
				}
				
			}
		}
	}

}