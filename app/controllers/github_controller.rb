class GithubController < ApplicationController
	def initialize
		@github = Github.new :oauth_token => GITHUB_TOKEN
		super
	end
	
	def generaterepo
		begin
			user = view_context.get_session_user
			if user.level.to_s == "10" and params[:project_id]
				@github.repos.create :name => Project.find_by_id(params[:project_id]).title.split.join.downcase, :org => GITHUB_ORGANIZATION
				project = Project.find_by_id(params[:project_id])
				project.url = "https://github.com/#{GITHUB_ORGANIZATION}/#{Project.find_by_id(params[:project_id]).title.split.join.downcase}"
				project.save
				redirect_to "/projects/show/#{params[:project_id]}", :notice => "Created!"
			else
				redirect_to "/projects/show", :notice => "Something went wrong :("
			end
		rescue Exception => e
			puts e.inspect
			redirect_to "/projects/show/#{params[:project_id]}", :notice => "Something went wrong :("
		end
	end
	
	def view
		@err = nil
		begin
			if params[:name]
				repo = @github.repos.get(:user => GITHUB_ORGANIZATION, :repo => params[:name])
				@repo_exists = true
				@name = repo.name
				@description = repo.description
				@latest_commit = commits(params[:name]).first
				if params[:sha]
					@tree = tree(params[:name], params[:sha])
				else
					@tree = tree(params[:name])
				end
			end
		rescue Exception => e
			@err = e
			puts e.inspect
		end
	end
	
	def blob
		begin
			sha = JSON.parse(params[:sha])
			b = @github.git_data.blobs.get GITHUB_ORGANIZATION, params[:name], sha[-1]
			@content = Base64.decode64 b.content
		rescue Exception => e
			@content = nil
			puts e.inspect
		end
	end
	
	private
		def commits(repo_name)
			c = @github.repos.commits :user => GITHUB_ORGANIZATION, :repo => repo_name
			l = []
			c.list.each do |d|
				l << d.commit
			end
			return l
		end
	
		def tree(repo_name, sha = nil)
			if !sha or sha == "[]"
				x = @github.repos.commits :user => GITHUB_ORGANIZATION, :repo => repo_name # Get all commits
				y = x.list.first.commit # Get latest commit
				sha = [y.tree.sha]
			else
				sha = JSON.parse(sha)
			end
			z = @github.git_data.trees.get GITHUB_ORGANIZATION, repo_name, sha[-1]
			ret = []
			if sha.size > 1
				last = sha.pop
				ret << {"path" => "..", "sha" => sha.to_s}
				sha << last
			end
			z.tree.each do |el|
				sha << el.sha
				ret << {"path" => el.path, "sha" => sha.to_s, "type" => el.type}
				sha.pop
			end
			return ret
		end
end