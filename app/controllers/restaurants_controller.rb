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
        @restaurant = Restaurant.new(restaurant_params)
        if @restaurant.save
            redirect_to restaurant_path(@restaurant)
        else
            render :new
        end
    end

    def update
        @restaurant = Restaurant.find(params[:id])
        @restaurant.update(restaurant_params)
        if @restaurant.valid?
            redirect_to restaurant_path(@restaurant)
        else
            render :edit
        end
    end

    def destroy
        diner = Restaurant.find(params[:id])
        diner.reviews.each {|review| review.destroy}
        diner.days.each {|day| day.destroy}
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
