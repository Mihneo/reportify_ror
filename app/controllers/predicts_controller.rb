class PredictsController < ApplicationController
  after_action :set_label, only: :calculate_and_predict

  def index; end

  def calculate_and_predict
    session[:label] = predict_news(params[:description])
    binding.pry
    redirect_to show_path
  end

  def show
    @label = session[:label]
  end

  private

  def set_label
    @label
  end

  PREDICTS_URL = 'https://news-reportify.herokuapp.com/news/'

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
      if label['article_label'].to_i.zero?
        "True"
      else
        "Fake"
      end
    end
end