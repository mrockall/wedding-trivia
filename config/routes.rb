Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/manage', as: 'rails_admin'

  post 'answer', to: 'application#answer'

  get 'details-of-the-day', to: 'application#details_of_the_day'
  get 'where-to-stay', to: 'application#where_to_stay'
  get 'rsvp', to: 'application#rsvp'

  get 'games', to: 'games#index'
  get 'games/start-over', to: 'games#start_over'
  get 'games/:key', to: 'games#game'
  get 'games/:key/submit-answer/:answer_id', to: 'games#submit_answer'

  root 'application#index'
end
