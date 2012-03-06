class CommentsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :check_resource, :only => [:edit, :update, :destroy]

  # GET /comments
  # GET /comments.json
  def index
    @comments = current_user.student.submitted_comments

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @comments }
    end
  end

  # GET /comments/new
  # GET /comments/new.json
  def new
    @comment = Comment.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @comment }
    end
  end

  # GET /comments/1/edit
  def edit

  end

  # POST /comments
  # POST /comments.json
  def create
    @comment = Comment.new(params[:comment])
    @comment.author = current_user.student

    respond_to do |format|
      if @comment.save
        format.html { redirect_to comments_path, notice: '<b>Sauber!</b> Dein Kommentar wurde erfolgreich gespeichert!' }
        format.json { render json: @comment, status: :created, location: @comment }
      else
        format.html { render action: "new" }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /comments/1
  # PUT /comments/1.json
  def update
    respond_to do |format|
      if @comment.update_attributes(params[:comment])
        format.html { redirect_to comments_path, notice: '<b>Sauber!</b> Dein Kommentar wurde erfolgreich gespeichert!' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to comments_path }
      format.json { head :no_content }
    end
  end

  def check_resource
    @comment = Comment.find(params[:id])

    unless @comment.author == current_user.student
      redirect_to comments_path, alert: '<b>Halt, stopp!</b> Du kannst nur deine eigenen Kommentare bearbeiten!'
    end
  end
end
