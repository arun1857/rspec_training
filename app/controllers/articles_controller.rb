class ArticlesController < ApplicationController
	before_action :set_article, only: [:show, :update, :destroy]
    def index
      @articles = Article.all
      render json: @articles, status: :ok
    end
    def show
      render json: @article
    end
    def create
      @article = Article.new(article_params)
      if @article.save
        render json: @article, status: :created
      else
        render json: @article.errors, status: :unprocessable_entity
      end
    end
    def update
      if @article.update(article_params)
        render json: @article
      else
        render json: @article.errors, status: :unprocessable_entity
      end
    end
    def destroy
      @article.destroy
    end
    private
      def set_article
        @article = Article.find_by_id(params[:id])
        unless @article.present?
        	render json: {message: "not found"}, status: :not_found
        end
      end
      def article_params
        params.require(:article).permit(:title, :body)
      end	
end
