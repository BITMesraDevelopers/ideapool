class SourcesController < ApplicationController
	def initialize
		@github = Github.new :oauth_token => GITHUB_TOKEN
		super
	end
	
	def index
		@err = false
		begin
			repos = @github.repos.list :user => GITHUB_ORGANIZATION
			@orgrepos = []
			repos.each do |repo|
				@orgrepos << {"name" => repo.name, "description" => repo.description}
			end
		rescue Exception => e
			puts e.inspect
			@err = true
		end
	end
end
