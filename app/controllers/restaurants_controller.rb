class RestaurantsController < ApplicationController
    before_action :require_login, only: [:new, :edit]

    def index
        @restaurants = Restaurant.all
    end

    def show
        @restaurant = Restaurant.find(params[:id])
    end

    def new
        @restaurant = Restaurant.new
    end

    def edit
        @restaurant = Restaurant.find(params[:id])
        if @restaurant.author != current_user && !current_user.admin
            return head(:forbidden)
        end
    end

    def create
        diner = Restaurant.create(restaurant_params)
        if diner
            redirect_to restaurant_path(diner)
        else
            flash[:notice] = "Error. Please reenter information."
            redirect_to new_restaurant_path
        end
    end

    def update
        diner = Restaurant.find(params[:id])
        diner.update(restaurant_params)
        if diner
            redirect_to restaurant_path(diner)
        else
            flash[:notice] = "Error. Please reenter information."
            redirect_to edit_restaurant_path(Restaurant.find(params[:id]))
        end
    end

    def destroy
        diner = Restaurant.find(params[:id])
        diner.reviews.all {|review| review.destroy}
        diner.days.all {|day| day.destroy}
        diner.destroy
        flash[:notice] = "Restaurant deleted."
        redirect_to restaurants_path
    end

    private

    def restaurant_params
        params.require(:restaurant).permit(
            :name, 
            :address, 
            :carryout, 
            :outdoor_dining, 
            :indoor_dining, 
            :follows_rules,
            :author_id,  
            days_attributes: [
                :id,
                :closed, 
                :weekday_number,
                :opening_time, 
                :closing_time
            ],
            reviews_attributes: [
                :id,
                :user_id,
                :rating,
                :content
            ]
        )

    end

end
