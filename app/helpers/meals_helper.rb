module MealsHelper
  def last_day_params
    meals_user = current_user.nil? ? Meal.all : Meal.where(user: current_user)

    starting = meals_user.minimum('consumed_on') - 6.hours
    ending = meals_user.maximum('consumed_on') - 6.hours

    on_same_year = ending.year == starting.year
    on_same_month = ending.year == starting.year && ending.month == starting.month

    last_year_page = ending.year - starting.year + 1
    last_month_page = on_same_year ? ending.month - starting.month + 1 : ending.month
    last_day_page = on_same_month ? ending.day - starting.day + 1 : ending.day

    { year_page: last_year_page,
      month_page: last_month_page,
      day_page: last_day_page }
  end

  def prev_day_params(calendar)
    # To be implemented
    { year_page: calendar[:year].page,
      month_page: calendar[:month].page,
      day_page: [calendar[:day].page - 1, 1].max }
  end

  def next_day_params(calendar)
    next_day_page = calendar[:day].page + 1
    next_month_page = calendar[:month].page
    next_year_page = calendar[:year].page

    if next_day_page > calendar[:day].pages
      next_day_page = 1
      next_month_page += 1
    end

    if next_month_page > calendar[:month].pages
      next_month_page = 1
      next_year_page += 1
    end

    if next_year_page > calendar[:year].pages
      next_day_page = calendar[:day].page
      next_month_page = calendar[:month].page
      next_year_page = calendar[:year].page
    end

    { year_page: next_year_page,
      month_page: next_month_page,
      day_page: next_day_page }
  end
end
