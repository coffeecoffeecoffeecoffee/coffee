require 'administrate/field/base'

class EventTimeField < Administrate::Field::Base
  def to_s
    time_zone = resource.group.time_zone
    data.in_time_zone(time_zone)
  end
end
