class CreateCoursesStudents < ActiveRecord::Migration[5.2]
  def change
    create_table :courses_students, id: false do |t|
      t.integer :course_id, null: false
      t.integer :student_id, null: false
    end
  end
end
