# == Schema Information
#
# Table name: students
#
#  id         :integer          not null, primary key
#  name       :string
#  hometown   :string
#  birthday   :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Student < ActiveRecord::Base
  has_many :classroom_students
  has_many :classrooms, through: :classroom_students

  def self.search(query)
    query ||= ''
    terms = query.split(/\s/)
    results = Student.all.to_a
    return results if terms.empty?
    terms.each do |term|
      results.delete_if {|student| !(/#{term}/i.match(student.name))}
    end
    results
  end
end
