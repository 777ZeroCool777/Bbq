module EventsHelper

  def proverka

    @event.subscriptions.each do |s|

      current_user.subscriptions.each do |s2|
        if s2 = s2
          return 1
        end
      end

    end

  end

end
