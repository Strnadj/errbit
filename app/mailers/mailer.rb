class Mailer < ActionMailer::Base
  default :from => Errbit::Config.email_from
  default_url_options[:host] = Errbit::Config.host
  
  def error_notification(notice)
    @notice   = notice
    @app  = notice.err.app
    
    mail({
      :to       => @app.watchers.map(&:email),
      :subject  => "[#{@app.name}] #{@notice.err.message}"
    })
  end
  
  def deploy_notification(deploy)
    @deploy   = deploy
    @app  = deploy.app
    
    mail({
      :to       => @app.watchers.map(&:email),
      :subject  => "[#{@app.name}] Deployed to #{@deploy.environment} by #{@deploy.username}"
    })
  end
  
end