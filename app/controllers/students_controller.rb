class StudentsController < ApplicationController
  before_action :set_student, only: [:show, :edit, :update, :destroy]

  # GET /students
  # GET /students.json
  def index
    @students = Student.all
  end

  # GET /students/1
  # GET /students/1.json
  def show
  end

  # GET /students/new
  def new
    @student = Student.new
  end

  # GET /students/1/edit
  def edit
  end

  # POST /students
  # POST /students.json
  def create
    @student = Student.new(student_params)

    respond_to do |format|
      if @student.save
        format.html { redirect_to @student, notice: 'Student was successfully created.' }
        format.json { render :show, status: :created, location: @student }
      else
        format.html { render :new }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /students/1
  # PATCH/PUT /students/1.json
  def update
    respond_to do |format|
      if @student.update(student_params)
        format.html { redirect_to @student, notice: 'Student was successfully updated.' }
        format.json { render :show, status: :ok, location: @student }
      else
        format.html { render :edit }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /students/1
  # DELETE /students/1.json
  def destroy
    @student.destroy
    respond_to do |format|
      format.html { redirect_to students_url, notice: 'Student was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # GET /students/1/courses 
  def courses 
    @student = Student.find(params[:id]) 
    @courses = @student.courses 
  end
  
     
# POST /students/1/course_add?course_id=2
def course_add 
  #Convert ids from routing to objects 
  @student = Student.find(params[:id])
  @course = Course.find(params[:course])
  unless @student.enrolled_in?(@course) 
    #add course to list using << operator 
    @student.courses << @course 
    flash[:notice] = 'Student was successfully enrolled' 
  else 
     flash[:error] = 'Student was already enrolled' 
  end 
  redirect_to action: "courses", id: @student 
end

def course_remove 
  #Convert ids from routing to object 
  @student = Student.find(params[:id]) 
  
  #get list of courses to remove from query string
  course_ids = params[:courses] 
  if course_ids.any? 
    course_ids.each do |course_id| 
      course = Course.find(course_id) 
      if @student.enrolled_in?(course)
        logger.info "Removing student from course #{course.id}" 
        @student.courses.delete(course) 
        flash[:notice] = 'Course was successfully deleted'
      end 
    end 
  end 
  redirect_to action: "courses", id: @student 
end

private
    # Use callbacks to share common setup or constraints between actions.
    def set_student
      @student = Student.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def student_params
      params.require(:student).permit(:given_name, :middle_name, :family_name, :date_of_birth, :grade_point_average, :start_date)
    end
end
