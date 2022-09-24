module MealsHelper
  def last_day_params
    meals_user = current_user.nil? ? Meal.all : Meal.where(user: current_user)

    return { year_page: 1, month_page: 1, day_page: 1 } if meals_user.empty?

    starting = meals_user.minimum('consumed_on') - 6.hours
    ending = meals_user.maximum('consumed_on') - 6.hours

    on_same_year = ending.year == starting.year
    on_same_month = on_same_year && ending.month == starting.month

    last_year_page = ending.year - starting.year + 1
    last_month_page = on_same_year ? ending.month - starting.month + 1 : ending.month
    last_day_page = on_same_month ? ending.day - starting.day + 1 : ending.day

    { year_page: last_year_page,
      month_page: last_month_page,
      day_page: last_day_page }
  end

  def prev_day_params(calendar)
    prev_day_page = calendar[:day].page - 1
    prev_month_page = calendar[:month].page
    prev_year_page = calendar[:year].page

    if prev_day_page.zero?
      prev_month = calendar[:month].from.month - 1
      prev_year = calendar[:year].from.year

      if prev_month.zero?
        prev_month = 12
        prev_year -= 1
      end

      on_same_year = prev_year == calendar[:year].starting.year
      on_same_month = on_same_year && prev_month == calendar[:year].starting.month

      month_offset = on_same_year ? calendar[:year].starting.month - 1 : 0
      day_offset = on_same_month ? calendar[:year].starting.day - 1 : 0

      prev_day_page = Time.days_in_month(prev_month, prev_year) - day_offset
      prev_month_page -= 1

      if prev_month_page.zero?
        prev_month_page = 12 - month_offset
        prev_year_page -= 1

        if prev_year_page.zero?
          prev_year_page = 1
          prev_month_page = 1
          prev_day_page = 1
        end
      end
    end

    { year_page: prev_year_page,
      month_page: prev_month_page,
      day_page: prev_day_page }
  end

  def next_day_params(calendar)
    next_day_page = calendar[:day].page + 1
    next_month_page = calendar[:month].page
    next_year_page = calendar[:year].page

    if next_day_page > calendar[:day].pages
      next_day_page = 1
      next_month_page += 1

      if next_month_page > calendar[:month].pages
        next_month_page = 1
        next_year_page += 1

        if next_year_page > calendar[:year].pages
          next_day_page = calendar[:day].page
          next_month_page = calendar[:month].page
          next_year_page = calendar[:year].page
        end
      end
    end

    { year_page: next_year_page,
      month_page: next_month_page,
      day_page: next_day_page }
  end
end
