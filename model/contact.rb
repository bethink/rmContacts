class Contact < ActiveRecord::Base
  belongs_to :user
  def contacts=(contacts)
    contacts.each do |contact|
    end
  end
end
