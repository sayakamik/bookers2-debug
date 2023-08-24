class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :profile_image
  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy

  # xxxはアソシエーションが繋がっているテーブル名、class_nameは実際のモデルの名前、foreign_keyは外部キーとして何を持つかを表しています。
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  #「has_many :テーブル名, through: :中間テーブル名」 の形を使って、テーブル同士が中間テーブルを通じてつながっていることを表現します。(followerテーブルとfollowedテーブルのつながりを表す）
  # 例えば、yyyにfollowedを入れてしまうと、followedテーブルから中間テーブルを通ってfollowerテーブルにアクセスすることができなくなってしまいます。
  #  これを防ぐためにyyyには架空のテーブル名を、zzzは実際にデータを取得しにいくテーブル名を書きます。
  has_many :followers, through: :relationships, source: :users
  #この結果、@user.yyyとすることでそのユーザーがフォローしている人orフォローされている人の一覧を表示することができるようになります。

  has_many :relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followeds, through: :relationships, source: :users


  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction, length: { maximum: 50 }

   def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'

   end
end
