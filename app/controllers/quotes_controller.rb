class QuotesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :check_resource, :only => [:edit, :update, :destroy]

  # GET /quotes
  # GET /quotes.json
  def index
    @quotes = current_user.student.quotes

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @quotes }
    end
  end

  # GET /quotes/1
  # GET /quotes/1.json


  # GET /quotes/new
  # GET /quotes/new.json
  def new
    @quote = Quote.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @quote }
    end
  end

  # GET /quotes/1/edit
  def edit

  end

  # POST /quotes
  # POST /quotes.json
  def create
    @quote = Quote.new(params[:quote])
    @quote.author = current_user.student

    respond_to do |format|
      if @quote.save
        format.html { redirect_to quotes_path, notice: '<b>Sauber!</b> Dein Zitat wurde erfolgreich gespeichert!' }
        format.json { render json: @quote, status: :created, location: @quote }
      else
        format.html { render action: "new" }
        format.json { render json: @quote.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /quotes/1
  # PUT /quotes/1.json
  def update
    respond_to do |format|
      if @quote.update_attributes(params[:quote])
        format.html { redirect_to quotes_path, notice: '<b>Sauber!</b> Dein Zitat wurde erfolgreich gespeichert!' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @quote.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /quotes/1
  # DELETE /quotes/1.json
  def destroy
    @quote.destroy

    respond_to do |format|
      format.html { redirect_to quotes_path }
      format.json { head :no_content }
    end
  end

  def check_resource
    @quote = Quote.find(params[:id])

    unless @quote.author == current_user.student
      redirect_to quotes_path, alert: '<b>Halt, stopp!</b> Du kannst nur deine eigenen Zitate bearbeiten!'
    end
  end
end