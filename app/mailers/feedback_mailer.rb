class FeedbackMailer < ActionMailer::Base
  
  default :from => "recruitd@mit.edu"
  
  def feedback(feedback)
    @recipients  = 'recruitd@mit.edu'
    @from        = 'noreply@recruitd.com'
    @subject     = "[Feedback for Recruitd] #{feedback.subject}"
    @sent_on     = Time.now
    @feedback = feedback
    
    mail(:to => @recipients,
         :subject => @subject)
  end

end
