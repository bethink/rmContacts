class Message < ActiveRecord::Base

  belongs_to :contact
  attr_accessible :message, :time_received

end