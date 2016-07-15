require 'pry'


Tag = Struct.new(:type, :attributes, :child, :text)


class Parser
  attr_reader :root
  def initialize(str)
    @str = str
  end

  def parser_script
    stack = []
  # get type+description of outer tags to start the root
    @root = parse_tag
    @root.text = get_text
    stack << @root
    while stack.length > 0
      stack.last.text += get_text if stack.last.text
      if check_closing
        stack.pop
        delete_tag
        break if @str.length == 0
      else
        new_tag = parse_tag
        # binding.pry
        stack.last.child << new_tag
        stack << new_tag
        stack.last.text += get_text if stack.last.text
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

    quote_regex = /'(.*?)'/
    equal_regex = /([\w]+)=/

    key = usable.scan(equal_regex).flatten
    info = usable.scan(quote_regex).flatten

    key.each_with_index do |k, index|
      if info[index].include?(' ')
        tags[k] = info[index].split(' ')
      else
        tags[k] = info[index]
      end
    end
    t = Tag.new(usable[/^([\w\-]+)/], tags, [], "")
    delete_tag
    t
  end

end

t = Parser.new("<div>  div text before  <p>    p text  </p>  <div>    more div text  </div>  div text after</div>")
t.parser_script
p t.root

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
