require 'rails_helper'

RSpec.describe ArticlesController, type: :request do
  describe "GET /index" do
    let(:base_url) {"/articles"}
    let(:create_params) {
      {article: {title: "title", bode: "bode"}}
    }
    before(:each) do 
      @article = Article.create(title: "First Article", bode: "body")
    end

    context "Get all articles" do 
      it 'return all articles' do 
        get base_url
        expect(response).to have_http_status(200)
        res = JSON response.body
        expect(res.count).to eq(Article.count)
      end
    end

    context "Get an articles" do 
      it 'return a articles for show article api' do 
        get "#{base_url}/#{@article.id}"
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

    context "Create article" do 
      it 'return a articles for show article api' do 
        pre_article_count = Article.count
        post "/articles", params: create_params
        expect(response).to have_http_status(201)
        res = JSON response.body
        expect(Article.count).to eq(pre_article_count+1)
      end

      it 'raise error when pass wrong arguments' do 
        post "/articles", params: {article: {title: "", bode: ""}}
        expect(response).to have_http_status(422)
      end
    end

    context "Update article" do 
      it 'update the fields of article' do 
        patch "/articles/#{@article.id}", params: {article: {title: "1 title"}}
        expect(response).to have_http_status(200)
        res = JSON response.body
        expect(Article.find(@article.id).title).to eq("1 title")
      end

      it 'raise error when pass wrong arguments' do 
        patch "/articles/#{@article.id}", params: {article: {title: ""}}
        expect(response).to have_http_status(422)
      end
    end

    context "Get an articles" do 
      it 'return a articles for show article api' do 
        delete "/articles/#{@article.id}"
        expect(response).to have_http_status(200)
        expect(Article.find_by_id(@article.id)).to eq(nil)
      end
    end


  end
end
