package  
{
	/**
	 * ...
	 * @author 
	 */
	import Cell
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.text.TextField;
	import com.greensock.TweenLite;

	 
	public class Field extends Sprite 
	{
		
		private var cells:Array;
		private var movingFigure:Figure;
		private var figures:Array = [];
		private var whitesCount:int = 0;
		private var blacksCount:int = 0;
		
		public function Field() 
		{
			var xPosition:int = 0;
			var yPostition:int = 0;
			cells = [];
			
			for (var i:int = 0; i < 11; i ++)
			{
				xPosition = 0;
				yPostition = (Cell.CELL_WIDTH + 1) * i
				var row:Array = new Array ();
				cells.push (row);
				
				for (var j:int = 0; j < 11; j ++) 
				{
					var cell:Cell = new Cell (new Point(j,i));
					xPosition = (Cell.CELL_WIDTH + 1) * j;
					cell.x = xPosition;
					cell.y = yPostition;
					//var tf:TextField = new TextField ();
					//tf.text = j + ':' + i;
					row.push (cell);
					addChild (cell);
					
					if ( i == 0 && j == 0) {
						cell.markAsExit();
					}
					
					if (i == 10 && j == 0) {
						cell.markAsExit();
					}
					if ( i == 0 && j == 10) {
						cell.markAsExit();
					}
					
					if (i == 10 && j == 10) {
						cell.markAsExit();
					}
					
					if (i == 5 && j == 5) {
						cell.markAsThrone ()
					}
					
				}
			}
			
			
		}
		
		
		
		public function getRandomPosition () :Point {
			var pos:Point = new Point (Math.floor (Math.random() * 9), Math.floor (Math.random() * 9));
			return pos;
		}
		
		public function drawAvailableSteps (pos:Point, figure:Figure) :void {
			var cell:Cell;
			var xCof:int = pos.x - 1;
						 
			while (xCof >= 0) {
				cell = cells[pos.y][xCof]
				if (cell.isEmpty()) {
					cell.select();
					xCof --;
				} else {
					break;
				}
			}
			
			xCof = pos.x + 1; 
			
			while (xCof < 11) {
				cell = cells[pos.y][xCof]
				if (cell.isEmpty()) {
					cell.select();
					xCof ++;
				} else {
					break;
				}
			}
			
			
			var yCof:int = pos.y - 1;
			while (yCof >= 0) {
				cell = cells[yCof][pos.x]
				if (cell.isEmpty()) {
					cell.select();
					yCof --;
				} else {
					break;
				}
				
			}
			
			
			
			yCof = pos.y + 1;
			while (yCof < 11) {
				cell = cells[yCof][pos.x]
				if (cell.isEmpty()) {
					cell.select();
					yCof ++;
				} else {
					break;
				}
			}
			
			if (!figure.isKing()) {
				(cells[0][0] as Cell).clear ();
				(cells[0][10] as Cell).clear ();
				(cells[10][0] as Cell).clear ();
				(cells[10][10] as Cell).clear ();
				(cells[5][5] as Cell).clear ();
			}
			
		}
		
		public function clear ():void {
			for (var i:int = 0; i < 11; i ++)
			{
				for (var j:int = 0; j < 11; j ++)
				{
					cells[i][j].clear ();
				}			
			}
		}
		
		public function placeFigure (figure:Figure, pos:Point) :void {
			this.addChild (figure);
			figure.setPosition (pos);
			figure.x = pos.x * (Cell.CELL_WIDTH + 1);
			figure.y = pos.y * (Cell.CELL_WIDTH + 1);
			bookCell (pos);
			figures.push (figure);
			if (figure.getColor() == Figure.WHITE) {
				whitesCount ++
			} else {
				blacksCount ++;
			}
		}
		
		public function moveFigure (figure:Figure, pos:Point) :void {
			movingFigure = figure;
			emptyCell (figure.getPosition());
			figure.setPosition (pos);
			figure.deselect ();
			TweenLite.to (figure, 0.5, { x:pos.x * (Cell.CELL_WIDTH + 1 ), y:pos.y * (Cell.CELL_WIDTH + 1), onComplete:onTweenComplete} );
		}
		
		private function onTweenComplete () :void {
			var position:Point = movingFigure.getPosition ();
			bookCell (position);
			checkNeighboringCells (position, movingFigure);
			Transition.progress();
			if (movingFigure.isKing()) {
				if (position.x == 0 && position.y == 0) {
					trace ('white wins')
				}
				if (position.x == 10 && position.y == 0) {
					trace ('white wins')
				}
				if (position.x == 10 && position.y == 10) {
					trace ('white wins')
				}
				if (position.x == 0 && position.y == 10) {
					trace ('white wins')
				}
			}
		}
		
		private function checkNeighboringCells (position:Point, figure:Figure):void {
			var workColor:uint;
			if (figure.getColor() == Figure.WHITE) {
				workColor = Figure.BLACK;
			} else {
				workColor = Figure.WHITE;
			}
			
			var workPositions:Array = getWorkPositions (position)
			var workFigures:Array = getWorkFigures (workPositions, workColor)
			var removeFlag:Boolean = false;
			
			
			var actualFigure:Figure;
			for (var i:int = 0; i < workFigures.length; i ++) {
				actualFigure = workFigures[i]
				if (actualFigure.isKing()) {
					if (checkToMat (actualFigure)) {
						trace ("black wins")
						return;
					}
				} else {
					removeFlag = checkToRemove (actualFigure);
					if (removeFlag) {
						removeFigure (actualFigure);
						removeFlag = false;
					}
				}
				
				
			}
		}
		
		private function checkToMat (king:Figure) :Boolean {
			var position:Point = king.getPosition();
			var matCount:int = 0;
			var neightboringFigure:Figure;
			var isMat:Boolean = false;
			
			if (position.x == 0) {
				matCount ++;
			} else {
				neightboringFigure = getFigureByPosition (new Point (position.x - 1, position.y)) 
				if (neightboringFigure != null) {
					if (neightboringFigure.getColor() == Figure.BLACK) {
						matCount ++
					}
				} else {
					if (position.x - 1 == 0 && position.y == 0) {
					matCount ++;
					}
					
					if (position.x - 1 == 5 && position.y == 5) {
						matCount ++;
					}
					
					if (position.x - 1 == 0 && position.y == 10) {
						matCount ++;
					}
				}
			}
			
			if (position.x == 10) {
				matCount ++;
			} else {
				neightboringFigure = getFigureByPosition (new Point (position.x + 1, position.y)) 
				if (neightboringFigure != null) {
					if (neightboringFigure.getColor() == Figure.BLACK) {
						matCount ++
					}
				} else {
					if (position.x + 1 == 10 && position.y == 0) {
					matCount ++;
					}
					
					if (position.x + 1 == 5 && position.y == 5) {
						matCount ++;
					}
					
					if (position.x + 1 == 10 && position.y == 10) {
						matCount ++;
					}
				}
			}
			
			if (position.y == 0) {
				matCount ++;
			} else {
				neightboringFigure = getFigureByPosition (new Point (position.x, position.y -1)) 
				if (neightboringFigure != null) {
					if (neightboringFigure.getColor() == Figure.BLACK) {
						matCount ++
					}
				} else {
					if (position.x == 0 && position.y - 1 == 0) {
					matCount ++;
					}
					
					if (position.x == 5 && position.y - 1 == 5) {
						matCount ++;
					}
					
					if (position.x == 10 && position.y - 1 == 0) {
						matCount ++;
					}
				}
			}
			
			if (position.y == 10) {
				matCount ++;
			} else {
				neightboringFigure = getFigureByPosition (new Point (position.x, position.y + 1)) 
				if (neightboringFigure != null) {
					if (neightboringFigure.getColor() == Figure.BLACK) {
						matCount ++
					}
				} else {
					if (position.x == 0 && position.y + 1 == 10) {
					matCount ++;
					}
					
					if (position.x == 5 && position.y + 1 == 5) {
						matCount ++;
					}
					
					if (position.x == 10 && position.y + 1 == 10) {
						matCount ++;
					}
				}
			}
			
			if (matCount == 4) {
				isMat = true;
			}
			
			return isMat;
		}
		
		private function removeFigure (figure:Figure) :void {
			this.removeChild (figure);
			var figureIndex:int = figures.indexOf (figure);
			figures.splice (figureIndex, 1);
			emptyCell (figure.getPosition());
			if (figure.getColor() == Figure.WHITE) { 
				whitesCount --
			} else {
				blacksCount --
			}
			
			if (blacksCount == 0) {
				trace ('white wins')
			}
		}
		
		private function checkToRemove (figure:Figure) :Boolean {
			var removeFlag:Boolean = false;
			var position:Point = figure.getPosition ();
			var neighboringFigure:Figure;
			var removeNeighboringFlags:int = 0;
			
			if (position.x == 0) {
				removeNeighboringFlags = 0;
			} else {
				neighboringFigure = getFigureByPosition (new Point (position.x - 1, position.y)) 
				if (neighboringFigure != null) {
					if (neighboringFigure.getColor() != figure.getColor()) {
						removeNeighboringFlags = 1;
					} else {
						removeNeighboringFlags = 0;
					}
				} else {
					if (position.x - 1 == 0 && position.y == 0) {
						removeNeighboringFlags = 1;
					} else if (position.x - 1 == 5 && position.y == 5) {
						if ((cells[5][5] as Cell).isEmpty()) {
							removeNeighboringFlags += 2;
						} else {
							removeNeighboringFlags = 0;
						}
						
					}else {
						removeNeighboringFlags = 0;
					}
					
				}
			}
			
			if (position.x == 10) {
				removeNeighboringFlags = 0;
			} else {
				neighboringFigure = getFigureByPosition (new Point (position.x + 1, position.y)) 
				if (neighboringFigure != null) {
					if (neighboringFigure.getColor() != figure.getColor()) {
						removeNeighboringFlags += 2;
					} else {
						removeNeighboringFlags = 0;
					}
				} else {
					if (position.x + 1 == 10 && position.y == 0) {
						removeNeighboringFlags += 2;
					} else if (position.x + 1 == 5 && position.y == 5) {
						if ((cells[5][5] as Cell).isEmpty()) {
							removeNeighboringFlags += 2;
						} else {
							removeNeighboringFlags = 0;
						}
					}else {
						removeNeighboringFlags = 0;
					}
				}
			}
			
			if (removeNeighboringFlags == 3) {
				removeFlag = true;
				return removeFlag;
			} else {
				removeNeighboringFlags = 0;
			}
			
			if (position.y == 0) {
				removeNeighboringFlags = 0;
			} else {
				neighboringFigure = getFigureByPosition (new Point (position.x, position.y - 1)) 
				if (neighboringFigure != null) {
					if (neighboringFigure.getColor() != figure.getColor()) {
						removeNeighboringFlags = 1;
					} else {
						removeNeighboringFlags = 0;
					}
				} else {
					if (position.x == 0 && position.y - 1 == 0) {
						removeNeighboringFlags = 1;
					} else if (position.x == 5 && position.y - 1 == 5) {
						if ((cells[5][5] as Cell).isEmpty()) {
							removeNeighboringFlags += 2;
						} else {
							removeNeighboringFlags = 0;
						}
					} else {
						removeNeighboringFlags = 0;
					}
				}
			}
			
			if (position.y == 10) {
				removeNeighboringFlags = 0;
			} else {
				neighboringFigure = getFigureByPosition (new Point (position.x, position.y + 1)) 
				if (neighboringFigure != null) {
					if (neighboringFigure.getColor() != figure.getColor()) {
						removeNeighboringFlags += 2;
					} else {
						removeNeighboringFlags = 0;
					}
				} else {
					if (position.x == 0 && position.y + 1 == 10) {
						removeNeighboringFlags += 2;
					}
					else if (position.x == 5 && position.y + 1 == 5) {
						if ((cells[5][5] as Cell).isEmpty()) {
							removeNeighboringFlags += 2;
						} else {
							removeNeighboringFlags = 0;
						}
					} else {
						removeNeighboringFlags = 0;
					}
				}
			}
			
			if (removeNeighboringFlags == 3) {
				removeFlag = true;
			}
			
			return removeFlag;
		}
		
		private function getWorkPositions (position:Point) :Array {
			var positions:Array = []
			if (position.x > 0) {
				positions.push (new Point (position.x - 1, position.y));
			}
			if (position.x < 10) {
				positions.push (new Point (position.x + 1, position.y));
			}
			if (position.y > 0) {
				positions.push (new Point (position.x, position.y - 1));
			}
			if (position.y < 10) {
				positions.push (new Point (position.x, position.y + 1));
			}
			return positions;
		}
		
		private function getWorkFigures (workPositions:Array, workColor:uint) :Array {
			var workFigures:Array = [];
			var figure:Figure;
			var position:Point;
			for (var i:int = 0; i < workPositions.length; i ++) {
				position = workPositions[i];
				figure = getFigureByPosition (position); 
				if (figure != null) {
					if (figure.getColor() == workColor) {
						workFigures.push(figure);
					}
				}
			}
			return workFigures;
		}
		
		private function getFigureByPosition (position:Point) :Figure {
			var figure:Figure;
			var figurePosition:Point;
			for (var i:int = 0; i < figures.length; i ++) {
				figure = figures[i];
				figurePosition = figure.getPosition ();
				if (figurePosition.x == position.x && figurePosition.y == position.y) {
					return figure;
				}
			}
			return null;
		}
		
		private function bookCell (pos:Point) :void {
			var cell:Cell = cells[pos.y][pos.x]
			cell.book ();
		}
		
		private function emptyCell (pos:Point) :void {
			var cell:Cell = cells[pos.y][pos.x]
			cell.empty();
		}
	}

}