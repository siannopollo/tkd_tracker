class StudentsController < ApplicationController
  before_filter :authenticate, :only => [:create, :edit, :update, :destroy]
  after_filter :logged_out, :only => [:destroy]
  
  # GET /students
  # GET /students.xml
  def index
    @students = Student.find(:all, :order => "last_name")

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @students }
    end
  end

  # GET /students/1
  # GET /students/1.xml
  def show
    @student = Student.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @student }
    end
  end

  # GET /students/new
  # GET /students/new.xml
  def new
    @student = Student.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @student }
    end
  end

  # GET /students/1/edit
  def edit
    @student = Student.find(params[:id])
  end

  # POST /students
  # POST /students.xml
  def create
    @student = Student.new(params[:student])
    
    flash[:error] = Array.new
    if !@student.is_valid?(flash[:error]) then
      flash.now[:error]
      respond_to do |format|
        format.html { render "new" }
      end
      return
    end

    respond_to do |format|
      if @student.save
        flash[:notice] = 'Student was successfully created.'
        format.html { redirect_to(@student) }
        format.xml  { render :xml => @student, :status => :created, :location => @student }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @student.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /students/1
  # PUT /students/1.xml
  def update
    @student = Student.find(params[:id])
    
    if params[:number_of_classes] != nil && params[:number_of_classes].length != 0 then
      attendance = Attendance.new
      attendance.student_id = @student.id
      attendance.number_of_classes = params[:number_of_classes]
      attendance.date = Date.today
      attendance.save
      flash[:notice] = 'Student was successfully updated.'
    end
    
    test = TkdTest.new(params[:test])
    if (test.result != nil && test.result.length != 0) then
      test.date = Date.today
      @student.tests << test
      @student.last_test = test.date
    end   

    respond_to do |format|
      if @student.update_attributes(params[:student])
        flash[:notice] = 'Student was successfully updated.'
        format.html { redirect_to(@student) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @student.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /students/1
  # DELETE /students/1.xml
  def destroy
    @student = Student.find(params[:id])
    @student.destroy

    respond_to do |format|
      format.html { redirect_to(students_url) }
      format.xml  { head :ok }
    end
  end
end
