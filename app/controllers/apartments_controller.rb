class ApartmentsController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
before_action :find_apartment, only:[:update, :show, :destroy]

def index
    apartments = Apartment.all 
    render json: apartments
end

def show
    render json: @apartment
end

def create
    apartment = Apartment.create!(apartment_params)
    render json: apartment, status: :created
end

def update
    @apartment.update!(apartment_params)
    render json: apartment
end

def destroy
    @apartment.destroy
    head :no_content
end

private

    def render_not_found_response
        render json: {error: "Apartment not found"}, status: :not_found
    end

    def apartment_params
        params.permit(:number)
    end

    def find_apartment
        @apartment = Apartment.find(params[:id])
    end
end
