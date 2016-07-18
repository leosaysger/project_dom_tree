class Outputter

  def initialize
    @output = ""
  end

  def output_tag(tag)
    attributes = ""
    tag.attributes.each do |key, description|
      if description.is_a?(Array)
        words = ""
        description.each_with_index do |text, index|
          words += "#{text}"
          words += " " if index < description.length-1
        end
      else
        words = description
      end
      attributes += " #{key}=\"#{words}\""
    end
    "<#{tag.type}#{attributes}>"
  end


  def output(tag)
    @output += ("  " * tag.depth)
    if tag.children == []
      @output += "#{output_tag(tag)}#{tag.text_before}#{tag.text_after}</#{tag.type}>\n"
      return
    else
      @output += "#{output_tag(tag)}#{tag.text_before} \n"
      tag.children.each do |child|
        output(child)
      end
      @output += ("  " * tag.depth)
      @output += "#{tag.text_after}</#{tag.type}>\n"
    end
    @output
  end

  def save(output)
    filename = 'save.html'
    File.open(filename, 'w') do |file|
      file.puts output
    end
    puts "Saved!"
  end


end
