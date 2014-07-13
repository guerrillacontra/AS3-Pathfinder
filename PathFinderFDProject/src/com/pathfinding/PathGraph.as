package com.pathfinding 
{
	import com.vec2d.Point2D;
	import com.vec2d.Vector2D;
	/**
	 * ...
	 * @author James
	 */
	public class PathGraph 
	{
				
		public function get nodes():Vector.<Vector.<GraphNode>> 
		{
			return _nodes;
		}
		
		public function get columns():int 
		{
			return _columns;
		}
		
		public function get rows():int 
		{
			return _rows;
		}

		public function init(columns:int, rows:int):void
		{
			_columns = columns;
			_rows = rows;
			
			createNodeInstances();
			createNodeRelationships();
		}
		
		public function isLegalPosition(c:int, r:int):Boolean
		{
			return(c >= 0 && r >= 0 && c < _columns && r < _rows);
		}
		
		public function getNode(c:int, r:int):GraphNode
		{
			return _nodes[c][r];
		}
		
		private function createNodeInstances():void
		{
			_nodes = new Vector.<Vector.<GraphNode>>();
			
			for (var c:int = 0; c < _columns; c++)
			{
				var row:Vector.<GraphNode> = new Vector.<GraphNode>();
				
				for (var r:int = 0; r < _rows; r++)
				{
					row.push(new GraphNode(c, r));
				}
				
				_nodes[c] = row;
			}
		}
		
		private function createNodeRelationships():void
		{
			
			var directions:Vector.<Point2D> = createDirectionMask();
			
			for (var c:int = 0; c < _columns; c++)
			{

				for (var r:int = 0; r < _rows; r++)
				{
					var node:GraphNode = getNode(c, r);
					node.surrounding.length = 0;
					
					for each(var direction:Point2D in directions)
					{
						var c2:int = c + direction.x;
						var r2:int = r + direction.y;
						
						if (isLegalPosition(c2, r2))
						{
							node.surrounding.push(getNode(c2, r2));
						}
					}
				}

			}
		}
		
		private function createDirectionMask():Vector.<Point2D>
		{
			var normals:Vector.<Point2D> = new Vector.<Point2D>();
			
			var steps:int = 8;
			
			var radiansPerStep:Number = 6.2831 / steps;
			
			var currentRadians:Number = 0;
			
			for (var i:int = 0; i < steps; i++)
			{
				var p:Point2D = Vector2D.radiansToVector(currentRadians, new Point2D());
				p.x = Math.round(p.x);
				p.y = Math.round(p.y);
				
				normals.push(p);
				
				currentRadians += radiansPerStep;
			}
			
			return normals;
			
		}

		
				
		private var _nodes:Vector.<Vector.<GraphNode>>;
		private var _columns:int = 0;
		private var _rows:int = 0;
		
	}

}