require 'spec_helper'
require 'date'
require './orders_report'

describe OrdersReport do

  describe "#total_sales_within_range" do
    it 'returns the total sales in range' do
      order_within_range = Order.new(amount: 5,
                                     placed_at: Date.new(2016, 2, 5))
      order_out_of_range = Order.new(amount: 10,
                                     placed_at: Date.new(2016, 3, 1))

      orders = [order_out_of_range, order_within_range]

      start_date = Date.new(2016, 1, 1)
      end_date = Date.new(2016, 2, 20)

      orders_report = OrdersReport.new(orders, start_date, end_date)

      expect(orders_report.total_sales_within_range).to eql(5)
    end
  end
end

