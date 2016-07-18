class NodeRenderer

  def initialize(tree)
    @tree = tree
  end


  def render(node = nil)
    node = node || @tree
    num_nodes = 0
    types = {}
    attributes = "Current node type: #{node.type}, attributes: #{node.attributes}, text:#{node.text_before} #{node.text_after}, depth: #{node.depth} "
    stack = [node]
    until stack.empty?
      current = stack.pop
      current.children.each do |child|
        num_nodes += 1
        types[child.type] ? types[child.type] += 1 : types[child.type] = 1
        stack << child
      end
    end
    puts attributes + "number of nodes in subtree below current node: #{num_nodes}"
    puts "characteristics of subtree:"
    p types
  end


end
