module ConferencesHelper
  def dates_in_words(first_day, last_day)
    text = first_day.strftime('%b %-d') 
    if last_day != first_day
      text += "-"
      if last_day.month == first_day.month
        text += last_day.strftime('%-d')
      else
        text +=last_day.strftime('%b %-d')
      end
    end
    return text
  end
end
