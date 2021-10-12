module Api
    module V1
      class CommentsController < ApplicationController
        before_action :authorize_comments

        def index
          @comments = Comment.where(event_id: params[:event_id])
        end

        def show
        end
  
        def new
        end
  
        def create
          begin
            @comment.update!(permitted_attributes(@comment))
            render :action => :show
          rescue ActiveRecord::RecordInvalid
            @status = false
            @errors = @comment.errors
            render :action => :new, status: :bad_request
          end
        end
  
        def edit
        end
  
        def update
          begin
            @comment.update!(permitted_attributes(@comment))
            render :action => :show
          rescue ActiveRecord::RecordInvalid
            @status = false
            @errors = @comment.errors
            render :action => :edit, status: :bad_request
          end
        end
  
        def destroy
          begin
            @comment.destroy!
          rescue ActiveRecord::RecordInvalid
            @status = false
            @errors = @comment.errors
            render status: :bad_request
          end
        end
  
      private
  
        def authorize_comments
          case params[:action].to_sym
          when :show, :edit, :update, :destroy, :attendees
            @comment = Comment.find(params[:id])
          when :new, :create
            @comment = Comment.new(event_id: params[:event_id], user: current_user)
          end
          authorize @comment || Comment
        end
      end
    end
  end
  