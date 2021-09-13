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
          @event.update(school: current_user.school)
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

    private

      def authorize_events
        case params[:action].to_sym
        when :show, :edit, :update, :destroy
          @event = Event.find(params[:id])
        when :new, :create
          @event = Event.new(user: current_user, school: current_user.school, start_date: Time.now, end_date: Time.now + 1.hour)
        end
        authorize @event || Event
      end
    end
  end
end
