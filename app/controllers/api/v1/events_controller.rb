module Api
  module V1
    class EventsController < ApplicationController
      before_action :authorize_events

      def show
      end

      def new
      end

      def create
        begin
          @event.update!(permitted_attributes(@event))
          @event.update!(school: current_user.school)
          if params.key?(:image)
            decoded_base_64_img = Base64.decode64(params[:image])
            @event.image.attach(
                    io: StringIO.new(decoded_base_64_img),
                    filename: "test_img_name",
                    content_type: "image/jpeg"
            )
          end
          render :action => :show
        rescue ActiveRecord::RecordInvalid
          @status = false
          @errors = @event.errors
          render :action => :new, status: :bad_request
        end
      end

      def edit
      end

      def update
        begin
          @event.update!(permitted_attributes(@event))
          render :action => :show
        rescue ActiveRecord::RecordInvalid
          @status = false
          @errors = @event.errors
          render :action => :edit, status: :bad_request
        end
      end

      def destroy
        begin
          @event.destroy!
        rescue ActiveRecord::RecordInvalid
          @status = false
          @errors = @event.errors
          render status: :bad_request
        end
      end

      ##
      # Get events that are nearby the inputted coordinates
      def nearby
        addresses = Address.where(addressable_type: "Event").near([params[:latitude], params[:longitude]], params[:radius], units: :mi)
        @events = addresses.collect{|a| a.addressable}.select{|e| e.school == current_user.school || e.public_vis?}
      end

      ##
      # Get the events the user created (past and upcoming) ordered by descending date
      def mine
        @events = Event.where(user: current_user).order("start_date DESC")
      end

      ##
      # Get the user's upcoming events - ascending start date
      def upcoming
        rsvps = EventAttendee.where(user: current_user)
        @events = rsvps.collect{|r| r.event}.select{|e| e.end_date > Time.now}.sort_by(&:start_date)
      end

      ##
      # Get the user's past events - most recent first
      def past
        rsvps = EventAttendee.where(user: current_user)
        @events = rsvps.collect{|r| r.event}.select{|e| e.end_date <= Time.now}.sort_by(&:start_date).reverse
      end

      def rsvp
        @event = Event.find(params[:id])
        @rsvp = EventAttendee.find_by(user_id: current_user.id, event_id: params[:id])
        rsvp_status = params[:rsvp_status]

        if @event.present?
          begin
            case rsvp_status.to_sym
            when :yes, :maybe
              @rsvp = EventAttendee.find_or_create_by(event: @event, user: current_user)
              @rsvp.update!(rsvp_status: rsvp_status.to_sym)
            when :no
              if @rsvp.present?
                EventAttendee.destroy(@rsvp.id)
              end
            end
          rescue ActiveRecord::RecordInvalid
            @errors = ["Could not create"]
          end
        end
      end
      ##
      # RSVP to an event
      # def rsvp
      #   # Check if user has already RSVP'd to this event
      #
      #   @event_attendee = EventAttendee.where("event_id = ? AND user_id = ?", params[:id], current_user.id)
      #
      #
      #   if @event_attendee.empty?
      #      # User has not RSVP'd to this event before
      #     create_new_rsvp
      #   else
      #     # User has RSVP'd to this event before, update response
      #     update_rsvp
      #   end
      # end
      #
      # def create_new_rsvp
      #   @event_attendee = EventAttendee.new(rsvp_status: @rsvp_status, event_id: @event.id, user_id: current_user.id)
      #   begin
      #     @event_attendee.update!(permitted_attributes(@event_attendee))
      #     render plain: 'Successfully RSVPd to event ' + @event.id.to_s + ' with status ' + @rsvp_status
      #   rescue ActiveRecord::RecordInvalid
      #     @status = false
      #     @errors = @event_attendee.errors
      #     render plain:'Could not RSVP to event ' + @event.id.to_s + ' with status ' + @rsvp_status, status: :bad_request
      #   end
      # end
      #
      # def update_rsvp
      #   if @rsvp_status == "no"
      #     # If response is no, delete entry
      #     begin
      #       EventAttendee.destroy(@event_attendee.ids)
      #       render plain: 'Successfully updated RSVP to event ' + @event.id.to_s + ' to status ' + @rsvp_status
      #     rescue
      #       @status = false
      #       @errors = @event_attendee.errors
      #       render plain: 'Could not update RSVP to event ' + @event.id.to_s + ' to status ' + @rsvp_status, status: :bad_request
      #     end
      #   else
      #     begin
      #       @event_attendee.update(permitted_attributes(@event_attendee))
      #       render plain: 'Successfully updated RSVP to event ' + @event.id.to_s + ' to status ' + @rsvp_status
      #     rescue ActiveRecord::RecordInvalid
      #       @status = false
      #       @errors = @event_attendee.errors
      #       render plain: 'Could not update RSVP to event ' + @event.id.to_s + ' to status ' + @rsvp_status, status: :bad_request
      #     end
      #   end
      # end

      ##
      # Get attendees and rsvp status for the provided event
      def attendees
      end

    private

      def authorize_events
        case params[:action].to_sym
        when :show, :edit, :update, :destroy, :rsvp, :attendees
          @event = Event.find(params[:id])
        when :new, :create
          @event = Event.new(user: current_user, school: current_user.school)
        end
        authorize @event || Event
      end
    end
  end
end
