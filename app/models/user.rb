class User < ActiveRecord::Base
  mount_uploader :cover_image, CoverImageUploader
  mount_uploader :profile_photo, ProfilePhotoUploader
  has_many :rounds, -> { includes(:player_rounds) }
  has_many :player_rounds
  has_many :courses
  has_many :tees
  has_many :friendships
  has_many :friends, through: :friendships
  has_many :posts, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  searchkick

  def full_name
    if first_name && last_name
      first_name + " " + last_name
    else
      "Add your full name"
    end
  end

  def not_scored_rounds
    not_scored = []
    rounds.each do |round|
      if round.round_date < Date.today
        if round.player_rounds.empty?
          not_scored << round
        end
      end
    end
    not_scored.last(3)
  end

  def upcoming_rounds
    upcoming = []
    rounds.each do |round|
      if round.round_date > Date.today
        upcoming << round
      end
    end
    upcoming
  end

  def handicap
    if player_rounds.count >= 5
      differentials = []
      player_rounds.each do |round|
        differentials << (round.score - round.tee.rating) * 113 / round.tee.slope
      end
      differentials.sort!
      usable_differentials = []
      diff_count = differentials.length
      if diff_count == 5 || diff_count == 6
        n = 1
      elsif diff_count == 7 || diff_count == 8
        n = 2
      elsif diff_count == 9 || diff_count == 10
        n = 3
      elsif diff_count == 11 || diff_count == 12
        n = 4
      elsif diff_count == 13 || diff_count == 14
        n = 5
      elsif diff_count == 15 || diff_count == 16
        n = 6
      elsif diff_count == 17
        n = 7
      elsif diff_count == 18
        n = 8
      elsif diff_count == 19
        n = 9
      elsif diff_count == 20
        n = 10
      end
      n.times do
        usable_differentials << differentials.shift
      end
      hcap_sum = usable_differentials.inject(0) do |sum, number|
        sum + number
      end
      hcap = (hcap_sum / usable_differentials.length * 0.96).round(0)
    else
      hcap = "You need to play #{5-player_rounds.count}
                more rounds to calculate a handicap."
    end
    hcap
  end

  def course_rounds(course)
    upcoming_course_rounds = []
    rounds.where(course_id: course.id).each do |round|
      if round.round_date > Date.today
        upcoming_course_rounds << round
      end
    end
    upcoming_course_rounds
  end

  def accepted_friends
    friendships.where(accepted: true)
  end

  def friendship_pending_with(other_user)
    friendships.find_by(accepted:false, friend_id: other_user.id)
  end

  def pending_friendships(current_user)
    Friendship.where(friend_id: current_user.id, accepted: false, ignored: false)
  end
end
