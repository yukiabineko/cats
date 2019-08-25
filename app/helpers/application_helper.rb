module ApplicationHelper
    def title_name(title)     #タイトル名
        str = "ページ |"
        title == "" ? str : str+"#{title}"
    end
end
