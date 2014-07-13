package com.pathfinding
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.Dictionary;
	
	/**
	 * ...
	 * @author James
	 */
	public class PathGraphDebugDisplay extends Sprite
	{
		public var resultPaths:Dictionary = new Dictionary();
		
		public function PathGraphDebugDisplay(graph:PathGraph, tileSize:int):void
		{
			super();
			_tileSize = tileSize;
			_graph = graph;
			
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
		}
		
		private function onAdded(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAdded);
			invalidate();
		}
		
		public function invalidate():void
		{
			graphics.clear();
			
			for (var c:int = 0; c < _graph.columns; c++)
			{
				for (var r:int = 0; r < _graph.rows; r++)
				{
					var node:GraphNode = _graph.getNode(c, r);
					
					renderTile(node);
				}
			}
		}
		
		private function renderTile(node:GraphNode):void
		{
			
			graphics.lineStyle(1, 0, .5);
			
			if (node.isWalkable)
			{
				graphics.drawRect(node.getWorldX(_tileSize), node.getWorldY(_tileSize), _tileSize, _tileSize);
			}
			else
			{
				graphics.beginFill(0, .25);
				graphics.drawRect(node.getWorldX(_tileSize), node.getWorldY(_tileSize), _tileSize, _tileSize);
				graphics.endFill();
			}
			
			if (resultPaths[node])
			{
				graphics.beginFill(0xff0000, .5);
				graphics.drawRect(node.getWorldX(_tileSize), node.getWorldY(_tileSize), _tileSize, _tileSize);
				graphics.endFill();
			}
		
			//graphics.lineStyle(2, 0xff0000, .5);
			//
			//for each(var connection:GraphNode in node.surrounding)
			//{
			//	graphics.moveTo(node.getWorldCenterX(_tileSize), node.getWorldCenterY(_tileSize));
			//	graphics.lineTo(connection.getWorldCenterX(_tileSize), connection.getWorldCenterY(_tileSize));
			//}
		}
		
		private var _graph:PathGraph;
		private var _tileSize:int;
	
	}

}