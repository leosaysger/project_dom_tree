require 'parser'

describe Parser do

  let(:html){ '<html id="test"> <head class="heading" id="test"> <title> This is a test page</title> <body> <main> </main></body></html>' }

  let(:parser){ Parser.new(html) }

  describe '#initialize' do
    it "initializes a new Parser object" do
      expect(parser).to be_a(Parser)
    end
  end

  describe '#parse_script' do
    it 'parses html and creates a Tag tree' do
      expect(parser.root).to be_a(Tag)
    end
  end

  describe '#modify_tag' do
    it 'adds modifies Tags in the Tag tree'
  end


end
