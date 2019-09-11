module UsersHelper
    def plan_count(cat)
        plans = cat.schedules.where(cat_id: cat.id)
        return plans.count
    end
    def date_over(cat)
         plans = cat.schedules.where('plan_date<?',Date.today)
        return plans.count
    end
end
