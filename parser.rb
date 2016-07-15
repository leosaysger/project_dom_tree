

def parse_tag(tag)
  tags = {} 
  usable = /<(.*)>/.match(tag).captures.join
  puts usable
  tags["type"] = usable[/^([\w\-]+)/]

  to_find = /=/
  
  
  tags


end


# converts HTML into a hash containing key attributes



puts parse_tag("<p class='foo bar' id='baz' name='fozzie'>")
