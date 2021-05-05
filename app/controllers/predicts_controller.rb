class PredictsController < ApplicationController
  def index; end

  def create
    binding.pry
    predict_news(params[:description])
  end

  private

  PREDICTS_URL = 'http://127.0.0.1:5000/news/'

  def predict
    @predict ||= Predict.new
  end

  def parse_body(description)
    description.split(' ').join('%20')
  end

  def predict_news(description)
      url = URI.parse(PREDICTS_URL + parse_body(description))
      req = Net::HTTP::Get.new(url.to_s)
      res = Net::HTTP.start(url.host) do |http|
        http.request(req)
      end

      label = JSON.parse(res.body)

      if label.zero?
        "True"
      else
        "Fake"
      end
    end
end