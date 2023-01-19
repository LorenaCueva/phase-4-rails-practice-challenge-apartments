class LeasesController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
   
    def create
        lease = Lease.create!(lease_params)
        render json: lease
    end

    def destroy
        lease = Lease.find(params[:id])
        lease.destroy
        head :no_content
    end

    private

    def render_not_found_response
        render json: {error: "Lease not found"}, status: :not_found
    end

    def lease_params
        params.permit(:tenant_id, :apartment_id, :rent)
    end
end
