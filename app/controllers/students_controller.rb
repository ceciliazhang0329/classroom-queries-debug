class StudentsController < ApplicationController
  def index
    @students = Student.all.order({ :created_at => :desc })

    render({ :template => "students/index" })
  end

  def show
    the_id = params.fetch("path_id")
    @student = Student.where({:id => the_id }).at(0)

    render({ :template => "students/show" })
  end

  def create
    @student = Student.new
    @student.first_name = params.fetch("query_first_name")
    @student.last_name = params.fetch("query_last_name")
    @student.email = params.fetch("query_email")

    if @student.valid?
      @student.save
      redirect_to("/students", { :notice => "Student created successfully." })
    else
      redirect_to("/students", { :notice => "Student failed to create successfully." })
    end
  end

  def update
    the_id = params.fetch("path_id")
    @student = Student.where({ :id => the_id }).at(0)

    @student.first_name = params.fetch("query_first_name")
    @student.last_name = params.fetch("query_last_name")
    @student.email = params.fetch("query_email")

    if @student.valid?
      @student.save
      redirect_to("/students/#{@student.id}", { :notice => "Student updated successfully."} )
    else
      redirect_to("/students/#{@student.id}", { :alert => "Student failed to update successfully." })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    @student = Student.where({ :id => the_id }).at(0)

    @student.destroy

    redirect_to("/students", { :notice => "Student deleted successfully."} )
  end

  def create_en
    @enrollment = Enrollment.new
    @enrollment.course_id = params.fetch("query_course_id")
    @enrollment.student_id = params.fetch("query_student_id")

    if @enrollment.valid?
      @enrollment.save
      redirect_to("/students/#{@enrollment.student_id}", { :notice => "Enrollment created successfully." })
    else
      redirect_to("/students/#{@enrollment.student_id}", { :notice => "Enrollment failed to create successfully." })
    end
  end
end
