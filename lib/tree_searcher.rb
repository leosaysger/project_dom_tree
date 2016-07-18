class TreeSearcher


  def initialize(tree)
    @tree = tree
  end

  # def check_attributes(child, str)
  #   ans = []
  #   if child.attributes[type] == str
  #     ans << child
  #   elsif child.attributes[type].is_a?(Array)
  #     ans << child if child.attributes[type].include?(str)
  #   end
  #   ans
  # end


  def search_by(type, str, node = @tree)
    stack[node]
    ans = []
    until stack.empty?
      current = stack.pop
      current.children.each do |child|
        if child.attributes[type] == str
          ans << child
        elsif child.attributes[type].is_a?(Array)
          ans << child if child.attributes[type].include?(str)
        end
        stack << child
      end
    end
    ans
  end

  def search_children(node, type, str)
    stack = [node]
    ans = []
    until stack.empty?
      current = stack.pop
      current.children.each do |child|
        if child.attributes[type] == str
          ans << child
        elsif child.attributes[type].is_a?(Array)
          ans << child if child.attributes[type].include?(str)
        end
        stack << child
      end
    end
    ans
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
