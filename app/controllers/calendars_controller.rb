class CalendarsController < ApplicationController


  def index
    get_week
    @plan = Plan.new
    @week = get_week
    
  end

  def create
    Plan.create(plan_params)
    redirect_to action: :index
  end

  private


  

  def plan_params
    params.require(:plan,:date).permit(:date, :plan )
  end

  def get_week
    @wdays = ['(日)','(月)','(火)','(水)','(木)','(金)','(土)']
  
 
    @todays_date = Date.today
 

    @week_days = []

    plans = Plan.where(date: @todays_date..@todays_date + 6)

    7.times do |x|
      today_plans = []
      plan = plans.map do |plan|
        today_plans.push(plan.plan) if plan.date == @todays_date + x
      end

      wday_num = @todays_date,@wdays
      
      if wday_num > 7
        wday_num = wday_num - 7
      end
      wdays_size = wdays.size
      days = { month: (@todays_date + x).month, date: (@todays_date+x).day, plans: today_plans, wday:(@todays_date+x)}
      @week_days.push(days)
    end

  end
end
