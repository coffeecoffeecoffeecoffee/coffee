class CalendarsController < ApplicationController
  def show
    group = Group.find(params[:group_id])
    ical = GroupCalendarCreator.new(group).to_ical
    send_data ical, filename: "#{group.name}.ics"
  end
end
