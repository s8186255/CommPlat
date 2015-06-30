Rails.application.routes.draw do

  namespace :demo do
    resources :books
  end
  namespace :admin do
    resources :home, only: :index
    resources :info_types do
      resources :infos do
        member do
          put 'top'
        end
      end
    end
    resources :roles do
      member do
        post 'create_controller_permission'
        post 'create_info_permission'
        delete 'destroy_controller_permission'
        delete 'destroy_info_permission'
      end
    end
    resources :users do
      collection do
        get 'changepass'
      end
    end
    get 'permission_denied' => 'flash#permission_denied'
  end

  get 'error' => 'flash#error'

  devise_for :users, controllers: {
    registrations: "users/registrations",
    confirmations: "users/confirmations",
    passwords: "users/passwords",
    sessions: "users/sessions"
  }

  devise_scope :user do
    root :to => 'devise/sessions#new'
  end

  resources :home, only: :index do
  end


  namespace :users do
    get 'ok', to: "flash#ok"
    get 'agree', to: "flash#agree"
    resources :exhibitors, only: [:new, :create]
    resources :professional_visitors, only: [:new, :create]
  end

  namespace :attachment do
    post "/upload" => "assets#create"
    get  "/filemanager" => "assets#list"
  end

  get 'search', to: "search#index"
  get '/:type', to: "infos#index"
  get '/:type/infos/:id', to: "infos#show"

  namespace :card do
    resources :home do
      collection do
        get 'new_card'
      end

    end
    resources :self_apply_cards do
    end
    resources :make , only: :index do
      collection do
        get 'preview'
        get 'print'
        get 'printed'
      end
    end

    resources :applys do
      member do
        put 'apply'
      end
    end
    resources :card_types do
      collection do
        get 'new_step_one'
        post 'new_step_two'
      end
    end
    resources :payment_check do
      collection do
        get 'payments'
        get 'exhibitors'
        put 'exhibitor_finance_is_ok'
        get 'exhibitor_finance_is_not_ok'
        get 'unchecked_card_count', action: :unchecked_card_count
      end
    end
    resources :check do
      collection do
        get 'exhibitors'
        get 'exhibitors/:id', action: :show_exhibitor
        put 'exhibitor_is_ok'
        get 'exhibitor_is_not_ok'
        get 'cards'
        get 'cards/:id', action: :show_card
        put 'card_is_ok'
        get 'card_is_not_ok'
        #专业观众审核
        get 'self_apply_cards'
        get 'self_apply_cards/:id', action: :show_self_apply_card
        put 'self_apply_card_is_ok'
        get 'self_apply_card_is_not_ok'
        #get 'exhibitor_fee_list'
        #get 'exhibitor_fee_is_ok'
        #get 'exhibitor_fee_is_not_ok'
      end
    end
    resources :organizers
    resources :exhibitors
    resources :cards
    resources :expos do
      collection {get 'config_status'}
      member do
        put 'active'
      end
    end
    resources :make do
      collection do
        #专业观众待制卡 已制卡
        get 'self_index'
        get 'self_index_printed'
        get 'preview'
        get 'print'
        get 'self_print'
        get 'export'
        get 'self_export'
        get 'dl'
        get 'self_dl'
        get 'index_printed'
        get 'print_list'
      end
    end

    resources :payments

  end
  resources :step do
    collection do
      get 'step_one'
      get 'step_two'
    end
  end
end
