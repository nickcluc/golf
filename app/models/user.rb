class User < ActiveRecord::Base
  mount_uploader :cover_image, CoverImageUploader
  mount_uploader :profile_photo, ProfilePhotoUploader

  has_many :rounds
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

  DIFF_HASH = {
    5 => 1,
    6 => 1,
    7 => 2,
    8 => 2,
    9 => 3,
    10 => 3,
    11 => 4,
    12 => 4,
    13 => 5,
    14 => 5,
    15 => 6,
    16 => 6,
    17 => 7,
    18 => 8,
    19 => 9,
    20 => 10
  }.freeze

  def full_name
    first_name && last_name ? first_name + " " + last_name : "Add your full name"
  end

  def not_scored_rounds(rounds_count=3)
    not_scored = []
    rounds = self.rounds.includes(:player_rounds).includes(:course)
    rounds.where("round_date < ?", Date.today).to_a.keep_if { |r| r.unscored?}
  end

  def upcoming_rounds
    rounds.includes(:course).where("round_date > ?", Date.today)
  end

  def handicap
    return "You need to play #{5 - rounds.count} more rounds to calculate a handicap." if rounds.count < 5

    differentials = get_differentials

    usable_differentials = []
    diff_count = differentials.length

    n = DIFF_HASH[diff_count] rescue ArgumentError
    n.times{ usable_differentials << differentials.shift }
    ( usable_differentials.inject(0) { |sum, number| sum + number } / usable_differentials.length * 0.96 ).round(2)
  end

  def course_rounds(course)
    upcoming_rounds.where(course_id: course.id)
  end

  def accepted_friends
    friendships.where(user_id: self.id, accepted: true) || friendships.where(friend_id: self.id, accepted: true)
  end

  def friendship_pending_with(other_user)
    friendships.find_by(accepted:false, friend_id: other_user.id)
  end

  def pending_friendships(current_user)
    Friendship.where(friend_id: current_user.id, accepted: false, ignored: false)
  end

  private

  def usable_rounds
    player_rounds
      .includes(:round)
      .includes(:tee)
      .sort_by { |player_round| player_round.date }
      .reverse
      .last(20)
  end

  def get_differentials
    differentials = []
    usable_rounds.each do |round|
      differentials << (round.score - round.tee.rating) * 113 / round.tee.slope
    end
    differentials.sort!
  end
end
