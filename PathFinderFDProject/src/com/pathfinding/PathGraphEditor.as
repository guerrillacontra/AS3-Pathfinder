package com.pathfinding
{
	import com.vec2d.Point2D;
	import flash.display.Stage;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;
	import flash.utils.Dictionary;
	
	/**
	 * ...
	 * @author James
	 */
	public class PathGraphEditor
	{
		private var _graph:PathGraph;
		private var _display:PathGraphDebugDisplay;
		private var _tileSize:int;
		private var _stage:Stage;
		
		public function PathGraphEditor(graph:PathGraph, display:PathGraphDebugDisplay, stage:Stage, tileSize:int):void
		{
			_stage = stage;
			_tileSize = tileSize;
			_display = display;
			_graph = graph;
		}
		
		public function init():void
		{
			_stage.addEventListener(MouseEvent.CLICK, onClick);
			_stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
		}
		
		private function onKeyUp(e:KeyboardEvent):void
		{
			if (e.keyCode == Keyboard.SPACE)
			{
				
				var path:PathFinder = new PathFinder(_graph);
				
				var result:Vector.<Point2D> = path.findPath(_graph.getNode(0, 0), _graph.getNode(_graph.columns - 1, _graph.rows - 1), Heuristics.diagonal);
				
				_display.resultPaths = new Dictionary();
				
				for each (var p:Point2D in result)
				{
					_display.resultPaths[_graph.getNode(p.x, p.y)] = true;
				}
				
				_display.invalidate();
			}
		}
		
		private function onClick(e:MouseEvent):void
		{
			var x:Number = _stage.mouseX;
			var y:Number = _stage.mouseY;
			
			var c:int = x / _tileSize;
			var r:int = y / _tileSize;
			
			if (_graph.isLegalPosition(c, r))
			{
				var node:GraphNode = _graph.getNode(c, r);
				node.isWalkable = !node.isWalkable;
				
				_display.invalidate();
			}
		}
	
	}

}