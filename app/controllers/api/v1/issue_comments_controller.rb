module Api::V1
  class IssueCommentsController < ApplicationController
    def show
      @issue_comment = IssueComment.find(params[:id])
      render :show, status: :ok
    end

    def index
      issue = Issue.find(params[:issue_id])
      @issue_comments = issue.issue_comments.limit(200)
      render :index, status: :ok
    end
  end
end

