require 'parser'

describe TreeSearcher do

  let(:parser){ Parser.new(load_html) }
  before do
    parser.parse_script
  end

  describe 'searches' do
    let(:searcher){ TreeSearcher.new(load_html) }

    describe '#search_by' do
      it 'should return a Tag object'
    end

    describe '#search_children' do
      it 'should return an array of Tags' do
        expect(searcher.search_children(parser.root, 'class', 'top-div')).to be_a(Array)
      end
    end

    describe '#search_by' do
      it 'should return an array of Tags'
    end
  end



end
