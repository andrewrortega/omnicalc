class CalculationsController < ApplicationController

  def word_count
    @text = params[:user_text]
    @special_word = params[:user_word]

    # ================================================================================
    # Your code goes below.
    # The text the user input is in the string @text.
    # The special word the user input is in the string @special_word.
    # ================================================================================

    text_split_into_array = @text.split

    @word_count = text_split_into_array.length

    @character_count_with_spaces = @text.size

    @character_count_without_spaces = @text.gsub(/\s+/, "").size

    text_scan_for_occurences = @text.downcase.scan(@special_word.downcase)

    @occurrences = text_scan_for_occurences.length

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("word_count.html.erb")
  end

  def loan_payment
    @apr = params[:annual_percentage_rate].to_f
    @years = params[:number_of_years].to_i
    @principal = params[:principal_value].to_f

    # ================================================================================
    # Your code goes below.
    # The annual percentage rate the user input is in the decimal @apr.
    # The number of years the user input is in the integer @years.
    # The principal value the user input is in the decimal @principal.
    # ================================================================================

    monthly_apr = @apr / 100 / 12

    period_in_months = -1 * @years * 12

    numerator = monthly_apr * @principal

    denominator = 1 - (1 + monthly_apr) ** period_in_months

    @monthly_payment = numerator / denominator
    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("loan_payment.html.erb")
  end

  def time_between
    @starting = Chronic.parse(params[:starting_time])
    @ending = Chronic.parse(params[:ending_time])

    # ================================================================================
    # Your code goes below.
    # The start time is in the Time @starting.
    # The end time is in the Time @ending.
    # Note: Ruby stores Times in terms of seconds since Jan 1, 1970.
    #   So if you subtract one time from another, you will get an integer
    #   number of seconds as a result.
    # ================================================================================

    seconds = @ending - @starting

    @seconds =  seconds
    @minutes = seconds / 60
    @hours = seconds / 3600
    @days = seconds / 86400
    @weeks = seconds / 604800
    @years = seconds / 31536000

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("time_between.html.erb")
  end

  def descriptive_statistics
    @numbers = params[:list_of_numbers].gsub(',', '').split.map(&:to_f)

    # ================================================================================
    # Your code goes below.
    # The numbers the user input are in the array @numbers.
    # ================================================================================

    @sorted_numbers = @numbers.sort

    @count = @numbers.count

    @minimum = @numbers.min

    @maximum = @numbers.max

    @range = @maximum - @minimum
    #
    middle=@count/2
    if @count.even?
      median = (@sorted_numbers[middle]+ @sorted_numbers[middle-1])/2
    else
      median = @sorted_numbers[middle]
    end

    @median = median
    #
    @sum = @numbers.sum
    #
    @mean = @sum / @count
    #
    @variance = @numbers.map { |e| e - @mean }.map { |e| e**2  }.sum / @count
    #
    @standard_deviation = @variance**(0.5)
    #
    @mode = @numbers.group_by {|x| x}.group_by {|k,v| v.size}.sort.last.last.map(&:first)

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("descriptive_statistics.html.erb")
  end
end
