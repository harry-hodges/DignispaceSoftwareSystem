require 'rails_helper'


RSpec.describe "Blocked Word Detection" do
  describe 'Concerning Sentiment Detection' do
    it 'detects blocked words' do
        very_neg = "Unrelated content words fuck unrelated content"
        # check detect swear
        s = Sensitivity.new
        bad_word_array = s.detect_sensitive_words(very_neg)
        assert bad_word_array.length == 1
    end
    it 'ignores allowed words' do
        allowed = "Unrelated content words unrelated content"
        # Check nothing returned
        s = Sensitivity.new
        bad_word_array = s.detect_sensitive_words(allowed)
        assert bad_word_array.length == 0
    end
  end
end