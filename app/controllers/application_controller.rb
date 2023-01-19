class ApplicationController < ActionController::API
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity


    
    private

    def render_unprocessable_entity(e)
        render json: {errors: e.record.errors.full_messages}, status: :unprocessable_entity
    end

end
