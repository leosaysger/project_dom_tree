require 'parser'

describe TreeSearcher do

  let(:parser){ Parser.new(load_html) }
  before do
    parser.parse_script
  end

  describe 'searches' do
    let(:searcher){ TreeSearcher.new(parser.root) }

    describe '#search_by' do
      it 'should return an array' do
        expect(searcher.search_by(parser.root, 'class', 'top-div').length).to eq(1)
      end
      it 'should return an array when a string is searched' do
        expect(searcher.search_by(parser.root, 'text', 'One').length).to eq(10)
      end
    end

    describe '#search_children' do
      it 'should return an array of length 2' do
        expect(searcher.search_children(parser.root, 'id', 'thing').length).to eq(2)
      end
    end

    describe '#search_by' do
      it 'should return an array' do
        expect(searcher.search_ancestors(parser.root.children[0].children[0], 'id', 'test').length).to eq(2)
      end
    end
  end
end
