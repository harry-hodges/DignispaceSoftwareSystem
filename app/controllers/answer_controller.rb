class AnswerController < ApplicationController

  def get
    group = UserGroup.find_by(id: params[:id])
    return error_message "Unauthorized" unless can? :read, group

    role_obj = UserRole.find_by(user_id: current_user.id, user_group_id: params[:id])
    role = "NONE"
    if (role_obj != nil)
      role = role_obj.role
    end
    
    if role == "ROLE_VIEWER"
      if (group.content_released)
        answers = Answer.where(user_group_id: params[:id])

        result = []

        for answer in answers
          for bubble in answer.bubbles
            for user in bubble.all_users
              if (user['id'] == current_user.id)
                result += [answer]
              end
            end
          end
        end

        render :json => result, include: [:get_question]
      else
        render :json => []
      end
    else
      list = [:get_question, :audit_logs, :bubbles]
      if role == "ROLE_HEALTHCARE_PROFESSIONAL" || current_user.admin?
        list = [:get_question, :audit_logs, :bubbles, :flags]
      end
      render :json => Answer.where(user_group_id: params[:id]), include: list
    end
  end

  # edit an answer
  def put
    @bubble = Answer.find(params[:id])
    return error_message "Unauthorized" unless can? :edit, @bubble

    if @bubble.update(answer_params.except(:bubbles))
      @bubble.allowed_bubbles(params[:bubbles])

      AnswerProcessor.process(@bubble)

      @ale = AuditLogEntry.new
      @ale.action = "Answer Edited"
      @ale.details = "Answer edited by patient"
      @ale.answer_id = @bubble.id
      @ale.user_id = current_user.id
      @ale.save!

      render json: @bubble
    else
      render json: @bubble.errors, status: :unprocessable_entity
    end
  end

  # POST /answers
  def post
    return error_message "Unauthorized" unless can? :create, Answer
    @bubble = Answer.new(answer_params)
    @bubble.contents = "" # Force to be blank
    if @bubble.save
      # puts @bubble.id
      
      @ale = AuditLogEntry.new
      @ale.action = "Question added to user group"
      @ale.details = "Therapist has allowed user to answer this question"
      @ale.answer_id = @bubble.id
      @ale.user_id = current_user.id
      @ale.save!

      user_group = @bubble.user_group_id
      patient = UserRole.find_by(user_group_id: user_group, role: "ROLE_PATIENT")
      @not = Alert.new
      @not.active = true
      @not.description = "There is a new question you can answer"
      @not.high_priority = false
      @not.topic = "Question answers"
      @not.web_link = "https://example.com"
      @not.user_id = patient.user_id
      @not.save!

      render json: @bubble, status: :created
    else
      render json: @bubble.errors, status: :unprocessable_entity
    end
  end
  
  private  
      def answer_params
    params.permit(:id, :contents, :time, :question_id, :user_group_id, :bubbles=>[])
  end

end