class AVLTree
  # Represents an entry into the avl tree.
  class Node
    attr_accessor :key, :data, :height, :left, :right, :deleted

    def initialize key, data
        self.key    = key
        self.data   = data
        self.height = 1
    end
  end

  # Adds a new node to the the tree.
  def insert key, data = nil
    @root = insert_and_balance(@root, key, data)
  end

  # Removes a node from the tree.
  def remove key
      # This method finds the node to be removed and marks it as deleted.
      # This is a nice way to handle deletions because since the structure
      # doesn't change we don't have to balance the tree after removals.
      search(key)&.deleted = true
  end

  # Searches for a key in the current tree.
  def search key
      node = search_rec @root, key
      return node unless node&.deleted
  end

  # Prints the contents of a tree.
  def print
      print_rec @root, 0
  end

private

  # Returns the heigh of the provided node.
  def height node
      node&.height || 0 
  end

  # Calculates and sets the height for the specified node.
  def set_height node
      lh  = height node&.left
      rh  = height node&.right
      max = lh > rh ? lh : rh

      node.height = 1 + max
  end

  # Performs a right rotation.
  def rotate_right p
      q       = p.left
      p.left  = q.right
      q.right = p

      set_height p
      set_height q

      return q
  end

  # Performs a left rotation.
  def rotate_left p
      q       = p.right
      p.right = q.left
      q.left  = p

      set_height p
      set_height q

      return q
  end

  # Performs a LR rotation.
  def rotate_left_right node
      node.left = rotate_left(node.left)
      return rotate_right(node)
  end

  # Performs a RL rotation.
  def rotate_right_left node
      node.right = rotate_right(node.right)
      return rotate_left(node)
  end

  # Balances the subtree rooted at the specify node if that tree needs
  # to be balanced.
  def balance node
      set_height node

      if (height(node.left) - height(node.right) == 2) 
          if (height(node.left.right) > height(node.left.left)) 
              # LR rotation.
              return rotate_left_right(node.left)
          end
          ## RR rotation (or just right rotation).
          return rotate_right(node)
      elsif (height(node.right) - height(node.left) == 2) 
          if (height(node.right.left) > height(node.right.right)) 
              # RL rotation.
              return rotate_right_left(node.right)
          end
          # LL rotation (or just left rotation).
          return rotate_left(node)
      end
      return node
  end

  # Inserts a new node and balances the tree (if needed).
  def insert_and_balance node, key, data = nil
      return Node.new key, data unless node

      if (key < node.key) 
          node.left = insert_and_balance(node.left, key, data)
      elsif(key > node.key) 
          node.right = insert_and_balance(node.right, key, data)
      else 
          node.data    = data
          node.deleted = false
      end

      balance(node)
  end

  # Searches for a key in the subtree that starts at the provided node.
  def search_rec node, key
      return nil unless node
      return search_rec(node.left, key)  if (key < node.key)
      return search_rec(node.right, key) if (key > node.key)
      return node        
  end

  # Prints the subtree that starts at the provided node.
  def print_rec node, indent
      unless node
          puts "x".rjust(indent * 4, " ")
          return
      end

      puts_key node, indent
      print_rec node.left, indent + 1
      print_rec node.right, indent + 1
  end

  # Print the contents of a key.
  def puts_key node, indent
      txt = node.key.to_s
      if node.deleted
          txt += " (D)" 
          puts txt.rjust(indent * 8, " ")
      else
          puts txt.rjust(indent * 4, " ")
      end
  end
end