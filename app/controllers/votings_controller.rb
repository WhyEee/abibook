# encoding: utf-8

class VotingsController < ApplicationController
  def index
    @teachers = Voting.where(:subject_type => :teachers)
    @students = Voting.where(:subject_type => :students)
    @compl_ids = Vote.by_author(current_user.student).pluck(:voting_id).uniq
  end

  def show
    @voting = Voting.find(params[:id])

    if @voting.subject_type == :students
      @males = Student.where("id != ?", current_user.student.id).where(:gender => :male).order(:name)
      @females = Student.where("id != ?", current_user.student.id).where(:gender => :female).order(:name)
    else
      @males = Teacher.where(:gender => :male).order(:name)
      @females = Teacher.where(:gender => :female).order(:name)
    end

    @votes = @voting.votes.by_author(current_user.student).map { |v| v }
    3.times { @votes << Vote.new }
    @votes = @votes.first(3)

    male = []
    female = []
    @votes.each do |v|
      male << v unless v.male.nil?
      female << v unless v.female.nil?
    end

    case male.count
      when 2
        @voting.male_priority =
            male[0].male_priority == 4 ? :weighted : :balanced
      when 3
        @voting.male_priority =
            male[0].male_priority == 3 ? :weighted : :balanced
      else
        @voting.male_priority = :weighted
    end

    case female.count
      when 2
        @voting.female_priority =
            female[0].female_priority == 4 ? :weighted : :balanced
      when 3
        @voting.female_priority =
            female[0].female_priority == 3 ? :weighted : :balanced
      else
        @voting.female_priority = :weighted
    end
  end

  def update
    @voting = Voting.find(params[:id])

    male = []
    female = []

    params[:voting][:votes_attributes].each do |key, val|
      val[:author_id] = current_user.student.id
      val[:male_type] = val[:male_id] == "" ? nil : @voting.subject_type == :students ? 'Student' : 'Teacher'
      val[:female_type] = val[:female_id] == "" ? nil : @voting.subject_type == :students ? 'Student' : 'Teacher'
      val[:male_priority] = nil
      val[:female_priority] = nil
      male << key unless val[:male_id] == ""
      female << key unless val[:female_id] == ""
    end

    case male.count
      when 1
        params[:voting][:votes_attributes][male[0]][:male_priority] = 6
      when 2
        params[:voting][:votes_attributes][male[0]][:male_priority] =
            params[:voting][:male_priority] == "weighted" ? 4 : 3
        params[:voting][:votes_attributes][male[1]][:male_priority] =
            params[:voting][:male_priority] == "weighted" ? 2 : 3
      when 3
        params[:voting][:votes_attributes][male[0]][:male_priority] =
            params[:voting][:male_priority] == "weighted" ? 3 : 2
        params[:voting][:votes_attributes][male[1]][:male_priority] =
            params[:voting][:male_priority] == "weighted" ? 2 : 2
        params[:voting][:votes_attributes][male[2]][:male_priority] =
            params[:voting][:male_priority] == "weighted" ? 1 : 2
      else
    end

    case female.count
      when 1
        params[:voting][:votes_attributes][female[0]][:female_priority] = 6
      when 2
        params[:voting][:votes_attributes][female[0]][:female_priority] =
            params[:voting][:female_priority] == "weighted" ? 4 : 3
        params[:voting][:votes_attributes][female[1]][:female_priority] =
            params[:voting][:female_priority] == "weighted" ? 2 : 3
      when 3
        params[:voting][:votes_attributes][female[0]][:female_priority] =
            params[:voting][:female_priority] == "weighted" ? 3 : 2
        params[:voting][:votes_attributes][female[1]][:female_priority] =
            params[:voting][:female_priority] == "weighted" ? 2 : 2
        params[:voting][:votes_attributes][female[2]][:female_priority] =
            params[:voting][:female_priority] == "weighted" ? 1 : 2
      else
    end

    if male.count + female.count == 0
      params[:voting][:votes_attributes].each do |key, val|
        val[:_destroy] = 1
      end
    end

    respond_to do |format|
      if @voting.update_attributes(params[:voting])
        format.html { redirect_to votings_path, notice: '<b>Vielen Dank!</b> Deine Stimme wurde gezählt!' }
        format.json { head :no_content }
      else
        format.html { render action: "show" }
        format.json { render json: @voting.errors, status: :unprocessable_entity }
      end
    end
  end
end
