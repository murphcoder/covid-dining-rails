module ApplicationHelper

    def is_logged_in?
        !!session[:user_id]
    end

    def current_user
        User.find_by(id: session[:user_id])
    end

    def menu
        if is_logged_in?
            render 'logged_in'
        else
            render 'logged_out'
        end
    end

    def day_to_week(num)
        if num == 0
            "Sunday"
        elsif num == 1
            "Monday"
        elsif num == 2
            "Tuesday"
        elsif num == 3
            "Wednesday"
        elsif num == 4
            "Thursday"
        elsif num == 5
            "Friday"
        elsif num == 6
            "Saturday"
        end
    end

end
