require 'pry'


Tag = Struct.new(:type, :attributes, :children, :text_before, :text_after, :depth)

class Tag

  def to_s
    "#{attributes}"
  end

  def inspect
    "#{attributes}"
  end


end

class Parser
  attr_reader :root, :output
  def initialize(str)
    @str = str
    @output = ''
  end

  # def load_html
  #   @str = File.readlines('test.html').map(&:chomp).join
  # end

  def parser_script
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
        # binding.pry
        stack.last.children << new_tag
        new_tag.depth = stack.last.depth + 1
        stack << new_tag
        stack.last.text_before += get_text if stack.last.text_before
      end
    end

      # stack.last.text = get_text

  end

  def check_closing()
    # if the beginning is this, return true, else false.
    /^<\// === @str
  end

  def delete_tag
    @str.gsub!(/^<.*?>/, '')
  end

  def get_text
    # get text until '<'
    regex = /^[^<]*/
    text = @str[regex]
    @str.gsub!(regex,'')
    text
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

  def outputter(tag)
    if tag.children == []
      @output += '"  " * #{tag.depth}' + "<#{tag.type} #{tag.attributes}> #{tag.text_before} #{tag.text_after} </#{tag.type}>\n"
      return
    else
      @output += '"  " * #{tag.depth}' + "<#{tag.type} #{tag.attributes}> #{tag.text_before} \n"
      tag.children.each do |child|
        outputter(child)
      end
      @output += "#{tag.text_after} </#{tag.type}>\n"
    end
    @output
  end



end

h = '<html>  <head>    <title>      This is a test page    </title>  </head>  <body>    <div class="top-div">      Im an outer div!!!      <div class="inner-div">        Im an inner div!!! I might just <em>emphasize</em> some text.      </div>      I am EVEN MORE TEXT for the SAME div!!!    </div>    <main id="main-area">      <header class="super-header">        <h1 class="emphasized">          Welcome to the test doc!        </h1>        <h2>          This document contains data        </h2>      </header>      <ul>        Here is the data:        <li>Four list items</li>        <li class="bold funky important">One unordered list</li>        <li>One h1</li>        <li>One h2</li>        <li>One header</li>        <li>One main</li>        <li>One body</li>        <li>One html</li>        <li>One title</li>        <li>One head</li>        <li>One doctype</li>        <li>Two divs</li>        <li>And infinite fun!</li>      </ul>    </main>  </body></html>'

t = Parser.new(h)

t.parser_script

puts t.outputter(t.root)
#   def load_html
    # puts str = File.readlines('test.html').map(&:chomp).join
  # end
# puts t.outputter(t.root)

  # parse_tag("<p class='foo bar' id='baz' name='fozzie'>")
  # html_string = "<div>  div text before  <p>    p text  </p>  <div>    more div text  </div>  div text after</div>"

  # def load_html
  #   str = File.readlines('test.html').map(&:chomp).join
  # end

  # p load_html
  # def parser_script

  #   html = load_html
  #   html.match
  # end


