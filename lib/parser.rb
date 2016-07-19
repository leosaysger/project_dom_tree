require_relative 'outputter'
require_relative 'tag'
require_relative 'node_renderer'
require_relative 'tree_searcher'
require 'pry'


class Parser

  attr_reader :root

  def initialize(str)
    @str = str
    parse_script
    @search = TreeSearcher.new(@root)
  end

  def parse_script
    stack = []
  # get type+description of outer tags to start the root
    @root = parse_tag
    @root.text_before = get_text
    @root.depth = 0
    stack << @root
    while stack.length > 0
      stack.last.text_after += get_text if stack.last.text_after
      if check_closing
        stack.pop
        delete_tag
        break if @str.length == 0
      else
        new_tag = parse_tag
        stack.last.children << new_tag
        new_tag.depth = stack.last.depth + 1
        stack << new_tag
        stack.last.text_before += get_text if stack.last.text_before
      end
    end
  end

  def check_closing()
    /^<\// === @str
  end

  def delete_tag
    @str.gsub!(/^<.*?>/, '')
  end

  def get_text
    regex = /^[^<]*/
    text = @str[regex]
    @str.gsub!(regex,'')
    text.strip
  end

  def parse_tag
    tags = {}
    usable = /<(.*?)>/.match(@str).captures.join
    usable.gsub(/ =/,"=")
    quote_regex = /"(.*?)"/
    equal_regex = /([\w]+)=/

    key = usable.scan(equal_regex).flatten
    info = usable.scan(quote_regex).flatten

    key.each_with_index do |k, index|
      if info[index]
        if info[index].include?(' ')
          tags[k] = info[index].split(' ')
        else
          tags[k] = info[index]
        end
      end
    end
    t = Tag.new(usable[/^([\w\-]+)/], tags, [], "", "")
    delete_tag
    t
  end

  # def modify_tag(tag, type, str)
  #   result = search.search_by(tag, type, str)
  #   result.each do |tag|
  #     if type == "text"
  #     else
  #     tag.
  #   end
  # end


end

# loading files to be parsed
def load_html
  File.readlines('./test.html').map(&:chomp).join
end

#
# testing
#

def test_outputter
  t = Parser.new(load_html)
  o = Outputter.new
  # t.parse_script
  # print t.root
  output = o.output(t.root)
  # p output
  o.save(output)
end

def test_renderer
  t = Parser.new(load_html)
  t.parse_script
  r = NodeRenderer.new(t.root)
  r.render
end
