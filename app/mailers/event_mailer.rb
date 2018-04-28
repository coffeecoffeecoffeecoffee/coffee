class EventMailer < ApplicationMailer
  def reminder(event, user)
    @group = event.group.decorate
    @event = event.decorate
    @user = user.decorate

    mail(to: user.email,
         subject: "Tomorrow: #{event.group.name} is at #{event.location}")
  end
end
