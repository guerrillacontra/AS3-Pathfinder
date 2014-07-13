package com.pathfinding
{
	import com.pathfinding.structures.IPrioritizable;
	
	/**
	 * ...
	 * @author James
	 */
	public class GraphNode implements IPrioritizable
	{
		
		public function get F():Number
		{
			return G + H;
		}
		
		public var G:Number = 0;
		public var H:Number = 0;
		
		public var isWalkable:Boolean = true;
		
		public var parent:GraphNode = null;
		
		public var surrounding:Vector.<GraphNode> = new Vector.<GraphNode>();
		
		public function GraphNode(column:int, row:int):void
		{
			_row = row;
			_column = column;
		}
		
		public function getWorldX(tileSize:int):Number
		{
			return _column * tileSize;
		}
		
		public function getWorldY(tileSize:int):Number
		{
			return _row * tileSize;
		}
		
		public function getWorldCenterX(tileSize:int):Number
		{
			return (_column * tileSize) + tileSize * .5;
		}
		
		public function getWorldCenterY(tileSize:int):Number
		{
			return (_row * tileSize) + tileSize * .5;
		}
		
		/* INTERFACE com.pathfinding.structures.IPrioritizable */
		
		public function get priority():Number 
		{
			return -F;
		}
		

		
		public function get column():int
		{
			return _column;
		}
		
		public function get row():int
		{
			return _row;
		}
		
		public function reset():void
		{
			G = 0;
			H = 0;
			parent = null;
		}
		
		private var _column:int;
		private var _row:int;
	
	}

}