require 'school'
require 'student'

class TkdTestsController < ApplicationController
  before_filter :authenticate, :only => [:create, :edit, :update, :destroy, :create_multiple]

  # GET /tests
  # GET /tests.xml
  def index
    @tests = TkdTest.all
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @tests }
    end
  end

  # GET /tests/1
  # GET /tests/1.xml
  def show
    @test = TkdTest.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @test }
    end
  end

  # GET /tests/new
  # GET /tests/new.xml
  def new
    @test = TkdTest.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @test }
    end
  end

  # GET /tests/1/edit
  def edit
    @test = TkdTest.find(params[:id])
  end

  # POST /tests
  # POST /tests.xml
  def create
    @test = TkdTest.new(params[:tkd_test])

    respond_to do |format|
      if @test.save
        format.html { redirect_to(:back, :notice => 'Test was successfully created.') }
        format.xml  { render :xml => @test, :status => :created, :location => @test }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @test.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /tests/1
  # PUT /tests/1.xml
  def update
    @test = TkdTest.find(params[:id])

    respond_to do |format|
      if @test.update_attributes(params[:tkd_test])
        format.html { redirect_to(@test, :notice => 'Test was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @test.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /tests/1
  # DELETE /tests/1.xml
  def destroy
    @test = TkdTest.find(params[:id])
    @test.destroy

    respond_to do |format|
      format.html { redirect_to(:action => :index) }
      format.xml  { head :ok }
    end
  end

  def create_multiple
    test_date = params[:test_date]
    students = params[:students]
    students_updated = 0

    students.each do |student|
      if (!(student[1][:test_for].blank?) && !(student[1][:result].blank?))
        tkdtest = TkdTest.new(student[1])
        tkdtest.student_id = student[0]
        tkdtest.date = test_date
        tkdtest.save
        students_updated += 1
      end
    end

    respond_to do |format|
      format.html {
        redirect_to(:back, :notice => "Successfully added test results to #{students_updated} students")
      }
    end
  end

  def show_multiple
    @schools = Array.new
    @active_black_belt_names_for_select = Array.new

    Student.where("rank < 1 and active = 't'").order("last_name ASC").each do |black_belt|
      @active_black_belt_names_for_select << ["#{black_belt.last_name}, #{black_belt.first_name}", "#{black_belt.last_name}, #{black_belt.first_name}"]
    end


    School.all.each do |school|
      @schools << school
    end

    respond_to do |format|
      format.html {render :action => "show_multiple"}
    end
  end
end
