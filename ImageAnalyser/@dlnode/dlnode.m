classdef dlnode < handle
   properties
      Data
   end
   properties (SetAccess = private)
      Next = dlnode.empty
      Prev = dlnode.empty
   end
   methods
      function node = dlnode(Data)
         if (nargin > 0)
            node.Data = Data;
         end
      end
      function insertAfter(newNode, nodeBefore)
         removeNode(newNode);
         newNode.Next = nodeBefore.Next;
         newNode.Prev = nodeBefore;
         if ~isempty(nodeBefore.Next)
            nodeBefore.Next.Prev = newNode;
         end
         nodeBefore.Next = newNode;
      end
      function insertBefore(newNode, nodeAfter)
         removeNode(newNode);
         newNode.Next = nodeAfter;
         newNode.Prev = nodeAfter.Prev;
         if ~isempty(nodeAfter.Prev)
            nodeAfter.Prev.Next = newNode;
         end
         nodeAfter.Prev = newNode;
      end
      function removeNode(node)
         if ~isscalar(node)
            error('Nodes must be scalar')
         end
         prevNode = node.Prev;
         nextNode = node.Next;
         if ~isempty(prevNode)
            prevNode.Next = nextNode;
         end
         if ~isempty(nextNode)
            nextNode.Prev = prevNode;
         end
         node.Next = dlnode.empty;
         node.Prev = dlnode.empty;
      end
      function clearList(node)
         prev = node.Prev;
         next = node.Next;
         removeNode(node)
         while ~isempty(next)
            node = next;
            next = node.Next;
            removeNode(node);
         end
         while ~isempty(prev)
            node = prev;
            prev = node.Prev;
            removeNode(node)
         end
      end
   end
   methods (Access = private)
      function delete(node)
         clearList(node)
      end
   end
end  