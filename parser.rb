Tag = Struct.new(:type, :attributes, :child, :text)
class Parser

  def initialize(str)
    @str = str
  end

  def parser_script

    stack = []
  # get type+description of outer tags to start the root
    Tag.new()

  end

  def check_closing()
    regex = /^<\//
    # if the beginning is this, return true, else false.
    if @str
  end

  def get_text
    # get text until '<'
    regex = /^(.*?)</
    text = @str[regex]
    @str.gsub!(regexp,'')
    text
  end


  def parse_tag
    tags = {}
    usable = /<(.*)>/.match(@str).captures.join
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
    Tag.new(usable[/^([\w\-]+)/], tags)
    @str.gsub!(regexp,'')
  end

end

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
