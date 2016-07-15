

def load_html
  str = File.readlines('test.html').map(&:chomp).join
end

p load_html
def parser_script

  html = load_html
  html.match
end



















def parse_tag(tag)
  tags = {}
  usable = /<(.*)>/.match(tag).captures.join
  usable.gsub(/ =/,"=")

  tags["type"] = usable[/^([\w\-]+)/]

  quote_regex = /'(.*?)'/
  equal_regex = /([\w\-]+)=/

  key = usable.scan(equal_regex).flatten
  info = usable.scan(quote_regex).flatten

  key.each_with_index do |k, index|
    if info[index].include?(' ')
      tags[k] = info[index].split(' ')
    else
      tags[k] = info[index]
    end
  end
end


# converts HTML into a hash containing key attributes
parse_tag("<p class='foo bar' id='baz' name='fozzie'>")
