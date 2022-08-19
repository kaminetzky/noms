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

  def prev_day_params(pagy_year, pagy_month, pagy_day)
    # To be implemented
    { year_page: pagy_year.page,
      month_page: pagy_month.page,
      day_page: [pagy_day.page - 1, 1].max }
  end

  def next_day_params(pagy_year, pagy_month, pagy_day)
    # To be implemented
    { year_page: pagy_year.page,
      month_page: pagy_month.page,
      day_page: [pagy_day.page + 1, pagy_day.pages].min }
  end
end
