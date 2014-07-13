package com.pathfinding
{
	import com.pathfinding.structures.PriorityQueue;
	import com.vec2d.Point2D;
	import flash.utils.Dictionary;
	
	/**
	 * ...
	 * @author James
	 */
	public class PathFinder
	{
		private var _graph:PathGraph;
		
		public function PathFinder(graph:PathGraph):void
		{
			_graph = graph;
		}
		
		public function findPath(start:GraphNode, end:GraphNode, heuristic:Function):Vector.<Point2D>
		{
			
			prepare();
			
			var open:PriorityQueue = new PriorityQueue(_graph.columns * _graph.rows);
			var closed:Vector.<GraphNode> = new Vector.<GraphNode>();
			
			start.G = 0;
			start.H = heuristic(start, end);
			
			open.enqueue(start);
			
			var current:GraphNode = null;
			
			while (!open.isEmpty())
			{
				current = open.dequeue();
				
				if (current == end)
				{
					return createGoal(current);
				}
				
				open.remove(current);
				closed.push(current);
				
				for each (var n:GraphNode in current.surrounding)
				{
					if (closed.indexOf(n) != -1 || !n.isWalkable)
					{
						continue;
					}
					
					if (!open.contains(n))
					{
						n.G = current.G + 1;
						n.H = heuristic(n, end);
						n.parent = current;
						open.enqueue(n);
					}
					else
					{
						if (n.G < current.G)
						{
							n.G = current.G + 1;
							n.parent = current;
							open.enqueue(n);
						}
					}
				}
			}
			
			return null;
		
		}
		
		private function createGoal(n:GraphNode):Vector.<Point2D>
		{
			var result:Vector.<Point2D> = new Vector.<Point2D>();
			
			while (n)
			{
				result.push(new Point2D(n.column, n.row));
				n = n.parent;
			}
			
			return result;
		}
		
		private function prepare():void
		{
			for (var c:int = 0; c < _graph.columns; c++)
			{
				for (var r:int = 0; r < _graph.rows; r++)
				{
					var node:GraphNode = _graph.getNode(c, r);
					node.reset();
				}
			}
		}
	
	}

}