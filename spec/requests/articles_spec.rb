require 'rails_helper'

RSpec.describe ArticlesController, type: :request do
  describe "GET /index" do
    before(:each) do 
      @article = Article.create(title: "First Article", bode: "body")
    end

    context "Get all articles" do 
      it 'return all articles' do 
        get "/articles"
        expect(response).to have_http_status(200)
        res = JSON response.body
        expect(res.count).to eq(Article.count)
      end
    end

    context "Get an articles" do 
      it 'return a articles for show article api' do 
        get "/articles/#{@article.id}"
        expect(response).to have_http_status(200)
        res = JSON response.body
        expect(res["id"]).to eq(@article.id)
      end

      it 'raise error when passing wrong id' do 
        get "/articles/0"
        expect(response).to have_http_status(404)
        res = JSON response.body
        expect(res["message"]).to eq("not found")
      end
    end

  end
end
