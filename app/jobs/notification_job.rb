class NotificationJob < ActiveJob::Base
  queue_as :default

  def perform(problem_id)
    # Find problem
    problem = Problem.find problem_id

    # Send problem via notification service
    problem.app.notification_service.create_notification(problem)
  end
end
