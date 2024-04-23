class BubbleController < ApplicationController
    def get
      return error_message "Unauthorized" unless can? :read, UserGroup.find_by(id: params[:id])
  
        data =  Bubble.where(user_group_id: params[:id])

        response = data.map {|x| x.as_json.merge({ all_users: x.all_users })}

        render json: response
    
    end
  
    def put
      @bubble = Bubble.find(params[:id])
      return error_message "Unauthorized" unless can? :update, @bubble
  
      if @bubble.update(bubble_params.except(:users))
        @bubble.users(params[:users])
        render json: @bubble
      else
        render json: @bubble.errors, status: :unprocessable_entity
      end
    end
  
    def post
      @bubble = Bubble.new(bubble_params.except(:users))
      return error_message "Unauthorized" unless can? :create, @bubble

      if @bubble.save
        @bubble.users(params[:users])
        render json: @bubble, status: :created
      else
        render json: @bubble.errors, status: :unprocessable_entity
      end
    end
    
    private  
    def bubble_params
      params.permit(:id, :name, :user_group_id, :users=>[])
    end
  
  end