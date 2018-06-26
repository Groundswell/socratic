class SocraticMigration < ActiveRecord::Migration[5.1]

	def change
		
		create_table 	:socratic_surveys, force: true do |t|
			t.string	:title
			t.string	:slug
			t.tiemstamps
		end

		create_table 	:socratic_surveyings, force: true do |t|
			t.references 	:user
			t.references 	:current_question
			t.references 	:furthest_question
			t.integer 		:score
			t.text 			:notes 
			t.datetime 		:completed_at
			t.timestamps
		end

		create_table 	:socratic_questions, force: true do |t|
			t.references 	:survey
			t.string 		:title 
			t.text 			:content
			t.string 		:question_type
			t.integer 		:seq
			t.boolean		:is_required
			t.timestamps
		end

		create_table 	:prompts, force: true do |t|
			t.references 	:question_id
			t.string 		:prompt_type, default: :radio
			t.text 			:content
			t.integer 		:seq
			t.integer 		:value
			t.boolean 		:is_correct
			t.timestamps
		end

		create_table 	:responses, force: true do |t|
			t.references 	:user
			t.references 	:surveying
			t.references 	:question
			t.references 	:prompt
			t.text 			:content
			t.dateime 		:started_at
			t.datetime 		:completed_at
			t.timestamps
		end

	end

end