module ApplicationHelper
    def title_name(title)     #タイトル名
        str = "ページ |"
        title == "" ? str : str+"#{title}"
    end
    def admin_page
        if logged_in?
            if current_user.admin?
                redirect_to users_url
            end     
        end        
    end        
end
