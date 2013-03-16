class User < ActiveRecord::Base
  has_many :contacts

  validates :password, :presence => true
  validates :email, :presence => true, :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/ }

  def update_messages(contacts)

    return if contacts.blank?

    results = { :success => [], :failed => [] }

    contacts.values.each do |contact_attrs|
      contact = self.contacts.where(:mobile_reference => contact_attrs[:mobile_reference]).first
      contact_attrs[:messages_attributes] = contact_attrs[:messages_attributes].values

      status = if contact
        contact.messages.create(contact_attrs[:messages])
      else
        contact = self.contacts.build(contact_attrs)
        contact.save
      end

      if status
        results[:success] << contact.mobile_reference
      else
        results[:failed] << contact.mobile_reference
      end

    end

  end

end