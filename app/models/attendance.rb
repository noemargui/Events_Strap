class Attendance < ApplicationRecord
  #after_create :newattendee_send

  # ASSOCIATIONS
  belongs_to :attendee, class_name: 'User'
  belongs_to :event

  # MAILING METHODS
  def newattendee_send #Quand un participant participe à un événement, envoie un email au créateur de l'événement
    AdminMailer.newattendee_email(self).deliver_now
  end
end