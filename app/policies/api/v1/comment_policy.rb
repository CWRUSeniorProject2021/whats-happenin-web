module Api
    module V1
      class CommentPolicy < ApiPolicy

        def index?
          true
        end

        def show?
          record.public_vis?
        end

        def create?
          user.present? && record.event.present?
        end

        def new?
          create?
        end

        def update?
          false
        end

        def edit?
          update?
        end

        def destroy?
          user == record.user
        end

        def permitted_attributes
          return [:text, :parent_id, :format, :event_id]
        end
      end
    end
  end
