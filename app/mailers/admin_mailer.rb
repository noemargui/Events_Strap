class AdminMailer < ApplicationMailer
  default from: 'no-reply@monsite.fr'

    def newattendee_email(attendance)
      @admin = attendance.event.administrator
      @event = attendance.event
      @attendee = attendance.attendee
      #on définit une variable @url qu'on utilisera dans la view d’e-mail
      @url  = 'https://events-brights.herokuapp.com/'
      # c'est cet appel à mail() qui permet d'envoyer l’e-mail en définissant destinataire et sujet.
      mail(to: @admin.email, subject: "#{@attendee.first_name} #{@attendee.last_name} s'est inscrit à ton event !")
    end
end
