require 'rails_helper'


RSpec.describe "Sentiment Analysis" do
  describe 'Concerning Sentiment Detection' do
    it 'detects very negative sentiment' do
        very_neg = "I intensely despise you, something unrelated. More unrelated things. Hello? Other; punctuation!"

        analyser = Sentimental.new

        result = analyser.score_paragraph(very_neg)

        assert result.length == 1
        assert result[0][0] == "I intensely despise you"
    end
    it 'doesnt by default slightly negative sentiment' do
        slight_neg = "I didn't like it, blah. Blah blah"

        analyser = Sentimental.new

        result = analyser.score_paragraph(slight_neg)

        assert result.length == 0
    end
    it 'detects slightly negative sentiment when configured' do
      slight_neg = "I didn't like it, blah. Blah blah"

      analyser = Sentimental.new(thresh: 0)

      result = analyser.score_paragraph(slight_neg)

      assert result.length == 1
  end
    it 'ignores neutral sentiment' do
        neutral = "It was fine"

        analyser = Sentimental.new(thresh: 0)

        result = analyser.score_paragraph(neutral)

        assert result.length == 0
    end
    it 'ignores positive sentiment' do
        positive = "I loved it, o o o"
        
        analyser = Sentimental.new(thresh: 0)

        result = analyser.score_paragraph(positive)
   
        assert result.length == 0
    end
    it 'allows the multipliers to start' do
      multiplier = "very very bad"
      
      analyser = Sentimental.new(thresh: 0)

      result = analyser.score_sentence(multiplier)
 
      assert result[1] < -0.5588
    end
    it 'allows the concerning words to increase the multiplier' do
      concern = "i thonk you are bad"
      
      analyser = Sentimental.new(thresh: 0)

      result = analyser.score_sentence(concern)

      assert result[1] < -0.5588
    end
  end
end