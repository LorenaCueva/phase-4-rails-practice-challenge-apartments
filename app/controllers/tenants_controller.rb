class TenantsController < ApplicationController
    rescue_from ActiveRecord::RecordInvalid, with: :render_not_found_response
    before_action :find_tenant, only:[:show, :update, :destroy]

    def index
        tenants = Tenant.all 
        render json: tenants
    end
    
    def show
        render json: @tenant, status: :ok
    end
    
    def create
        tenant = Tenant.create!(tenant_params)
        render json: tenant, status: :created
    end
    
    def update
        @tenant.update!(tenant_params)
        render json: tenant
    end
    
    def destroy
        @tenant.destroy
        head :no_content
    end

    private

    def render_not_found_response
        render json: {error: "Tenant not found"}, status: :not_found
    end

    def tenant_params
        params.permit(:name, :age)
    end

    def find_tenant
        @tenant = Tenant.find(params[:id])
    end
end
