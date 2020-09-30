require 'net/http'
require 'nokogiri'
require 'json'
require "awesome_print"

def get_saling_items(items)
  items.select { |item| item["status"] != 3 }
end

def affordable_items(expect_price, max_limit, items)
  result = []
  items.each do |item|
    next if item["price"].is_a?(Integer)
    price = item["price"].split('~')[0].to_i
    area = item["area"][0..-2].split('~')
    total_price = area.map { |space| space.to_i * price }
    p total_price
    if max_limit > total_price.min && expect_price > price
      result << item
    end
  end
  result
end

# 591
scraped_result = []
uri = URI('https://newhouse.591.com.tw/home/housing/search')
params = { rid: 3, sid: '44,43,37,42,47,40', price: '1,2', page: 1 }
loop do
  uri.query = URI.encode_www_form(params)
  req = JSON.parse(Net::HTTP.get(uri))
  all_items = req["data"]["items"]
  scraped_result += all_items
  params[:page] += 1
  break if all_items.empty?
end

scraped_result
saling_items = get_saling_items(scraped_result)
my_item = affordable_items(40, 1000, saling_items)
p my_item.size