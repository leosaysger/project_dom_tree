class TreeSearcher


  def initialize(tree)
    @tree = tree
  end

  def search_by(type, str)


  end

  def search_children(node, type, str)
    stack = [node]
    ans = []
    until stack.empty?
      current = stack.pop
      current.children.each do |child|
        if child.attributes[type] == type
          ans << child
        elsif child.attributes[type].is_a?(Array)
          ans << child if child.attributes[type].include?(child)
        end
        stack << child
      end
      binding.pry
      ans
    end
  end

  def search_ancestors(node, type, str)

    queue = [@tree]
    until current.depth > max
      current = queue.shift
      current.children.each do |child|

        queue << child
      end
    end

  end


end
