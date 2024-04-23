class AnswerProcessor
    def self.process(answer)
        Thread.new do
            analyser = Sentimental.new
            
            result = analyser.score_paragraph answer.contents
            for element in result
                flag = Flag.new
                flag.active = true
                flag.reason = "Negative content with a score of #{element[1]} is detected in the phrase \"#{element[0]}\""
                flag.answer_id = answer.id
                flag.save!

                for admin in User.where(role: "ROLE_ADMIN")
                    @not = Alert.new
                    @not.active = true
                    @not.description = "New auto-generated flag to review on a patient question"
                    @not.high_priority = true
                    @not.topic = "Question answers"
                    @not.web_link = "https://example.com"
                    @not.user_id = admin.id
                    @not.save!
                end
            end
        end
    end
end