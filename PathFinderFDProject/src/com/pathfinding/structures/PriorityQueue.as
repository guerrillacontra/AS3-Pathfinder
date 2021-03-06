package com.pathfinding.structures
{
	import flash.utils.Dictionary;
	
	/**
	 * ...
	 * @author James
	 */
	public class PriorityQueue
	{
		private var _heap:Array;
		private var _size:int;
		private var _count:int;
		private var _posLookup:Dictionary;
		
		/**
		 * Initializes a priority queue with a given size.
		 *
		 * @param size The size of the priority queue.
		 */
		public function PriorityQueue(size:int)
		{
			_heap = new Array(_size = size + 1);
			_posLookup = new Dictionary(true);
			_count = 0;
		}
		
		/**
		 * The front item or null if the heap is empty.
		 */
		public function get front():IPrioritizable
		{
			return _heap[1];
		}
		
		/**
		 * The maximum capacity.
		 */
		public function get maxSize():int
		{
			return _size;
		}
		
		/**
		 * Enqueues a prioritized item.
		 *
		 * @param obj The prioritized data.
		 * @return False if the queue is full, otherwise true.
		 */
		public function enqueue(obj:IPrioritizable):Boolean
		{
			if (_count + 1 < _size)
			{
				_count++;
				_heap[_count] = obj;
				_posLookup[obj] = _count;
				walkUp(_count);
				return true;
			}
			return false;
		}
		
		/**
		 * Dequeues and returns the front item.
		 * This is always the item with the highest priority.
		 *
		 * @return The queue's front item or null if the heap is empty.
		 */
		public function dequeue():*
		{
			if (_count >= 1)
			{
				var o:* = _heap[1];
				delete _posLookup[o];
				
				_heap[1] = _heap[_count];
				walkDown(1);
				
				delete _heap[_count];
				_count--;
				return o;
			}
			return null;
		}
		
		/**
		 * Removes an item.
		 *
		 * @param obj The item to remove.
		 * @return True if removal succeeded, otherwise false.
		 */
		public function remove(obj:IPrioritizable):Boolean
		{
			if (_count >= 1)
			{
				var pos:int = _posLookup[obj];
				
				var o:* = _heap[pos];
				delete _posLookup[o];
				
				_heap[pos] = _heap[_count];
				
				walkDown(pos);
				
				delete _heap[_count];
				delete _posLookup[_count];
				_count--;
				return true;
			}
			
			return false;
		}
		
		/**
		 * @inheritDoc
		 */
		public function contains(obj:*):Boolean
		{
			for (var i:int = 1; i <= _count; i++)
			{
				if (_heap[i] === obj)
					return true;
			}
			return false;
		}
		
		/**
		 * @inheritDoc
		 */
		public function clear():void
		{
			_heap = new Array(_size);
			_posLookup = new Dictionary(true);
			_count = 0;
		}
		
		/**
		 * @inheritDoc
		 */
		public function getIterator():IIterator
		{
			return new PriorityQueueIterator(this) as IIterator;
		}
		
		/**
		 * @inheritDoc
		 */
		public function get size():int
		{
			return _count;
		}
		
		/**
		 * @inheritDoc
		 */
		public function isEmpty():Boolean
		{
			return _count == 0;
		}
		
		/**
		 * @inheritDoc
		 */
		public function toArray():Array
		{
			return _heap.slice(1, _count + 1);
		}
		
		/**
		 * Prints out a string representing the current object.
		 *
		 * @return A string representing the current object.
		 */
		public function toString():String
		{
			return "[PriorityQueue, size=" + _size + "]";
		}
		
		/**
		 * Prints all elements (for debug/demo purposes only).
		 */
		public function dump():String
		{
			if (_count == 0)
				return "PriorityQueue (empty)";
			
			var s:String = "PriorityQueue\n{\n";
			var k:int = _count + 1;
			for (var i:int = 1; i < k; i++)
			{
				s += "\t" + _heap[i] + "\n";
			}
			s += "\n}";
			return s;
		}
		
		private function walkUp(index:int):void
		{
			var parent:int = index >> 1;
			var parentObj:IPrioritizable;
			
			var tmp:IPrioritizable = _heap[index];
			var p:int = tmp.priority;
			
			while (parent > 0)
			{
				parentObj = _heap[parent];
				
				if (p - parentObj.priority > 0)
				{
					_heap[index] = parentObj;
					_posLookup[parentObj] = index;
					
					index = parent;
					parent >>= 1;
				}
				else
					break;
			}
			
			_heap[index] = tmp;
			_posLookup[tmp] = index;
		}
		
		private function walkDown(index:int):void
		{
			var child:int = index << 1;
			var childObj:IPrioritizable;
			
			var tmp:IPrioritizable = _heap[index];
			var p:int = tmp.priority;
			
			while (child < _count)
			{
				if (child < _count - 1)
				{
					if (_heap[child].priority - _heap[int(child + 1)].priority < 0)
						child++;
				}
				
				childObj = _heap[child];
				
				if (p - childObj.priority < 0)
				{
					_heap[index] = childObj;
					_posLookup[childObj] = index;
					
					_posLookup[tmp] = child;
					
					index = child;
					child <<= 1;
				}
				else
					break;
			}
			_heap[index] = tmp;
			_posLookup[tmp] = index;
		}
	}
}
import com.pathfinding.structures.PriorityQueue;
import com.pathfinding.structures.IIterator;

internal class PriorityQueueIterator implements IIterator
{
	private var _values:Array;
	private var _length:int;
	private var _cursor:int;
	
	public function PriorityQueueIterator(pq:PriorityQueue)
	{
		_values = pq.toArray();
		_length = _values.length;
		_cursor = 0;
	}
	
	public function get data():*
	{
		return _values[_cursor];
	}
	
	public function set data(obj:*):void
	{
		_values[_cursor] = obj;
	}
	
	public function start():void
	{
		_cursor = 0;
	}
	
	public function hasNext():Boolean
	{
		return _cursor < _length;
	}
	
	public function next():*
	{
		return _values[_cursor++];
	}
}