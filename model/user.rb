class User < ActiveRecord::Base
  has_many :contacts

  validates :password, :presence => true
  validates :email, :presence => true, :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/ }

  def update_messages(contacts)

    contacts.each do |contact_attrs|
      contact = self.contacts.find_by_mobile_reference(contact_attrs[:mobile_reference])

      if contact
        contact.messages.create(contact_attrs[:messages])
      else
        contact = self.contacts.build(contact_attrs)
        contact.save
      end


    end

  end

end