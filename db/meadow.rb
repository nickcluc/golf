require 'pry'
course_id = 1
nums = 1..18
nums = nums.to_a
yardages = [526,343,312,324,314,110,437,146,372,360,457,153,389,319,329,143,341,420]
hcps = [3,11,13,1,5,17,7,15,9,10,8,16,2,14,4,18,12,6]
pars = [5,4,4,4,4,3,5,3,4,4,5,3,4,4,4,3,4,4]
Hole.transaction do
  nums.each do |n|
    Hole.create(
      number: n,
      yardage: yardages[nums.index(n)],
      handicap: hcps[nums.index(n)],
      course_id: course_id,
      par: pars[nums.index(n)]
    )
  end
end

TeeYardage.transaction do
  course = Course.find(course_id)
  tee = course.tees.first
  course.holes.each do |hole|
    ty = {
      tee_id: tee.id,
      hole_id: hole.id,
      yardage: hole.yardage
    }
    TeeYardage.create(ty)
  end
end
