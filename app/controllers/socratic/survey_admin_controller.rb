module Socratic
	class SurveyAdminController < ApplicationAdminController

		before_action :get_survey, except: [ :create, :index ]

		def create
			@survey = Survey.create( survey_params )
			redirect_to edit_survey_admin_path( @survey )
			#redirect_back fallback_location: '/survey_admin'
		end

		def destroy
			@survey.destroy
			redirect_to survey_admin_index_path
		end

		def edit

		end


		def index
			@surveys = Survey.all.page( params[:page] )
		end

		def responses
			@survey = Survey.friendly.find( params[:id] )
			@surveyings = @survey.surveyings.order( created_at: :desc ).page( params[:page] )
		end

		def update
			@survey.update( survey_params )
			redirect_back fallback_location: '/survey_admin'
		end


		private

			def get_survey
				@survey = Survey.friendly.find( params[:id] )
			end

			def survey_params
				params.require( :survey ).permit( :title, :description, :status, :preface, :thank_you_copy, :survey_type, :parent_obj_id, :parent_obj_type )
			end
	end
end