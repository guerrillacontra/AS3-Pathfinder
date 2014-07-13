package com.pathfinding 
{
	/**
	 * ...
	 * @author James
	 */
	public class Heuristics 
	{
		
		public static function euclidean(node:GraphNode, goal:GraphNode):Number
		{
			return Math.sqrt((goal.column - node.column) + (goal.row - node.row));
		}
		
		public static function manhattan(node:GraphNode, goal:GraphNode):Number
		{
			return 10 * (Math.abs(goal.column - node.column) + Math.abs(goal.row - node.row));
		}
		
		public static function diagonal(node:GraphNode, goal:GraphNode):Number
		{
			var xDistance:int = Math.abs(goal.column - node.column);
			var yDistance:int = Math.abs(goal.row - node.row);
			
			if (xDistance > yDistance)
			{
				return 14 * yDistance + 10 * (xDistance - yDistance);
			}else
			{
				return 14 * xDistance + 10 * (yDistance-xDistance);
			}
		}
		
	}

}