class Question < ApplicationRecord

  belongs_to :game

  has_many :answers, dependent: :destroy
  has_many :enabled_answers, -> { where(enabled: true) }, class_name: 'Answer'

  has_one :correct_answer, -> { where(is_correct: true) }, class_name: 'Answer'

  validates_presence_of :game, :text

  def has_been_answered
    count_correct + count_incorrect > 0
  end

  def success_rate
    return 0 unless has_been_answered
    ((count_correct / (count_correct + count_incorrect).to_f) * 100).round
  end

  def get_answer_for_session(session_id)
    query = SubmittedAnswer.where(question_id: self.id)
    query = query.where(session_id: session_id.to_s)
    submitted_answer = query.first

    submitted_answer.answer
  end
end
