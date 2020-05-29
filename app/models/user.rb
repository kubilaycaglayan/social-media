class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :invitations, class_name: 'Friendship', foreign_key: 'sender_id'
  has_many :pending_invitations, class_name: 'Friendship', foreign_key: 'receiver_id'

  def send_invitation(receiver)
    invitations.create(receiver_id: receiver.id)
  end

  def destroy_pending_invitation(sender)
    pending_invitation = pending_invitations.where(sender_id: sender.id)
    pending_invitation.destroy(pending_invitation.ids[0])
  end

  def accept_pending_invitation(sender)
    puts "Marios solution"
    p Invitation.status = true
  end
end
