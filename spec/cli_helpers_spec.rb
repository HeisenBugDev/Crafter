describe Crafter::CLIHelpers do
  before do
    @dummy_class = Class.new()
    @dummy_class.extend(Crafter::CLIHelpers)
  end

  describe "#from_to_message" do
    it "should give me a from to message" do
      expect(@dummy_class.from_to_message('This mod pack',
        'another mod pack')).
      to eql("(§§§\e[4;39;49mThis mod pack\e[0m§ ->"\
             " §\e[4;39;49manother mod pack\e[0m§)")
    end

    it "should give me a from to message with source" do
      expect(@dummy_class.from_to_message('This mod pack',
        'another mod pack', source: 'somefile.zip')).
      to eql("(§\e[0;39;49msomefile.zip \e[0m§§\e[4;39;49mThis mod pack\e[0m§"\
             " -> §\e[4;39;49manother mod pack\e[0m§)")
    end
  end
end