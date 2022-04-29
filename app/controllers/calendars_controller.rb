class CalendarsController < ApplicationController

  # １週間のカレンダーと予定が表示されるページ
  def index
    get_week
    @plan = Plan.new
  end

  # 予定の保存
  def create
    Plan.create(get_params)
    redirect_to action: :index
  end

  private

  def get_params
    params.require(:calendars).permit(:date, :plan)
  end

  def get_week
    wdays = ['(日)','(月)','(火)','(水)','(木)','(金)','(土)']

    # Dateオブジェクトは、日付を保持しています。下記のように`.today.day`とすると、今日の日付を取得できます。
    @date_today = Date.today
    # 例)　今日が2月1日の場合・・・ Date.today.day => 1日

    @week_days = []

    plans = Plan.where(date: @date_today..@date_today + 6)

    7.times do |x|
      plans_today = []
      plans.each do |plan|
        plans_today.push(plan.plan) if plan.date == @date_today + x
      end
      days = { month: (@date_today + x).month, date: (@date_today + x).day, plans: plans_today }
      @week_days.push(days)
    end

  end
end
