class Contact < ActiveRecord::Base
  belongs_to :user
  has_many :messages

  accepts_nested_attributes_for :messages
  attr_accessible :messages_attributes, :display_name, :mobile_reference
end
