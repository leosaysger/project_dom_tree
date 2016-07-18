require 'parser'

describe Outputter do

let(:html){ '<html id="test"> <head class="heading" id="test"> <title> This is a test page</title></head> <body> <main></main></body></html>' }
let(:parser){ Parser.new(html) }
let(:outputter){ Outputter.new }

  describe '#initialize' do
    it "initializes a new outputter" do
      expect(outputter).to be_a(Outputter)
    end
  end

  context 'manipulating parsed data' do
    before { parser.parse_script }

    describe '#output' do
      it 'outputs a string from a parsed Tag object' do
        expect(outputter.output(parser.root)).to be_a(String)
      end
    end

    describe '#save' do
      it 'open and save to a save file' do
        file = double('file')
        allow($stdout).to receive(:puts)
        allow(File).to receive(:open).with("save.html", "w").and_yield(file)
        expect(file).to receive(:puts).and_return(nil)
        outputter.save(outputter.output(parser.root))
      end
    end
  end

end
