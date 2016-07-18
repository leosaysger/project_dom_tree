class TreeSearcher

  def initialize(tree)
    @tree = tree
  end

  def search_by(node = @tree, type, str)
    ans = []
    ans << check_node(node, type, str) if check_node(node, type, str)
    ans += search_children(node, type, str)
  end

  def search_children(node, type, str)
    stack = [node]
    ans = []
    until stack.empty?
      current = stack.pop
      current.children.each do |child|
        ans << check_node(child, type, str) if check_node(child, type, str)
        stack << child
      end
    end
    ans
  end

  def check_node(node, type, str)
    if type == "text"
      return node if node.text_before.include?(str) || node.text_after.include?(str)
    elsif node.attributes[type] == str
      return node
    elsif node.attributes[type].is_a?(Array)
      return child if node.attributes[type].include?(str)
    end
  end

  def search_ancestors(node, type, str)
    stack = [@tree]
    ans = []
    ans << check_node(@tree, type, str) if check_node(@tree, type, str)
    bubble = false
    until stack.empty?
      current = stack.pop
      if current.children.any? {|n| n == node} || bubble == true
        bubble = true
        ans << check_node(current, type, str) if check_node(current, type, str)
      else
        current.children.each { |child|  stack << child }
      end
    end
    ans
  end


end
