require 'parser'

describe Outputter do
let(:outputter){ Outputter.new }
  describe '#initialize' do
    it "initializes a new outputter" do
      expect(outputter).to be_a(Outputter)
    end
  end


end
