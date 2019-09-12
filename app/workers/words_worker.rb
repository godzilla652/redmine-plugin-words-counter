require 'yomu'

class WordsWorker
    include Sidekiq::Worker
  
    def perform(issue_id, path, filename)

      postin_journal issue_id, path, filename

    end

    private
      def postin_journal(issue_id, path, filename)
        issue = Issue.find(issue_id)
        min = 0
        max = 0
        
        



        issue.available_custom_fields.each do |custom_field|
          min = custom_field.default_value if custom_field.name == 'min'
          max = custom_field.default_value if custom_field.name == 'max'
        end

      

        yomu = Yomu.new Rails.root.join('files', path, filename)
        amount = count_words yomu.text



        
        
        if amount < min.to_i || amount > max.to_i
          message = WMessage.first.body + "\n#{amount} words"
        end
        
        post_message issue, message
       
      end


      def count_words(text)
        words = text.split(' ')
        words.count
      end
      def post_message(issue, message)
        user = User.current
        journal = issue.init_journal(user, message)
        journal.save
      end

  end
  