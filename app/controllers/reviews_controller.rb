class ReviewsController < ApplicationController
    before_action :require_login, only: [:new, :edit]

    def show
        @review = Review.find(params[:id])
    end

    def new
        diner = Restaurant.find(params[:restaurant_id])
        if diner.users.include?(current_user) && !current_user.admin
            first_review = diner.reviews.select {|review| review.user == current_user}.first
            flash[:notice] = "Sorry, one review per restaurant per user."
            redirect_to edit_restaurant_review_path(diner, first_review)
        end
        @review = Review.new(restaurant_id: diner.id)
    end

    def edit
        if params[:restaurant_id]
            restaurant = Restaurant.find_by(id: params[:restaurant_id])
            if restaurant
                @review = restaurant.reviews.find_by(id: params[:id])
                return head(:forbidden) if @review.nil?
                if @review.user != current_user && !current_user.admin
                    return head(:forbidden)
                end
            else
                flash[:notice] = "Restaurant Not Found."
                redirect_to restaurants_path
            end
        else
            flash[:notice] = "Restaurant Not Found."
            redirect_to restaurants_path
        end
    end

    def create
        diner = Restaurant.find(review_params[:restaurant_id])
        @review = Review.new(review_params)
        if @review.save
            redirect_to restaurant_review_path(diner, @review)
        else
            render :new
        end
    end

    def update
        @review = Review.find(params[:id])
        @review.update(review_params)
        if @review.valid?
            redirect_to review_path(review)
        else
            render :edit
        end
    end

    def destroy
        review = Review.find(params[:id])
        diner = Restaurant.find_by(id: params[:restaurant_id])
        review.destroy
        flash[:notice] = "Review deleted."
        if diner
            redirect_to restaurant_path(diner)
        else
            redirect_to restaurants_path
        end
    end

    private

    def review_params
        params.require(:review).permit(:user_id, :restaurant_id, :rating, :content)
    end

end
