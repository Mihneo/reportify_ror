class PredictsController < ApplicationController
  after_action :set_label, only: :calculate_and_predict

  def index; end

  def calculate_and_predict
    session[:label], session[:probability] = predict_news(params[:description])
    redirect_to show_path
  end

  def show
    @label = session[:label]
    @probability = session[:probability]
  end

  private

  def set_label
    @label
  end

  PREDICTS_URL = 'http://0.0.0.0:90/news/'.freeze#'https://news-reportify.herokuapp.com/news/'.freeze

  def parse_body(description)
    description = I18n.transliterate(description)
    description.split(' ').join('%20')
  end

  def predict_news(description)
    url = URI.parse(PREDICTS_URL + parse_body(description))
    req = Net::HTTP::Get.new(url.to_s)
    res = Net::HTTP.start(url.host) do |http|
      http.request(req)
    end

    label = JSON.parse(res.body)
    if label['article_label'] == 'TRUE'
      ['True', label['probability']]
    else
      ['Fake', label['probability']]
    end
  end
end
