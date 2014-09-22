package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import Field
	import Figure
	import flash.display.StageScaleMode;
	import flash.display.StageAlign;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author 
	 */
	public class Main extends Sprite 
	{
		private var field:Field;
		
		private var actualFigure:Figure;
		
		public function Main():void 
		{
			if (stage) init();
			
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			field = new Field ();
			field.addEventListener (CellEvent.CLICK, onCellClick, true);
			field.addEventListener (FigureEvent.CLICK, onFigureClick, true);

			addChild (field)
			
			
			placeWhiteFigures ();
			placeBlackFigures ();
			
			
			
			//stage.addEventListener (Event.RESIZE, onResize);
			//stage.addEventListener (MouseEvent.CLICK, onClick);
			onClick(null);
			field.x = 20;
			field.y = 20;
			//onResize (null);
		}
		
		private function placeWhiteFigures () :void {
						
			var figure1:Figure = new Figure ();
			field.placeFigure (figure1, new Point(5, 3))
			
			var figure2:Figure = new Figure ();
			field.placeFigure (figure2, new Point(4, 4))
			
			var figure3:Figure = new Figure ();
			field.placeFigure (figure3, new Point(5, 4))
			
			var figure4:Figure = new Figure ();
			field.placeFigure (figure4, new Point(6, 4))
			
			var figure5:Figure = new Figure ();
			field.addChild (figure5);
			field.placeFigure (figure5, new Point(3, 5))
			
			var figure6:Figure = new Figure ();
			field.placeFigure (figure6, new Point(4, 5))
			
			var figure7:Figure = new Figure ();
			field.placeFigure (figure7, new Point(6, 5))
			
			var figure8:Figure = new Figure ();
			field.placeFigure (figure8, new Point(7, 5))
			
			var figure9:Figure = new Figure ();
			field.placeFigure (figure9, new Point(4, 6))
			
			var figure10:Figure = new Figure ();
			field.placeFigure (figure10, new Point(5, 6))
			
			var figure11:Figure = new Figure ();
			field.placeFigure (figure11, new Point(6, 6))
			
			var figure12:Figure = new Figure ();
			field.placeFigure (figure12, new Point(5, 7))
			
			var king:Figure = new Figure (true, true);
			field.placeFigure (king, new Point(5, 5))
		}
		
		private function placeBlackFigures () :void {
			
			//up group 
			var figure0:Figure = new Figure (false);
			field.placeFigure (figure0, new Point(3, 0))
			
			var figure1:Figure = new Figure (false);
			field.placeFigure (figure1, new Point(4, 0))
			
			var figure2:Figure = new Figure (false);
			field.placeFigure (figure2, new Point(5, 0))
			
			var figure3:Figure = new Figure (false);
			field.placeFigure (figure3, new Point(6, 0))
			
			var figure4:Figure = new Figure (false);
			field.placeFigure (figure4, new Point(5, 1))
			
			var figure5:Figure = new Figure (false);
			field.placeFigure (figure5, new Point(7, 0))
			
			// left
			
			var figure6:Figure = new Figure (false);
			field.placeFigure (figure6, new Point(0, 3))
			
			var figure7:Figure = new Figure (false);
			field.placeFigure (figure7, new Point(0, 4))
			
			var figure8:Figure = new Figure (false);
			field.placeFigure (figure8, new Point(0, 5))
			
			var figure9:Figure = new Figure (false);
			field.placeFigure (figure9, new Point(0, 6))
			
			var figure10:Figure = new Figure (false);
			field.placeFigure (figure10, new Point(0, 7))
			
			var figure11:Figure = new Figure (false);
			field.placeFigure (figure11, new Point(1, 5))
			
			// right
			
			var figure12:Figure = new Figure (false);
			field.placeFigure (figure12, new Point(10, 3))
			
			var figure13:Figure = new Figure (false);
			field.placeFigure (figure13, new Point(10, 4))
			
			var figure14:Figure = new Figure (false);
			field.placeFigure (figure14, new Point(10, 5))
			
			var figure15:Figure = new Figure (false);
			field.placeFigure (figure15, new Point(10, 6))
			
			var figure16:Figure = new Figure (false);
			field.placeFigure (figure16, new Point(10, 7))
			
			var figure17:Figure = new Figure (false);
			field.placeFigure (figure17, new Point(9, 5))
			
			// down
			
			var figure18:Figure = new Figure (false);
			field.placeFigure (figure18, new Point(3, 10))
			
			var figure19:Figure = new Figure (false);
			field.placeFigure (figure19, new Point(4, 10))
			
			var figure20:Figure = new Figure (false);
			field.placeFigure (figure20, new Point(5, 10))
			
			var figure21:Figure = new Figure (false);
			field.placeFigure (figure21, new Point(6, 10))
			
			var figure22:Figure = new Figure (false);
			field.placeFigure (figure22, new Point(7,10))
			
			var figure23:Figure = new Figure (false);
			field.placeFigure (figure23, new Point(5, 9))
			
			
		}
		
		private function onFigureClick (event:FigureEvent) :void {
			field.clear ();
			if (actualFigure) {
				actualFigure.deselect();
			}
			actualFigure = event.target as Figure;
			var pos:Point = actualFigure.getPosition();
			field.drawAvailableSteps (pos, actualFigure);
		}
		
		private function onCellClick (event:CellEvent) :void {
			field.clear();
			field.moveFigure(actualFigure, event.getPosition())
		}
		
		//private function onResize (event:Event) :void {
			
		//}
		
		private function onClick (event:MouseEvent) :void {
			field.clear ();
			//var pos:Point = field.getRandomPosition ();
			//figure.place (pos);
			//
		}
		
	}
	
}